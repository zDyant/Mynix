{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    plugins = [
      pkgs.hyprlandPlugins.hypr-dynamic-cursors
    ];
    extraConfig = "

  plugin:dynamic-cursors {
    mode = stretch
    stretch {
    
      # controls how much the cursor is stretched
      # this value controls at which speed (px/s) the full stretch is reached
      # the full stretch being twice the original length
      limit = 3000

      # relationship between speed and stretch amount, supports these values:
      # linear             - a linear function is used
      # quadratic          - a quadratic function is used
      # negative_quadratic - negative version of the quadratic one, feels more aggressive
      # see `activation` in `src/mode/utils.cpp` for how exactly the calculation is done
      function = quadratic

      # time window (ms) over which the speed is calculated
      # higher values will make slow motions smoother but more delayed
      window = 200
    }
    # shaperule = clientside, none
  }

  ";
  };
}
