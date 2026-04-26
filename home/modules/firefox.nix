{ pkgs, ... }:
{
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };

  programs.firefox = {
    enable = true;

    policies = {
      SearchEngines = {
        Default = "Google";
        PreventInstalls = true;
      };

      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFeedbackCommands = true;

      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";

      UserMessaging = {
        WhatsNew = false;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
      };

      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = false;
      };
    };

    profiles = {
      default = {
        name = "default";
        isDefault = true;

        settings = {
          "sidebar.verticalTabs" = true;
          "sidebar.visibility" = "always-show";
        };

        bookmarks = {
          force = true;
          settings = [
            {
              name = "YouTube";
              url = "https://youtube.com";
            }
            {
              name = "Github";
              url = "https://github.com";
            }
            {
              name = "Claude";
              url = "https://claude.ai";
            }
            {
              name = "Gemini";
              url = "https://gemini.google.com";
            }
            {
              name = "Gmail";
              url = "https://mail.google.com";
            }
            {
              name = "Calendar";
              url = "https://calendar.google.com/calendar";
            }
            {
              name = "Gymbo Untis";
              url = "https://borbeck-gym.webuntis.com/WebUntis/?school=borbeck-gym#/basic/login";
            }
            {
              name = "MGB Untis";
              url = "https://maedchengym-borbeck.webuntis.com/WebUntis/#/basic/login";
            }
            {
              name = "Logineo";
              url = "https://164859.logineonrw-lms.de/login/index.php";
            }
          ];
        };
      };
    };
  };
}
