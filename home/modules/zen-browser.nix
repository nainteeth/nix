{ pkgs, inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.default
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-browser.desktop";
      "x-scheme-handler/http" = "zen-browser.desktop";
      "x-scheme-handler/https" = "zen-browser.desktop";
      "x-scheme-handler/about" = "zen-browser.desktop";
      "x-scheme-handler/unknown" = "zen-browser.desktop";
    };
  };

  programs.zen-browser = {
    enable = true;
    package = inputs.zen-browser.packages.${pkgs.system}.default;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      settings = {
        "zen.urlbar.replace-newtab" = false;
        "browser.startup.homepage" = "about:home";
        "browser.newtabpage.enabled" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.urlbar.suggest.searches" = true;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;

        # Telemetry
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.server" = "";

      search = {
        force = true;
        default = "ddg";
        engines = {
          "My NixOS" = {
            urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nx"];
          };
        };
      };
    };
  };
};
}
