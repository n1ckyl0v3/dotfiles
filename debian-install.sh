#!/bin/bash

# Add non-free and contrib
sudo echo "deb http://debian.xtdv.net/debian/ bookworm main non-free-firmware non-free contrib
deb-src http://debian.xtdv.net/debian/ bookworm main non-free-firmware non-free contrib

deb http://security.debian.org/debian-security bookworm-security main non-free-firmware non-free contrib
deb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware non-free contrib

# bookworm-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
deb http://debian.xtdv.net/debian/ bookworm-updates main non-free-firmware non-free contrib
deb-src http://debian.xtdv.net/debian/ bookworm-updates main non-free-firmware non-free contrib

# This system was installed using small removable media
# (e.g. netinst, live or single CD). The matching "deb cdrom"
# entries were disabled at the end of the installation process.
# For information about how to configure apt package sources,
# see the sources.list(5) manual." > /etc/apt/sources.list
sudo apt update

# Install neovim 
mkdir -p ~/Downloads
cd ~/Downloads
sudo apt install git ninja-build gettext cmake unzip curl -y 
git clone https://github.com/neovim/neovim
cd neovim 
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install 
cd ~

# Enable ssh 
sudo apt install openssh-server ufw -y
sudo systemctl enable ssh 
sudo systemctl start ssh
sudo ufw enable 
sudo ufw allow ssh 
sudo ufw reload 
sudo ufw status 

# Install google-chrome
sudo apt update && sudo apt upgrade -y
cd ~/Downloads
sudo apt install wget -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
sudo apt install ./google-chrome-stable_current_amd64.deb
cd ~

# Install alacritty
cd ~/Downloads
git clone https://github.com/alacritty/alacritty.git
cd alacritty
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup override set stable
rustup update stable
sudo apt install pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 desktop-file-utils -y
cargo build --release 
sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database 
cd ~

# Install xorg 
cd ~
sudo apt install xserver-xorg-core xinit xbacklight xbindkeys xinput build-essential nm-tray lxappearance x11-xserver-utils -y 

# Install audio
sudo apt install pulseaudio pavucontrol libasound2 libasound2-plugins alsa-utils apulse -y 
sudo systemctl --user restart pulseaudio.service
sudo systemctl --user enable pulseaudio.service

# Install ibus-bamboo
echo 'deb http://download.opensuse.org/repositories/home:/lamlng/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/home:lamlng.list
curl -fsSL https://download.opensuse.org/repositories/home:lamlng/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_lamlng.gpg > /dev/null
sudo apt update
sudo apt install ibus-bamboo
ibus restart
env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"

# Install Lightdm Console Display Manager
sudo apt install -y lightdm lightdm-gtk-greeter-settings slick-greeter
sudo systemctl enable lightdm
echo 'greeter-session=slick-greeter' >>  sudo tee -a /etc/lightdm/lightdm.conf
echo 'greeter-hide-user=false' >>  sudo tee -a /etc/lightdm/lightdm.conf

# Install neofetch/htop
sudo apt install neofetch htop -y

# Install bluetooth and printing
sudo apt install firmware-iwlwifi blueman  bluez  cups  printer-driver-all -y 
# edit /etc/bluetooth/main.conf, replace to Experimental = true and KernelExperimental = true and  restart bluetooth.service
sudo systemctl enable bluetooth
sudo systemctl enable cups

# Install background image tool 
sudo apt install feh dunst -y 
cd ~/Downloads 
git clone -b debian https://github.com/n1ckyl0v3/dotfiles.git 
cp -r dotfiles/dunst ~/.config 
cd ~

# Install icon and theme  
cd ~/Downloads
git clone https://github.com/alvatip/Nordzy-icon
cd Nordzy-icon/
sudo ./install.sh
cd ~ 

# Network File Tools/System Events
sudo apt install -y dialog mtools dosfstools avahi-daemon acpi acpid gvfs-backends
sudo systemctl enable avahi-daemon
sudo systemctl enable acpid

# Create folders in user directory (eg. Documents,Downloads,etc.)
xdg-user-dirs-update

# DWM install 

if [[ ! -d /usr/share/xsessions ]]; then
    sudo mkdir /usr/share/xsessions
fi

cat > ./temp << "EOF"
[Desktop Entry]
Encoding=UTF-8
Name=dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
EOF
sudo cp ./temp /usr/share/xsessions/dwm.desktop;rm ./temp

mkdir ~/.config/suckless
sudo apt install -y libx11-dev 
cd ~/.config/suckless
tools=( "dwm" "dmenu" "st")
for tool in ${tools[@]}
do 
	git clone git://git.suckless.org/$tool
	cd ~/.config/suckless/$tool;make;sudo make clean install;cd ..
done

sudo apt autoremove

printf "\e[1;32mDone! you can now reboot.\e[0m\n"
