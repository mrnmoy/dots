# -----------------------------------------------------
# Install packages
# -----------------------------------------------------

installer_packages=(
    "hyprland" #hyprpm update -v
    "usbutils"
	"os-prober"
	"alsa-utils" #alsamixer
	# "alsa-firmware"
	# "alsa-plugins"
    "qt6-svg" #sddm deps
    "qt6-virtualkeyboard"
    "qt5-graphicaleffects"
    "qt5-quickcontrols2"
	"git"
	"wget"
	"zsh" # chsh -s $(which zsh)
    "fish" # chsh -s $(which fish)
	"fzf"
	"zoxide"
    "dunst"
	"ttf-font-awesome"
	"pavucontrol"
	"ark"
	# "kwrite"
	"mpv"
    "feh"
	# "elisa"
    # "deadbeef"
	# "blueman"
    "bluez-utils"
	# "polkit"
	"xdg-desktop-portal-hyprland"
	#"xdg-desktop-portal-gtk"
	# "iwd"
	# "iwgtk"
	"gvfs" #thunar dep
	"gvfs-mtp" #thunar dep for android
	"neovim"
	"thunar"
	"thunar-volman"
	"thunar-archive-plugin"
    "thunar-media-tags-plugin"
    "thunar-shares-plugin"
    "tumbler"
    "ffmpegthumbnailer"
    "meld" #compare action
    "jpegoptim"
	"ranger"
	"keyd" # enable
	# "zenity"
	# "ufw" # sudo ufw enable # sudo ufw allow 3389/tcp
	# "xrdp" # sudo systemctl enable xrdp
	# "xorgxrdb"
	"ddcutil" # sudo usermod -G i2c -a user
	"rofi"
	"waybar" #systemctl --user enable --now waybar.service
	"hyprpaper"
	"hyprlock"
	"hypridle"
    "hyprsunset"
    "hyprpicker"
	"minicom"
	"nodejs"
	"npm"
    "lazygit"
    "lazydocker"
	# "arc-gtk-theme"
	# "lxappearance"
	# "qt5ct"
	"kvantum"
	"kvantum-qt5"
    "nwg-look" # gtk theme manager
	"dconf-editor"
	"base-devel" # git clone https://aur.archlinux.org/yay.git   cd yay    makepkg -si
	"openvpn"
    "qutebrowser"
    #"fuse" # to run appimage
    "vsftpd" # enable # for ftp server
    "inetutils" #for ftp client
    "pass"
    "qtpass"
    "rofi-calc"
    "hdparm" #disk benchmarking
    "qalculate-gtk "
    "maven" #for java
    "mpd"
    "mpc" #mpd controller
    "rmpc" #mpd client
    "atomicparsley" # ffmpeg dep
    "mpd-mpris"
    "mpv-mpris"

    # LSPs
    "vscode-html-languageserver" 
    "vscode-css-languageserver"
    "typescript-language-server"
    "tailwindcss-language-server"
    "marksman"
    "lua-language-server"
    "bash-language-server"
)

installer_yay=(
  "hyprsysteminfo"
    "starship"
	"grub-android-prober"
	"ddcui"
	"wlogout"
	"hyprshot"
	"xremap-x11-bin"
	"hyprpolkitagent"
    "wl-clipboard"
    "cliphist"
	"yazi-git"
	"eovpn" #gui for openvpn
    # "sayonara-player" #music player
    "raw-thumbnailer" #thunar addon tumbler deps
    "tumbler-extra-thumbnailers"
    "advancecomp"
    #"pngnq-s9" #installation error
    # "aylurs-gtk-shell" #ags widgets
    # "ags-hyprpanel-git"
    "rofi-bluetooth-git"
    "hardinfo2"
    "quickshell"
    "as-cmd-bin" #audio-share

    # LSPs
    "cmake-language-server"
)


installer_packages_extra=(
    "ttf-jetbrains-mono-nerd"
	"gimp"
    "gimp-plugin-gmic"
	"libreoffice-fresh"
	"webcord"
	"coreimage"
	"yt-dlp"
	"arduino-cli"
	"kicad-library"
	"scrapy"
    "waydroid" #deps python-gbinder
    "waydorid-image" # >1.5gb
    "waydroid-magisk"
    "waydroid-launcher-git"
    "waydroid-settings-git"
    "waydroid-script-git"
    "lzip" # waydroid script dep
    "ueberzugpp"
)
installer_yay_extra=(
    #"gimp-plugin-resynthesizer" #hell
	# "amberol"
	"zen-browser-bin"
	"microsoft-edge-dev-bin"
    "stellarium" # 400mb
    "spotube-bin"
)

installer_packages_dev_tools=(
    "docker" #sudo usermod -a -G docker $(whoami) #sudo systemctl start --now docker.socket
    "docker-buildx"
    "docker-compose"
    "docker-desktop" # <500mb
    # "podman"
    #
   "arduino-ide"
   "luarocks"
)
installer_yay_dev_tools=(
	"postman-bin"
    "bun-bin"
    # "android-studio" # 1.2gb
    "ncurses5-compat-libs" #native debugger for android-studio
    "android-sdk-cmdline-tools-latest"
    "android-sdk-build-tools"
    "android-sdk-platform-tools"
    "android-platform"
    # "android-emulator"
    # "android-google-apis-playstore-x86-64-system-image" # 1.5gb
    # "android-ndk" # 0.7gb not supported for rn
    "qtcreator"
    "supabase" #supabase cli
    "podman-desktop"
    "mongodb-compass"
)

_installPackages "${installer_packages[@]}";
_installPackagesYay "${installer_yay[@]}";

_installPackages "${installer_packages_extra[@]}";
_installPackagesYay "${installer_yay_extra[@]}";

