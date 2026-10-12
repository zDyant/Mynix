# Configuration repairs and rollout

Both hosts rebuild from `/repos/dots`; Mix's per-host `specialArgs.flakePath`
can override this path. The standalone bootstrap shell is `nix-shell -A default`.
`nix develop` retains the pre-commit hooks. Statix is available for advisory checks.

## Before deploying Hephaestus

Provision these files on the server, owned by root with mode 0600. Do not put their
contents in Nix, Git, or the Nix store. The configuration fixes permissions on
existing files and deliberately does not create secret contents.

| File | Required variables |
| --- | --- |
| `/var/lib/kutt/secrets.env` | `JWT_SECRET` |
| `/var/lib/openmonetis/app.env` | `BETTER_AUTH_SECRET`, `DATABASE_URL` |
| `/var/lib/openmonetis/postgres.env` | `POSTGRES_USER`, `POSTGRES_DB`, `POSTGRES_PASSWORD` |

Use Docker environment-file syntax (`KEY=value`, no `export`, no shell quoting).
The application database URL must use host `openmonetis-db`, port 5432, and
credentials matching the PostgreSQL file. URL-encode special characters in URL
credentials. Keep the existing database user, password, and database name when
provisioning files for an existing installation: PostgreSQL initialization
variables only initialize an empty data directory; changing them does not rotate
existing credentials. The database stays PostgreSQL 16 with the same bind mount.
The application waits up to 120 seconds for PostgreSQL TCP readiness. Readiness
is distinct from a successful application login; validate both before deployment.

No activation, service restart, database migration, or deployment is part of this
repair pass. Existing images and volumes are preserved. Follow-up deployment
concerns: `kutt/kutt:main`, `felipegcoutinho/openmonetis:main`, and
`postgres:16-alpine` are mutable tags. The OpenMonetis application mount
`/var/lib/openmonetis` remains an anonymous container volume; inspect its actual
contents and arrange a migration/backup separately before changing it.

## Desktop behavior

The file portal uses Yazi with the pinned six-argument interface. For folder
selection, navigate to the folder and press `s` to confirm; `q` cancels. File
selection retains Yazi's normal chooser controls. Saving uses the portal's default
suggested-file helper and chooses one output path.
Wallpaper Engine stays installed; its service defaults to enabled only after
wallpapers are configured and inherits the graphical session environment.
MPV keeps `gpu` as its default; only NNEDI3 selects `gpu-next`, and selecting any
other shader profile restores `gpu`.

## Backup recovery

Gaia continues `rclone copy` (no remote deletion) and includes repository `.git`
history. Homelab backups include the real `/var/lib/private` state of Glance,
Karakeep's browser, and Meilisearch, as well as the existing service data paths.
Before backup, active service names are recorded in the Restic runtime directory.
Cleanup runs through `ExecStopPost`, including failures, and starts only recorded
services. Failed restart retains that record for recovery on the next run.
After restoration, verify repository history with `git fsck` and check service
state files before starting services. Copies of runtime secret files are private
backup data and must be protected along with the Restic repository password.

## Review candidates retained

No applications were removed. Consider reviewing server-wide desktop fonts,
globally installed Wayland development libraries, overlapping browsers and music
clients, alternate icon themes, and overlapping Nix/Docker cleanup policies.
Repository presence does not establish that these are unused.

## Verification

Both Gaia and Hephaestus system closures built without lockfile writes or
activation. The Git-backed `nix flake check --no-write-lock-file` passed every
existing hook, including formatting, Deadnix, ShellCheck, and shfmt. Statix has no
new diagnostics relative to HEAD; existing advisory style warnings remain.
Isolated probes passed for Homelab parent-disable, Ollama, n8n, and Affinity.

Generated Git settings contain the intended `[init]`, `[pull]`, and `[core]`
sections; `git ls-remote --get-url gh:zdyant/dots` resolves locally to the correct
SSH URL. Hephaestus still excludes personal Git identity. Betterfox's cache-disable
preference appears before the explicit cache-enable preference in Floorp's
`user.js`. Hyprland's verifier reports `config ok`. MPV parses all seven profiles,
with shader files present, ordered shader chains, and the expected renderers.
Desktop entries validate and every MIME default has an installed handler. The
validator emits existing advisory warnings for Steam's deprecated KDE key and
Ryubing's repeated descriptive text.

Fresh PostgreSQL 16, OpenMonetis, and Kutt started in disposable Docker containers
using environment files and matching credentials, without published ports or host
state mounts; the test removed the containers, anonymous volumes, and network.
The generated Gaia copy script restored a fixture repository including its Git
history and passed `git fsck --full`. A local encrypted Restic snapshot restored
representative files for every configured service state path. These checks do not
replace validating the production runtime credentials before deployment.
