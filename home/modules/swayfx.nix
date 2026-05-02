{ pkgs, lib, ... }:

let
  mod = "Mod4";
in
{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
  ];
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;
    wrapperFeatures.gtk = true;

    config = {
      modifier = mod;
      terminal = "kitty";
      menu = "wofi --show drun";
      defaultWorkspace = "workspace number 1";

      left = "h";
      right = "l";
      up = "k";
      down = "j";

      input = {
        "type:keyboard" = {
          xkb_layout = "de";
          xkb_options = "ctrl:nocaps";
        };
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
        "type:touchpad" = {
          natural_scroll = "disabled";
        };
      };

      output = {
        "DP-2" = {
          mode = "1920x1080@240Hz";
          pos = "1920 0";
          scale = "1";
        };
        "DP-1" = {
          mode = "3840x2160@60Hz";
          pos = "0 0";
          scale = "2";
        };
      };

      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "DP-1";
        }
        {
          workspace = "2";
          output = "DP-1";
        }
        {
          workspace = "3";
          output = "DP-1";
        }
        {
          workspace = "4";
          output = "DP-1";
        }
        {
          workspace = "5";
          output = "DP-1";
        }
        {
          workspace = "6";
          output = "DP-2";
        }
        {
          workspace = "7";
          output = "DP-2";
        }
        {
          workspace = "8";
          output = "DP-2";
        }
        {
          workspace = "9";
          output = "DP-2";
        }
        {
          workspace = "10";
          output = "DP-2";
        }
      ];

      gaps = {
        inner = 8;
        outer = 16;
      };

      window = {
        border = 2;
        titlebar = false;
      };

      floating = {
        border = 2;
        titlebar = false;
      };

      focus.followMouse = true;

      assigns = {
        "1" = [ { app_id = "emacs"; } ];
        "3" = [ { app_id = "com.discordapp.Discord"; } ];
        "5" = [
          { app_id = "gimp"; }
          { app_id = "signal"; }
          { app_id = "spotify"; }
        ];
        "6" = [ { class = "Minecraft.*"; } ];
        "10" = [
          { app_id = "steam"; }
          { app_id = "net.lutris.Lutris"; }
          { app_id = "osu!"; }
        ];
      };

      floating.criteria = [
        { app_id = "org.pulseaudio.pavucontrol"; }
        { app_id = "nm-connection-editor"; }
      ];

      startup = [
        { command = "kitty --class lazygit-nix sh -c 'cd ~/nix && lazygit'"; }
        { command = "keepassxc"; }
        { command = "mako"; }
        { command = "nm-applet"; }
        { command = "swww-daemon"; }
        { command = "sleep 1 && waybar"; }
        { command = "signal-desktop"; }
        { command = "xrdb -merge ~/.Xresources"; }
        { command = "input-remapper-control --command autoload"; }
        { command = "gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Classic'"; }
        { command = "gsettings set org.gnome.desktop.interface cursor-size 24"; }
        { command = "gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita:dark'"; }
        {
          command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DBUS_SESSION_BUS_ADDRESS";
        }
      ];

      keybindings = lib.mkOptionDefault {
        "${mod}+Return" = "exec kitty";
        "${mod}+q" = "kill";
        "${mod}+e" = "exec thunar";
        "${mod}+v" = "floating toggle";
        "${mod}+b" = "exec firefox";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+space" = "exec wofi --show drun";
        "${mod}+t" = "exec ~/.config/themes/switch-theme.sh";
        "${mod}+w" = "exec ~/.config/waybar/scripts/switch_theme.sh";

        "${mod}+h" = "focus left";
        "${mod}+l" = "focus right";
        "${mod}+k" = "focus up";
        "${mod}+j" = "focus down";

        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+j" = "move down";

        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+0" = "move container to workspace number 10";

        "${mod}+ctrl+l" = "workspace next";
        "${mod}+ctrl+h" = "workspace prev";
        "${mod}+ctrl+shift+l" = "move container to workspace next";
        "${mod}+ctrl+shift+h" = "move container to workspace prev";

        "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl -e4 -n2 set 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl -e4 -n2 set 5%-";

        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPause" = "exec playerctl play-pause";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPrev" = "exec playerctl previous";

        "Print" =
          "exec grim -g \"$(slurp)\" - | tee ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy && notify-send 'Screenshot taken'";
      };

      bars = [ ];
    };

    extraConfig = ''
      # Animations are added in a later update
      # animations enable 
      corner_radius 18

      blur enable
      blur_passes 3
      blur_radius 9

      shadows enable
      shadow_blur_radius 20
      shadow_color #1a1a1aee
      shadow_offset 0 4

      for_window [app_id="org.pulseaudio.pavucontrol"] floating enable
      for_window [app_id="nm-connection-editor"] floating enable

      for_window [app_id="kitty"] opacity 0.65
      for_window [app_id="thunar"] opacity 0.7
      for_window [app_id="org.prismlauncher.PrismLauncher"] opacity 0.7
      for_window [app_id="steam"] opacity 0.7
      for_window [app_id="waypaper"] opacity 0.7
      for_window [app_id="signal"] opacity 0.7
      for_window [app_id="net.lutris.Lutris"] opacity 0.7
      for_window [app_id="spotify"] opacity 0.7
      for_window [app_id="org.keepassxc.KeePassXC"] opacity 0.7
      for_window [app_id="Emacs"] opacity 0.95
      for_window [class="com.discordapp.Discord"] opacity 0.9
      for_window [app_id="firefox"] opacity 1

      for_window [app_id="signal"] move to workspace 5, mark silent

      bindgesture swipe:3:right workspace prev
      bindgesture swipe:3:left workspace next
    '';
  };
}
