# NixOS Configuration

This repository contains my NixOS configuration.

## Setup Instructions

1. Clone the repository:
    ```bash
    git clone https://github.com/nainteeth/nix
    cd nix
    ```

2. Build and switch to the NixOS configuration:
    ```bash
    sudo nixos-rebuild switch --flake .#laptop # or use desktop
    ```

3. Reboot the system:
    ```bash
    systemctl reboot
    ```

## Standalone Home Manager (non-NixOS)

This repo also supports standalone Home Manager for use on any non-NixOS Linux system (e.g. Debian, Ubuntu, Arch). The home configuration is shared with the NixOS hosts — only system-level and Hyprland-specific modules are excluded.

### First-time setup

1. Install the Nix package manager:
    ```bash
    sh <(curl -L https://nixos.org/nix/install) --daemon
    ```

2. Restart your shell or source the Nix profile:
    ```bash
    . /etc/profile.d/nix.sh
    ```

3. Enable flakes (if not already enabled):
    ```bash
    mkdir -p ~/.config/nix
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    ```

4. Install Home Manager:
    ```bash
    nix profile install nixpkgs#home-manager
    ```

5. Clone the repository:
    ```bash
    git clone https://github.com/nainteeth/nix
    cd nix
    ```

6. Apply the home configuration:
    ```bash
    home-manager switch --flake .#home
    ```

## Configure GitHub SSH Access

1. Generate a new SSH key for GitHub:
    ```bash
    ssh-keygen -t ed25519 -C "CHANGEME@PLEASE.com" -f ~/.ssh/github
    ```

2. Display the public key:
    ```bash
    cat ~/.ssh/github.pub
    ```

3. Copy the public key and add it to your GitHub account under SSH keys.

4. Update the repository origin to use SSH:
    ```bash
    git remote set-url origin git@github.com:nainteeth/nix.git
    ```
    
## Installing Doom Emacs

1. Remove any existing `.emacs.d` directory:
    ```bash
    rm -rf ~/.emacs.d
    ```

2. Clone the Doom Emacs repository:
    ```bash
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
    ```

3. Install Doom Emacs:
    ```bash
    ~/.emacs.d/bin/doom install
    ```

4. Rebuild Doom Emacs:
    ```bash
    doom sync
    ```

## Steam Scaling

If you want to use environment variables to scale Steam, you will have to follow these steps: Open Steam, go to Settings > Interface, and ensure "Scale text and icons to match monitor settings" is toggled OFF. If this is ON, Steam will ignore all environment variables.

## Spotify Scaling

Open Spotify and scale it with ctrl - or ctrl +.
