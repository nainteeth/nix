{
  pkgs,
  ...
}:
let
  wallpaper = ../../resources/wallpaper/nixos-monochrome.png;

  customAstronautTheme = (pkgs.sddm-astronaut.override {
    themeConfig = {
      Background = "Backgrounds/custom.png";
      FormPosition = "left";
      CropBackground = "true";
      PartialBlur = "true";
    };
  }).overrideAttrs (old: {
    installPhase = old.installPhase + ''
      chmod -R u+w $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds
      cp ${wallpaper} $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/custom.png
    '';
  });
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs.kdePackages; [
      qtmultimedia
      qtsvg
      qtvirtualkeyboard
    ];
  };

  environment.systemPackages = [ customAstronautTheme ];
}
