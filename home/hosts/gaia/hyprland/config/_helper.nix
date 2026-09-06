{lib}: rec {
  # https://github.com/krezh/dotnix/blob/02d720e8c9388aeeafc74887ba5a0df614ea6216/modules/programs/windowManagers/hyprland/_helpers.nix
  inherit (lib) elemAt length;

  lua = lib.generators.mkLuaInline;
  # bind = key: action: {_args = [key (lua action)];};
  bind = key: action: {
    __functor = self: flags: {_args = [key (lua action) flags];};
    _args = [key (lua action) {}];
  };
  exec = cmd: "hl.dsp.exec_cmd(${builtins.toJSON cmd})";
  execHook = cmd: ''hl.exec_cmd("${cmd}")'';

  func = body: "function()\n${body}\nend";
  mkArgs = args: {_args = args;};

  focus = action:
    if builtins.isInt action
    then ''hl.dsp.focus({ workspace = "${toString action}" })''
    else ''hl.dsp.focus({ direction = "${action}" })'';

  mv = action:
    if builtins.isInt action
    then ''hl.dsp.window.move({ workspace = "${toString action}", follow = false})''
    else ''hl.dsp.window.move({ direction = "${action}", group_aware = true})'';

  mvxy = dispatcher: x: y: "hl.dsp.window.${dispatcher}({ x = ${toString x}, y = ${toString y}, relative = true })";

  on_startup = targets: [
    (mkArgs ["hyprland.start" (lua (func (lib.concatStringsSep "\n" (map (t: execHook t) targets))))]) #omg
  ];

  mkEnv = lib.mapAttrsToList (
    name: value:
      mkArgs [
        name
        (toString value)
      ]
  );

  fields = s: map lib.trim (lib.splitString "," s);
  # "0.05" → 0.05, "1" → 1, "1.0" → 1.0 (kept distinct so the Lua matches).
  num = builtins.fromJSON;
  mkCurves = {
    bezier ? {},
    spring ? {},
  }: let
    parse = kind: count: build: name: spec: let
      n = map num (fields spec);
    in
      if length n != count
      then throw "hyprland: ${kind} \"${name}\" needs ${toString count} numbers, got \"${spec}\""
      else build n;
    beziers =
      lib.mapAttrs (parse "bezier" 4 (n: {
        type = "bezier";
        points = [
          [
            (elemAt n 0)
            (elemAt n 1)
          ]
          [
            (elemAt n 2)
            (elemAt n 3)
          ]
        ];
      }))
      bezier;
    springs =
      lib.mapAttrs (parse "spring" 3 (n: {
        type = "spring";
        mass = elemAt n 0;
        stiffness = elemAt n 1;
        dampening = elemAt n 2;
      }))
      spring;
  in
    lib.mapAttrsToList (
      name: spec:
        mkArgs [
          name
          spec
        ]
    ) (beziers // springs);

  # ------------------------------------------------------------------------------------------
  mkAnimations = map (
    spec: let
      f = fields spec;
      leaf = elemAt f 0;
    in
      if
        f
        == [
          leaf
          "off"
        ]
      then {
        inherit leaf;
        enabled = false;
      }
      else if length f < 3 || length f > 4
      then throw "hyprland: animation \"${spec}\" must be \"leaf, speed, kind:curve[, style]\" or \"leaf, off\""
      else let
        curve = lib.splitString ":" (elemAt f 2);
        kind = elemAt curve 0;
      in
        if
          length curve
          != 2
          || !(builtins.elem kind [
            "bezier"
            "spring"
          ])
        then throw "hyprland: animation \"${spec}\" must name its curve as bezier:<name> or spring:<name>"
        else
          {
            inherit leaf;
            enabled = true;
            speed = num (elemAt f 1);
            ${kind} = elemAt curve 1;
          }
          // lib.optionalAttrs (length f == 4) {style = elemAt f 3;}
  );
  # ------------------------------------------------------------------------------------------
  # Expand any rule whose `match` has a list-valued field into one rule per
  # value (recursively, so several list fields produce the full product).
  expandRules = rules:
    lib.concatMap (
      rule: let
        m = rule.match or {};
        listField = lib.findFirst (n: lib.isList m.${n}) null (lib.attrNames m);
      in
        if listField == null
        then [rule]
        else
          expandRules (
            map (
              v:
                rule
                // {
                  match =
                    m
                    // {
                      ${listField} = v;
                    };
                }
            )
            m.${listField}
          )
    )
    rules;

  # Build the whole window-rule list from one config.
  #
  #   tags.<name>.anyOf = { field = value; … }
  #       Each field on its own is enough to earn the tag (OR). A list value
  #       is also OR, one alternative per element.
  #   tags.<name>.allOf = [ { field = value; … } ]
  #       Every field of a set must hold together (AND). One set per way in.
  #   tags.<name>.apply = { …props }
  #       Applied to every window carrying the tag.
  #
  #   rules = [ { match = { … }; …props } ]
  #       Standalone rules, no tag. Fields inside `match` are AND. Order is
  #       kept, since Hyprland applies rules top-to-bottom.
  #
  # A list value anywhere in a `match` expands to one rule per element.
  mkRules = let
    toList = x:
      if lib.isList x
      then x
      else [x];
  in
    {
      tags ? {},
      rules ? [],
    }: let
      defs = lib.concatLists (
        lib.mapAttrsToList (
          tag: spec:
            lib.concatLists (
              lib.mapAttrsToList (
                field: vals:
                  map (v: {
                    match.${field} = v;
                    tag = "+${tag}";
                  }) (toList vals)
              ) (spec.anyOf or {})
            )
            ++ map (m: {
              match = m;
              tag = "+${tag}";
            }) (spec.allOf or [])
        )
        tags
      );
      applies = lib.concatLists (
        lib.mapAttrsToList (
          tag: spec: lib.optional (spec ? apply) ({match.tag = tag;} // spec.apply)
        )
        tags
      );
    in
      expandRules (defs ++ applies ++ rules);
}
