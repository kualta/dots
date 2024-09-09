## Focus-first minimalist desktop setup
### Overview
- host: [`NixOS`](https://nixos.org/) 
- wm: [`Hyprland`](https://hyprland.org/), [`Gnome`](https://gnome.org)
- shell: [`bash`](https://en.wikipedia.org/wiki/Bash_(Unix_shell))
- terminal: [`kitty`](https://github.com/kovidgoyal/kitty)
- theme: [`Catpuccin`](https://rosepinetheme.com/), [`Rose Pine`](https://rosepinetheme.com/)
- editor: [`zed`](https://zed.dev/), [`nvim`](https://neovim.io/), [`vsc`](https://code.visualstudio.com/)
- menu: [`tofi`](https://github.com/philj56/tofi)

### Keybinds & Aliases

**Aliases**

- `nx` - rebuild nixos
- `nxe` - edit nix config
- `hpe` - to edit hyprland config
- `bnuuy` - `bun i`
- `lgtm "commit message"` - git add; git commit; git push

<details>
  <summary><b>Keybinds</b></summary>
  
- <kbd>Mod</kbd> + <kbd>Enter</kbd>  Open terminal 
- <kbd>Mod</kbd> + <kbd>Print</kbd>  Make a screenshot 
- <kbd>Mod</kbd> + <kbd>Q</kbd>  Kill window 
- <kbd>Mod</kbd> + <kbd>D</kbd>  Open program 
- <kbd>Mod</kbd> + <kbd>E</kbd>  Open files 
- <kbd>Mod</kbd> + <kbd>N</kbd>  Open notifications 
- <kbd>Mod</kbd> + <kbd>F</kbd>  Toggle floating 
- <kbd>Mod</kbd> + <kbd>T</kbd>  Toggle split 
- <kbd>Mod</kbd> + <kbd>.</kbd>  Lock desktop 
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>.</kbd>  Exit session 
- <kbd>Mod</kbd> + <kbd>h</kbd> / <kbd>j</kbd> / <kbd>k</kbd> / <kbd>l</kbd>  Move around 
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>h</kbd> / <kbd>j</kbd> / <kbd>k</kbd> / <kbd>l</kbd>  Move window 
</details>

### Installation on NixOS
> Note: configuration.nix contains bash post-install that copies all the configuration files from the config/ directory onto the system
1. Copy the files onto your system
```sh
cp -f dots/* /etc/nixos/
```
2. Rebuild your system (using configured alias)
```sh
nx
```
3. You're beautiful

### Installation on Arch \ Debian
> Note: If using **Debian** as host, you'll have to compile most of the dependencies from source

1. Install `Hyprland` as described [on wiki](https://wiki.hyprland.org/Getting-Started/Installation/)
2. Install the dependencies 

Arch : `yay -S zsh oh-my-zsh-git zsh-autosuggestions zsh-completions zsh-syntax-highlighting kitty grim slurp helix neovim swaybg swaync swayidle rose-pine-gtk-theme firefox-developer-edition nautilus swaylock-effects`

Arch (QoL): `yay -S foliate discord telegram-desktop openvpn lld  ttf-material-design-icons wireplumber pipewire-jack pipewire-pulse ttf-droid noto-fonts noto-fonts-emoji wqy-microhei docker docker-compose pipewire pipewire-pulse pipewire-also pipewire-audio wireplumber visual-studio-code-bin bluez-utils-compat blueman`

4. ```git clone https://github.com/kualta/dots && mv dots/* ~/.config/```
5. Customize wallpaper and utility commands at `~/.config/hypr/hyprland.conf`
6. You're amazing! (and so is your desktop)

### Gallery
v1 (old branch)
![](https://github.com/kualta/dots/assets/72769566/6a2ef24b-05da-44c5-946a-e6c927ef3022)

v2 (main branch)
![](https://github.com/kualta/dots/assets/72769566/8f45024d-fcb9-4470-ad2c-aa1813ad5fe4)

