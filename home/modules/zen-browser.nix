{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  xdg.desktopEntries.zen-youtube = {
    name = "YouTube";
    exec = "zen-beta";
    icon = ../../resources/youtube.png;
    comment = "YouTube in Zen Browser";
    categories = [
      "Network"
      "Video"
    ];
  };

  programs.zen-browser = {
    enable = true;
    package = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta;
    profiles."Default User" = {
      id = 0;
      name = "Default User";
      isDefault = true;
      settings = {
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.tabs.inTitlebar" = 0;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.startup.homepage" = "https://www.youtube.com";
        "extensions.autoDisableScopes" = 0;
      };
    };
  };
}
