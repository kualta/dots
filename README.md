## Focus-first minimalist desktop setup
### Overview
- wm: [`Hyprland`](https://hyprland.org/)
- shell: [`zsh`](https://www.zsh.org/)
- terminal: [`kitty`](https://github.com/kovidgoyal/kitty)
- theme: [`Rose Pine`](https://rosepinetheme.com/)
- editor: [`helix`](https://helix-editor.com/), [`neovim`](https://neovim.io/), [`vscode`](https://code.visualstudio.com/)
- menu: [`tofi`](https://github.com/philj56/tofi)

### Keybinds
<details>
  <summary><b>Desktop</b></summary>
  
- <kbd>Mod</kbd> + <kbd>Enter</kbd>  Open terminal 
- <kbd>Mod</kbd> + <kbd>.</kbd>  Lock desktop 
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>.</kbd>  Exit session 
- <kbd>Mod</kbd> + <kbd>Q</kbd>  Kill window 
- <kbd>Mod</kbd> + <kbd>D</kbd>  Open program 
- <kbd>Mod</kbd> + <kbd>E</kbd>  Open files 
- <kbd>Mod</kbd> + <kbd>N</kbd>  Open notifications 
- <kbd>Mod</kbd> + <kbd>F</kbd>  Toggle floating 
- <kbd>Mod</kbd> + <kbd>T</kbd>  Toggle split 
- <kbd>Mod</kbd> + <kbd>h</kbd> / <kbd>j</kbd> / <kbd>k</kbd> / <kbd>l</kbd>  Move around 
- <kbd>Mod</kbd> + <kbd>Shift</kbd> + <kbd>h</kbd> / <kbd>j</kbd> / <kbd>k</kbd> / <kbd>l</kbd>  Move window 
</details>

<details>
  <summary><b>Shell</b></summary>
  
### History

- `ctrl-p` : Previous command in history
- `ctrl-n` : Next command in history
- `/`      : Search backward in history
- `n`      : Repeat the last `/`

### Movement

- `$`   : To the end of the line
- `^`   : To the first non-blank character of the line
- `0`   : To the first character of the line
- `w`   : [count] words forward
- `W`   : [count] WORDS forward
- `e`   : Forward to the end of word [count] inclusive
- `E`   : Forward to the end of WORD [count] inclusive
- `b`   : [count] words backward
- `B`   : [count] WORDS backward
- `t{char}`   : Till before [count]'th occurrence of {char} to the right
- `T{char}`   : Till before [count]'th occurrence of {char} to the left
- `f{char}`   : To [count]'th occurrence of {char} to the right
- `F{char}`   : To [count]'th occurrence of {char} to the left
- `;`   : Repeat latest f, t, F or T [count] times
- `,`   : Repeat latest f, t, F or T in opposite direction

### Insertion

- `i`   : Insert text before the cursor
- `I`   : Insert text before the first character in the line
- `a`   : Append text after the cursor
- `A`   : Append text at the end of the line
- `o`   : Insert new command line below the current one
- `O`   : Insert new command line above the current one

### Delete and Insert

- `ctrl-h`      : While in *Insert mode*: delete character before the cursor
- `ctrl-w`      : While in *Insert mode*: delete word before the cursor
- `d{motion}`   : Delete text that {motion} moves over
- `dd`          : Delete line
- `D`           : Delete characters under the cursor until the end of the line
- `c{motion}`   : Delete {motion} text and start insert
- `cc`          : Delete line and start insert
- `C`           : Delete to the end of the line and start insert
- `r{char}`     : Replace the character under the cursor with {char}
- `R`           : Enter replace mode: Each character replaces existing one
- `x`           : Delete `count` characters under and after the cursor
- `X`           : Delete `count` characters before the cursor

</details>


### Installation
> Note: If using **Debian** as host, you'll have to compile most of the dependencies from source

1. Install `Hyprland` as described [on wiki](https://wiki.hyprland.org/Getting-Started/Installation/)
2. Install the dependencies 

Arch : `yay -S zsh oh-my-zsh-git zsh-autosuggestions zsh-completions zsh-syntax-highlighting kitty helix neovim swaybg swaync swayidle rose-pine-gtk-theme firefox-developer-edition nautilus swaylock-effects`

Arch (QoL): `yay -S foliate discord telegram-desktop openvpn lld  ttf-material-design-icons wireplumber pipewire-jack pipewire-pulse ttf-droid noto-fonts noto-fonts-emoji wqy-microhei docker docker-compose pipewire pipewire-pulse pipewire-also pipewire-audio wireplumber visual-studio-code-bin bluez-utils-compat blueman`

4. ```git clone https://github.com/kualta/dots && mv dots/* ~/.config/```
5. Customize wallpaper and utility commands at `~/.config/hypr/hyprland.conf`
6. You're amazing! (and so is your desktop)

### Gallery
![](https://github.com/kualta/dots/assets/72769566/6a2ef24b-05da-44c5-946a-e6c927ef3022)
![](https://github.com/kualta/dots/assets/72769566/b333a976-b083-477b-b1f9-97174300d339)
