"""Run with python3 tests/repair_runtime.py [generated-config.json].

The optional JSON contains resticPrepare, resticCleanup, postgresPrepare, mpv,
and git from the evaluated host configuration; see docs/configuration-repairs.md.
All mutable state and mock programs are confined to a temporary directory.
"""
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import tomllib
import unittest

ROOT = Path(__file__).resolve().parents[1]
GENERATED = json.loads(Path(sys.argv.pop(1)).read_text()) if len(sys.argv) > 1 else None


class RuntimeTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="dots-repair-")
        self.addCleanup(self.tmp.cleanup)
        self.work = Path(self.tmp.name)
        self.env = dict(os.environ, PATH=f"{self.work}:{os.environ['PATH']}",
                        STATE=str(self.work / "state.json"), LOG=str(self.work / "log"))

    def mock(self, name, body):
        p = self.work / name
        p.write_text(f"#!{sys.executable}\n" + body)
        p.chmod(0o755)
        return p

    def run_script(self, script, *args, check=True, **env):
        return subprocess.run(["bash", str(script), *args], env=dict(self.env, **env),
                              check=check, capture_output=True, text=True)

    def test_volume_and_microphone(self):
        state = self.work / "state.json"
        state.write_text(json.dumps({"sink": [45, False], "source": [65, True]}))
        self.mock("pamixer", '''import json, os, sys
from pathlib import Path
p = Path(os.environ['STATE']); state = json.loads(p.read_text())
a = sys.argv[1:]; key = 'source' if '--default-source' in a else 'sink'
v, m = state[key]
if '--get-mute' in a: print(str(m).lower())
elif '--get-volume' in a: print(v)
else:
    if '-u' in a: m = False
    if '-t' in a: m = not m
    if '-i' in a: v += int(a[a.index('-i')+1])
    if '-d' in a: v -= int(a[a.index('-d')+1])
    state[key] = [v, m]; p.write_text(json.dumps(state))
''')
        self.mock("notify-send", '''import json, os, sys
with open(os.environ['LOG'], 'a') as f: f.write(json.dumps(sys.argv[1:])+'\\n')
sys.exit(1)  # Notification daemon unavailable.
''')
        script = ROOT / "hosts/gaia/home/hyprland/scripts/volume_control.sh"
        self.assertEqual(self.run_script(script, "--get-mic-icon").stdout.strip(),
                         "microphone-sensitivity-muted")
        self.run_script(script, "--toggle-mic")
        self.assertEqual(json.loads(state.read_text())["source"], [65, False])
        self.run_script(script, "--mic-inc")
        self.run_script(script, "--mic-dec")
        self.run_script(script, "--toggle")
        self.assertEqual(self.run_script(script, "--get").stdout.strip(), "Muted")
        self.run_script(script, "--inc")
        self.run_script(script, "--dec")
        self.assertEqual(self.run_script(script, "--get").stdout.strip(), "45%")
        for line in (self.work / "log").read_text().splitlines():
            args = json.loads(line)
            hint = next(a for a in args if a.startswith("int:value:"))
            self.assertRegex(hint, r"^int:value:\d+$")

    def test_portal_modes_and_cancellation(self):
        self.mock("kitty", '''import json, os, sys
from pathlib import Path
args = sys.argv[1:]
Path(os.environ['LOG']).write_text(json.dumps(args))
if os.environ.get('CANCEL') == '1': sys.exit(0)
if any(a.startswith('--cwd-file=') for a in args):
    out = next(a.split('=',1)[1] for a in args if a.startswith('--cwd-file='))
    Path(out).write_text(os.environ['SELECTED'])
else:
    out = next(a.split('=',1)[1] for a in args if a.startswith('--chooser-file='))
    Path(out).write_text(os.environ['SELECTED']+'\\n'+os.environ['SECOND']+'\\n')
''')
        script = ROOT / "modules/features/hyprland/portal/chooser.sh"
        folder = self.work / "a folder with spaces"
        folder.mkdir()
        out = self.work / "output file"
        extra = dict(PORTAL_DIRECTORY_CONFIG=str(ROOT / "modules/features/hyprland/portal"),
                     SELECTED=str(folder), SECOND=str(self.work / "second file"))
        for multiple, directory, save in [(0, 0, 0), (1, 0, 0), (0, 1, 0), (0, 0, 1)]:
            args = [str(multiple), str(directory), str(save), str(folder), str(out), "0"]
            self.run_script(script, *args, **extra)
            lines = out.read_text().splitlines()
            self.assertEqual(len(lines), 2 if multiple else 1)
            self.assertEqual(lines[0], str(folder))
            invocation = json.loads((self.work / "log").read_text())
            self.assertEqual(invocation[-1], str(folder))
            self.run_script(script, *args, **extra, CANCEL="1")
            self.assertEqual(out.read_text(), "")
        keymap = tomllib.loads((ROOT / "modules/features/hyprland/portal/keymap.toml").read_text())
        self.assertEqual(keymap['mgr']['prepend_keymap'][1]['run'], 'quit --no-cwd-file')

    @unittest.skipUnless(GENERATED, "Pass evaluated JSON to test backup and database scripts")
    def test_backup_cleanup_success_and_failure(self):
        log = self.work / "log"
        record = self.work / "active-services"
        self.mock("systemctl", '''import json, os, sys
args = sys.argv[1:]
with open(os.environ['LOG'], 'a') as f: f.write(json.dumps(args)+'\\n')
if args[0] == 'is-active': sys.exit(0 if args[-1] in ['glance.service', 'docker-openmonetis-db.service'] else 3)
if args[0] == 'stop' and os.environ.get('FAIL_STOP') == '1': sys.exit(1)
''')
        def rewrite(text):
            text = re.sub(r'/nix/store/[^\s]+/bin/systemctl', str(self.work / "systemctl"), text)
            return text.replace('/run/restic-backups-restic/active-services', str(record))
        cleanup = self.work / "cleanup"
        cleanup.write_text(rewrite(Path(GENERATED['resticCleanup']).read_text()))
        prepare = self.work / "prepare"
        prepare.write_text(rewrite(GENERATED['resticPrepare']).replace(GENERATED['resticCleanup'],
                                                                     f"bash {cleanup}"))
        for failed in [False, True]:
            log.write_text('')
            result = self.run_script(prepare, check=False, FAIL_STOP='1' if failed else '0')
            self.assertEqual(result.returncode != 0, failed)
            self.run_script(cleanup)
            calls = [json.loads(l) for l in log.read_text().splitlines()]
            start = next(c for c in calls if c[0] == 'start')
            self.assertEqual(start[1:], ['docker-openmonetis-db.service', 'glance.service'])
            self.assertFalse(record.exists())

    @unittest.skipUnless(GENERATED, "Pass evaluated JSON to test backup and database scripts")
    def test_postgres_readiness(self):
        docker = self.mock('docker', '''import os, sys
from pathlib import Path
p=Path(os.environ['LOG']); n=int(p.read_text())+1 if p.exists() else 1
p.write_text(str(n)); sys.exit(0 if n >= int(os.environ['READY_AT']) else 1)
''')
        self.mock('sleep', 'pass\n')
        script = self.work / 'readiness'
        script.write_text(re.sub(r'/nix/store/[^\s]+/bin/docker', str(docker), GENERATED['postgresPrepare']))
        self.run_script(script, READY_AT='3')
        self.assertEqual((self.work / 'log').read_text(), '3')
        (self.work / 'log').unlink()
        result = self.run_script(script, check=False, READY_AT='100')
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual((self.work / 'log').read_text(), '60')
        self.assertIn('120 seconds', result.stderr)

    @unittest.skipUnless(GENERATED, "Pass evaluated JSON to test generated Git and MPV settings")
    def test_git_and_shader_profiles(self):
        env = dict(self.env, GIT_CONFIG_GLOBAL=GENERATED['git'], GIT_CONFIG_NOSYSTEM='1')
        url = subprocess.check_output(['git', 'ls-remote', '--get-url', 'gh:zdyant/dots'], env=env, text=True)
        self.assertEqual(url.strip(), 'git@github.com:zdyant/dots')
        text = Path(GENERATED['mpv']).read_text()
        profiles = re.findall(r'^\[([^]]+)\]', text, re.M)
        self.assertEqual(len(profiles), 7)
        for line in text.splitlines():
            if line.startswith('glsl-shaders='):
                paths = re.sub(r'^glsl-shaders=%\d+%', '', line).split(':')
                for path in paths:
                    self.assertTrue(Path(path).is_file(), path)
        for profile in profiles:
            output = subprocess.check_output(['mpv', '--no-config', '--include='+GENERATED['mpv'],
                                              '--show-profile='+profile], text=True, stderr=subprocess.STDOUT)
            self.assertIn('vo='+('gpu-next' if profile == 'rescale-nnedi3' else 'gpu')+'\n', output)


if __name__ == '__main__':
    unittest.main()
