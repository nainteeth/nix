{
  ...
}:

{
  programs.qutebrowser = {
    enable = true;

    settings = {
      tabs = {
        # Tabs
        show = "always";
        position = "left";
        width = "15%";
        title.format = "{index}: {audio}{current_title}";
        last_close = "close";
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
  };
}
