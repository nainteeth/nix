Hello, this is my NixOS configuration using Hyprland, mkOutOfStoreSymlinks and Doom Emacs.

Here is everything you need to set this up:
git clone https://github.com/nainteeth/nix
cd nix
sudo nixos-rebuild switch --flake .#laptop // or desktop 
systemctl reboot

For ssh for github:
ssh-keygen -t ed25519 -C "CHANGEME@PLEASE.com" -f ~/.ssh/github 
cat ~/.ssh/github.pub
Copy this and add it to your ssh keys on github
cd nix
git remote set-url origin git@github.com:nainteeth/nix.git
If its not working immediately: reboot

For Doom Emacs:
rm -rf .emacs.d // If it exists
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
Rebuild now and then:
doom sync
