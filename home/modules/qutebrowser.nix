{ pkgs, ... }:
{
  programs.qutebrowser = {
    enable = true;

    extraConfig = ''
      c.url.searchengines = {
        "DEFAULT": "https://duckduckgo.com/?q={}",
        "gh": "https://github.com/search?q={}",
        "nx": "https://mynixos.com/search?q={}",
      }
    '';

    settings = {
      tabs.show = "always";
      tabs.position = "left";
      tabs.width = "10%";
      tabs.title.format = "{audio}{index}: {current_title}";
      tabs.favicons.show = "always";

      fonts.default_family = "JetBrainsMono Nerd Font";
      fonts.default_size = "11pt";

      scrolling.smooth = true;
      scrolling.bar = "never";

      completion.height = "30%";
      completion.use_best_match = true;

      content.blocking.enabled = true;
      content.blocking.method = "both";
      content.geolocation = false;
      content.cookies.accept = "no-3rdparty";
      content.javascript.clipboard = "none";

      hints.mode = "letter";
      hints.uppercase = false;

      colors.webpage.preferred_color_scheme = "dark";
    };
    keyBindings = {
      normal = {
        "<Alt-l>" = "spawn --userscript qute-keepassxc --insecure";
      };
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
    };
  };
  home.file.".config/qutebrowser/quickmarks".text = ''
    youtube https://youtube.com
    github https://github.com
    claude https://claude.ai
    gmail https://mail.google.com
    gemini https://gemini.google.com
    gymbo https://borbeck-gym.webuntis.com/WebUntis/?school=borbeck-gym#/basic/login
    mgb https://maedchengym-borbeck.webuntis.com/WebUntis/#/basic/login
    logineo https://164859.logineonrw-lms.de/login/index.php
  '';
}
