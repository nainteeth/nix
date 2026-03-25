# browser.tabs.allow_transparent_browser und zen.widget.linux.transparency
# müssen manuell in about:config auf true gesetzt werden.
# Diese Settings werden von Zen beim Beenden überschrieben und lassen sich
# nicht deklarativ erzwingen. Einmalig setzen, danach bleiben sie erhalten
{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "zen-beta.desktop";
        "x-scheme-handler/http" = "zen-beta.desktop";
        "x-scheme-handler/https" = "zen-beta.desktop";
        "x-scheme-handler/about" = "zen-beta.desktop";
        "x-scheme-handler/unknown" = "zen-beta.desktop";
      };
    };
  };

  programs.zen-browser = {
    enable = true;
    package = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta;
    profiles."Default User" = {
      id = 0;
      name = "Default User";
      isDefault = true;
      settings = {
        "browser.newtabpage.enabled" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "zen.urlbar.replace-newtab" = false;
        "browser.urlbar.suggest.searches" = true;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.startup.homepage" = "about:home";

        # Das funktioniert leider nicht
        "browser.tabs.allow_transparent_browser" = true;
        "zen.widget.linux.transparency" = true;

        "zen.view.grey-out-inactive-windows" = false;
      };

      # Zen Mods - UUIDs vom Zen Theme Store
      mods = [
        "642854b5-88b4-4c40-b256-e035532109df" # Zen Glass (transparent)
      ];

      search = {
        force = true;
        default = "google";
        engines = {
          "My NixOS" = {
            urls = [ { template = "https://mynixos.com/search?q={searchTerms}"; } ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nx" ];
          };
        };
      };
      pinsForce = true;
      pins = {
        "YouTube" = {
          id = "4a076324-af74-4afc-ac1d-79e02a7175f1";
          url = "https://youtube.com";
          position = 100;
          isEssential = true;
        };
        "Github" = {
          id = "b67dc40c-a636-444f-a640-3899b386eb96";
          url = "https://github.com";
          position = 101;
          isEssential = true;
        };
        "Claude" = {
          id = "1e5184a8-6c92-4621-ab3d-b86c19714c7f";
          url = "https://claude.ai";
          position = 102;
          isEssential = true;
        };
        "Gmail" = {
          id = "9bf91cfc-a994-4a27-99c1-0046363cb9f7";
          url = "https://mail.google.com";
          position = 103;
          isEssential = true;
        };
        "Google Gemini" = {
          id = "f6c77c9b-2514-488e-9a63-ff7241ae4046";
          url = "https://gemini.google.com";
          position = 104;
          isEssential = true;
        };
        "Gymbo Untis" = {
          id = "59834da1-1b04-4dd5-bd10-35a982a0a417";
          url = "https://borbeck-gym.webuntis.com/WebUntis/?school=borbeck-gym#/basic/login";
          position = 105;
          isEssential = true;
        };
        "MGB Untis" = {
          id = "ca42d7d6-8602-44df-b52c-137a6c0b6175";
          url = "https://maedchengym-borbeck.webuntis.com/WebUntis/#/basic/login";
          position = 106;
          isEssential = true;
        };
        "Logineo" = {
          id = "a2fb5eab-5f36-413c-a680-2679f17f87e6";
          url = "https://164859.logineonrw-lms.de/login/index.php";
          position = 107;
          isEssential = true;
        };
      };
    };
  };
}
