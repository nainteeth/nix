# Shared home configuration for all NixOS hosts (not standalone Home Manager systems).
# Things here are not intended to be (swapped out)/toggled.
# For swappable configs (editors, browsers...) use a module instead.
{
  pkgs,
  username,
  nix-flatpak,
  ...
}:
{
  imports = [
    ../modules/zen-browser.nix

    # ../modules/noctalia.nix
    ../modules/waybar.nix
    ../modules/wofi.nix
    # ../modules/mako.nix
    ../modules/waypaper.nix
    ../modules/themes.nix

    ../modules/neovim.nix
    # ../modules/helix.nix

    ../modules/hyprland.nix
    # ../modules/wayfire.nix

    ../modules/kitty.nix
    ../modules/yazi.nix

    nix-flatpak.homeManagerModules.nix-flatpak
  ];

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";

    packages = with pkgs; [
      # Terminal
      starship

      gh
      nodejs

      # Media
      playerctl
      pamixer
      pavucontrol
      uxplay
      vlc
      mpv

      element-desktop

      # Browsers
      chromium

      # Text editor
      jetbrains.idea

      # System utilities
      btop
      htop
      # fastfetch
      nitch # minimal, aesthetic fetch
      onefetch # git repo fetch
      cpufetch # CPU fetch

      # Archive tools
      unzip # .zip extraction
      zip # .zip creation
      p7zip # for a bunch of other formats
      unrar # .rar extraction

      # CLI tools
      ripgrep
      bat
      wget
      curl

      # r/unixporn eye candy
      pipes # run with: pipes.sh
      cmatrix # matrix rain
      cbonsai # grow bonsai trees
      lolcat # rainbow text
      figlet # ASCII banners
      toilet # colored ASCII art
      asciiquarium # terminal aquarium
      tty-clock # terminal clock
      sl # steam locomotive (typo punishment)
      cowsay # talking cow
      fortune # random quotes

      # Other
      keepassxc
      gnupg
      signal-desktop

      # Fonts
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      nerd-fonts.meslo-lg
      nerd-fonts.symbols-only
      nerd-fonts.ubuntu-mono

      # Theming
      adwaita-icon-theme
      gnome-themes-extra
    ];
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE = "24";
    };
  };

  gtk = {
    enable = true;
    theme.name = "Adwaita";
    iconTheme.name = "Adwaita";
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
  };
  xdg.configFile = {
    "gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Adwaita
      gtk-icon-theme-name=Adwaita
      gtk-cursor-theme-name=Adwaita
      gtk-cursor-theme-size=24
    '';
    "gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Adwaita
      gtk-icon-theme-name=Adwaita
      gtk-cursor-theme-name=Adwaita
      gtk-cursor-theme-size=24
    '';
  };

  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "nainteeth";
        user.email = "knusperpommes@gmail.com";
      };
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
    bash = {
      enable = true;
      initExtra = ''
        ssh-add -l &>/dev/null || ssh-add ~/.ssh/github 2>/dev/null
      '';
      shellAliases = {
        rebuild = "git -C ~/nix add . && sudo nixos-rebuild switch --flake ~/nix#$(hostname)";
      };
    };

    # fuzzy find ctrl r (bash history)
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
    # fancy ls
    eza = {
      enable = true;
      enableBashIntegration = true;
      git = true;
      icons = "auto";
      extraOptions = [
        "--long"
        "--header"
      ];
    };
    lazygit = {
      enable = true;
      settings = {
        customCommands = [
          {
            key = "R";
            command = "sudo nixos-rebuild switch --flake ~/nix#$(hostname)";
            context = "global";
            description = "NixOS rebuild";
            output = "terminal";
          }
          {
            key = "U";
            command = "cd $HOME/nix && sudo nix flake update";
            context = "global";
            description = "Flake update";
            output = "terminal";
          }
        ];
      };
    };
  };
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = false; # Only manages user packages
    packages = [
      "com.discordapp.Discord"
      "com.bambulab.BambuStudio"
    ];
    overrides = {
      "com.discordapp.Discord" = {
        Context.filesystems = [
          "xdg-run/pipewire-0"
        ];
        Environment.XDG_SESSION_TYPE = "wayland";
        Context.sockets = [
          "wayland"
          "x11"
          "pulseaudio"
        ];
        "Session Bus Policy" = {
          "org.freedesktop.portal.Desktop" = "talk";
        };
      };
      "com.bambulab.BambuStudio" = {
        Environment = {
          GDK_SCALE = "1";
          GDK_DPI_SCALE = "1";
          QT_SCALE_FACTOR = "1";
        };
      };
    };
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
  };
}
