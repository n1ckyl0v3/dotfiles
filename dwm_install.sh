#!/bin/bash

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
sudo pacman -S libx11 libxinerama libxft --noconfirm
cd ~/.config/suckless
tools=( "dwm" "dmenu" "st")
for tool in ${tools[@]}
do 
	git clone git://git.suckless.org/$tool
	cd ~/.config/suckless/$tool;make;sudo make clean install;cd ..
done

printf "\e[1;32mDone! you can now reboot.\e[0m\n"