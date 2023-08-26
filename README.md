## Focus-first minimalist desktop setup
### Overview
- wm: [`Hyprland`](https://hyprland.org/)
- shell: [`fish`](https://fishshell.com/)
- terminal: [`kitty`](https://github.com/kovidgoyal/kitty)
- theme: [`Rose Pine`](https://rosepinetheme.com/)
- editor: [`helix`](https://helix-editor.com/), [`neovim`](https://neovim.io/), [`vscode`](https://code.visualstudio.com/)
- menu: [`tofi`](https://github.com/philj56/tofi)

> Tested with `Hyperland 0.27.0` on **Debian sid** and `Hyperland 0.28.0` on **Arch 6.4.11**

### Keybinds
- Open terminal <kbd>Mod</kbd> + <kbd>Enter</kbd>
- Lock desktop <kbd>Mod</kbd> + <kbd>.</kbd> 
- Exit session <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>.</kbd> 
- Kill window <kbd>Mod</kbd> + <kbd>Q</kbd>
- Open program <kbd>Mod</kbd> + <kbd>D</kbd>
- Open files <kbd>Mod</kbd> + <kbd>E</kbd>
- Open notifications <kbd>Mod</kbd> + <kbd>N</kbd>
- Toggle floating <kbd>Mod</kbd> + <kbd>F</kbd>
- Toggle split <kbd>Mod</kbd> + <kbd>T</kbd>
- Move around <kbd>Mod</kbd> + <kbd>h</kbd> / <kbd>j</kbd> / <kbd>k</kbd> / <kbd>l</kbd>
- Move window <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>h</kbd> / <kbd>j</kbd> / <kbd>k</kbd> / <kbd>l</kbd>

### Installation
> Note: If using **Debian** as host, you'll have to compile most of the dependencies from source

> Note: There's no status bar, if you want one check out [`waybar`](https://github.com/Alexays/Waybar)

1. Install `Hyprland` as described [on wiki](https://wiki.hyprland.org/Getting-Started/Installation/)
2. Install the dependencies 

Arch : `yay -S fish kitty helix neovim swaybg swaync swayidle rose-pine-gtk-theme firefox-developer-edition nautilus swaylock-effects`
Arch (QoL): `yay -S discord telegram-desktop openvpn ttf-droid noto-fonts noto-fonts-emoji wqy-microhei docker docker-compose pipewire pipewire-pulse pipewire-also pipewire-audio wireplumber visual-studio-code-bin bluez-utils-compat blueman`

4. ```git clone https://github.com/kualta/dots && mv dots/* ~/.config/```
5. Customize wallpaper and utility commands at `~/.config/hypr/hyprland.conf`
6. You're amazing! (and so is your desktop)

### Gallery
![](https://github.com/kualta/dots/assets/72769566/6a2ef24b-05da-44c5-946a-e6c927ef3022)
![](https://github.com/kualta/dots/assets/72769566/b333a976-b083-477b-b1f9-97174300d339)
