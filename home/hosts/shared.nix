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
    ../modules/firefox.nix

    # ../modules/noctalia.nix
    ../modules/waybar.nix
    ../modules/wofi.nix
    ../modules/mako.nix
    ../modules/waypaper.nix
    ../modules/themes.nix

    ../modules/neovim.nix
    # ../modules/helix.nix

    # ../modules/hyprland.nix
    ../modules/swayfx.nix
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
      nitch
      onefetch
      cpufetch

      # Archive tools
      unzip
      zip
      p7zip
      unrar

      # CLI tools
      ripgrep
      bat
      wget
      curl

      # r/unixporn eye candy
      pipes
      cmatrix
      cbonsai
      lolcat
      figlet
      toilet
      asciiquarium
      tty-clock
      sl
      cowsay
      fortune

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
      bibata-cursors
    ];

    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
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
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
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
    uninstallUnmanaged = false;
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
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "thunar.desktop";
        "text/plain" = "org.gnome.TextEditor.desktop";
        "text/markdown" = "org.gnome.TextEditor.desktop";
        "text/x-script" = "org.gnome.TextEditor.desktop";
      };
    };
  };
}
