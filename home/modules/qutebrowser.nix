{
  ...
}:

{
  programs.qutebrowser = {
    enable = true;

    settings = {
      tabs = {
        # Tabs
        show = "multiple";
        position = "left";
        width = "15%";
        title.format = "{index}: {audio}{current_title}";
        last_close = "close";

        # Tab unloading
        unload.exclude = [ ];
      };

      # Fonts
      fonts.default_family = "monospace";
      fonts.default_size = "11pt";

      # UI
      statusbar.show = "always";
      scrolling.smooth = true;
      content = {
        # Privacy
        cookies.accept = "no-3rdparty";
        geolocation = false;
        notifications.enabled = false;

        # Performance
        prefers_reduced_motion = true;
      };
    };

    keyBindings = {
      normal = {
        # Tab management
        "<Alt-1>" = "tab-focus 1";
        "<Alt-2>" = "tab-focus 2";
        "<Alt-3>" = "tab-focus 3";
        "xt" = "tab-give";
        "xb" = "tab-pin";
        # Tab unloading (manually discard a tab)
        "td" = "tab-discard";
        # Quick search
        "s" = "cmd-set-text :open -s ";
        # Passthrough mode toggle
        "<Ctrl-p>" = "mode-enter passthrough";
      };
    };

    searchEngines = {
      DEFAULT = "https://www.google.com/search?q={}";
      "!nix" = "https://search.nixos.org/packages?query={}";
    };

    extraConfig = ''
      # Discard all background tabs after 30 minutes of inactivity
      c.tabs.unload.exclude = []
      import subprocess, os

      # Dim the tab bar for unloaded tabs
      c.colors.tabs.bar.bg = "#1a1a1a"

      # Auto-discard tabs after 30 min (requires qutebrowser >= 3.x)
      # c.tabs.unload.interval = 1800
    '';
  };
}
