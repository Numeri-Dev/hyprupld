<div align="center">

![Arch](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge)
![Bash Script](https://img.shields.io/badge/bash_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![PyCharm](https://img.shields.io/badge/pycharm-143?style=for-the-badge&logo=pycharm&logoColor=black&color=black&labelColor=green)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)

![HyprUpld](Banner.png)
`# Script by PhoenixAceVFX`  
`# Licensed under GPL-2.0`  
Complex scripts that have a wide spectrum of support for image uploading  
Issues can be used to request more support or to report issues/bugs  

</div>

# FAST INSTALL  
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/PhoenixAceVFX/hyprupld/main/install.sh)"
```

# REMEMBER TO CHMOD!!!  
If you want to keybind this remember to do `chmod +x` to it!!  

# SCRIPT USE  
* Service Selection:
  * `-atumsworld`: Use atums.world 
  * `-ez`: Use e-z.host
  * `-fakecrime`: Use fakecri.me
  * `-guns`: Use guns.lol
  * `-nest`: Use nest.rip
  * `-pixelvault`: Use pixelvault.co
  * If no service is selected, the file will be copied to clipboard
* Other Options:
  * `-h, --help`: Show this help message
  * `-reset`: Reset all settings and start fresh
  * `-u, --url URL`: Set a custom upload URL

# AppImage Use  
These are if you want to use the installer script  
They should run the exact same as the scripts  
AppImages are found in the Releases section  
You can compile them yourself with the compile.sh script  
Builds are automatically generated from the latest commit  

# Install Script  
The install script is used to install the scripts to your system  
It will install them to /usr/local/bin  
It will also make the scripts executable and ensure they're in your PATH  
You can either download the repo and compile or download the zip for this  
Run `bash install_scripts.sh` to begin the installation process  
> Run `bash compile.sh` to compile the scripts  
# Supported Package Managers  
### These are all the common package managers  
- Pacman  
- Apt  
- DNF  
- Nix-Env  
- Emerge  
- Zypper  
- XBPS-Install  
- Yay  
- Paru  

# Supported Desktop Environment  
- KDE Plasma  
- Hyprland  
- Gnome  
- XFCE  
- I3  
- Deepin  
- Cinnamon  
- Openbox  
- MATE  
- Sway  

# Custom URL Support  
Manually done but instrctions can be found on the wiki!  

# Credits
This script relies on the following tools:
* [curl](https://github.com/curl/curl) - Command line tool for transferring data
* [xclip](https://github.com/astrand/xclip) - Command line interface to X selections (clipboard)
* [fyi](https://github.com/Macchina-CLI/fyi) - Minimal desktop notifications
* [zenity](https://gitlab.gnome.org/GNOME/zenity) - Display graphical dialog boxes from shell scripts
