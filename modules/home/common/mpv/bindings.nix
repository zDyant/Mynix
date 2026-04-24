{
  programs.mpv.bindings = {
    "l" = "seek 5";
    "h" = "seek -5";
    "L" = "add speed 0.1";
    "H" = "add speed -0.1";
    "w" = "cycle-values speed 1 1.5 2";
    "CTRL+h" = "script-binding memo-history";

    "ALT+1" = "apply-profile fsr              ; show-text 'FSR Applied'             ";
    "ALT+2" = "apply-profile fsrcnnx          ; show-text 'FSRCNNX Applied'         ";
    "ALT+3" = "apply-profile nis              ; show-text 'NIS Applied'             ";
    "ALT+4" = "apply-profile anime4k          ; show-text 'ANIME4K Applied'         ";
    "ALT+5" = "apply-profile rescale-balanced ; show-text 'RESCALE-BALANCED Applied'";
    "ALT+6" = "apply-profile rescale-hq       ; show-text 'RESCALE-HQ Applied'      ";
    "ALT+7" = "apply-profile rescale-nnedi3   ; show-text 'RESCALE-NNEDI3 Applied'  ";
  };
}
