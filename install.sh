#!/bin/bash

create_folders() {
    mkdir -p $HOME/.config
    mkdir -p $HOME/.local/bin
    mkdir -p $HOME/.local/share/applications
    mkdir -p $HOME/Documents/Github/Gists
    mkdir -p $HOME/Documents/Github/Repos
    mkdir -p $HOME/Documents/LNs
    mkdir -p $HOME/Documents/Notes
    mkdir -p $HOME/Documents/Papers
    mkdir -p $HOME/Documents/ROM
    mkdir -p $HOME/Downloads
    mkdir -p $HOME/Music
    mkdir -p $HOME/Pictures/gallery-dl
    mkdir -p $HOME/Pictures/mpv
    mkdir -p $HOME/Pictures/Screenshots
    mkdir -p $HOME/Pictures/Wallpapers
    mkdir -p $HOME/Videos/Recordings
    mkdir -p $HOME/Videos/Seasonals
    mkdir -p $HOME/Videos/Temp
    sudo mkdir -p /etc/modprobe.d
    sudo mkdir -p /usr/share/xsessions
}

no_password_sudoers() {
    # This is unnecessary if you can already use sudo without using password and should be commented out
    sudo sed -i "/^root\sALL=(ALL:ALL)\sALL/a $USER ALL=(ALL) NOPASSWD: ALL" /etc/sudoers
    echo "==================================================="
    echo "Enabled $USER to use sudo without having to enter password."
}

enable_pacman_color() {
    sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
    echo "==================================================="
    echo "Enabled colors on pacman and AUR helpers like paru and yay."
}

install_pacman_packages() {
    echo "==================================================="
    echo "Installing pacman packages."
    echo "==================================================="
    # Note: pacman -Qeq gives explicitly installed pacman packages
    while IFS= read -r package || [ -n "$package" ]; do
        if ! pacman -Qq "$package" &>/dev/null; then
            ((attempted_packages++))
            if sudo pacman -S --noconfirm --needed "$package"; then
                ((installed_packages++))
            else
                no_install_pacman_packages+=("$package")
            fi
        fi
    done <"install/pacman.txt"
    echo "==================================================="
    echo "Finished installing pacman packages."
    echo "$installed_packages/$attempted_packages installed."
}

install_aur_packages() {
    echo "==================================================="
    echo "Installing AUR packages."
    echo "==================================================="
    # Note: pacman -Qmq gives explicitly installed AUR packages
    while IFS= read -r package || [ -n "$package" ]; do
        if ! pacman -Qm "$package" &>/dev/null; then
            ((attempted_packages++))
            if paru -S --noconfirm --needed "$package"; then
                ((installed_packages++))
            else
                no_install_aur_packages+=("$package")
            fi
        fi
    done <"install/aur.txt"
    echo "==================================================="
    echo "Finished installing AUR packages."
    echo "$installed_packages/$attempted_packages installed."
}

install_aur_packages_2_electric_boogaloo() {
    echo "==================================================="
    echo "Install packages that couldn't be installed using pacman."
    echo "==================================================="
    if [ ${#no_install_pacman_packages[@]} -gt 0 ]; then
        for package in "${no_install_pacman_packages[@]}"; do
            if ! pacman -Qq "$package" &>/dev/null; then
                ((attempted_packages++))
                if paru -S --noconfirm --needed "$package"; then
                    ((installed_packages++))
                else
                    no_install_aur_packages+=("$package")
                fi
            fi
        done
    fi
    echo "==================================================="
    echo "Finished trying to install packages that couldn't be installed using pacman."
    echo "$installed_packages/$attempted_packages installed."
}

install_pip_packages() {
    echo "==================================================="
    echo "Installing pip packages."
    echo "==================================================="
    # Note: pip freeze | cut -d'=' -f1 gives installed pip packages
    pip install --no-warn-script-location -r install/pip.txt
    # optional
    # pip install "$(pwd)/.local/bin/pyupload/"
    # pip install "$(pwd)/.local/bin/pywal-kde/"
    echo "==================================================="
    echo "Finished installing pip packages."
    echo "$installed_packages/$attempted_packages installed."
}

clear_pacman_cache() {
    echo "==================================================="
    echo "Clearing pacman cache."
    echo "==================================================="
    sudo pacman -Sc --noconfirm
    paccache -rk0
    echo "==================================================="
    echo "Cleared pacman cache."
}

clear_aur_cache() {
    echo "==================================================="
    echo "Clearing AUR cache."
    echo "==================================================="
    paru -Sc --noconfirm
    paccache -rk0
    echo "==================================================="
    echo "Cleared AUR cache."
}

removing_unnecessary_dependencies() {
    echo "==================================================="
    echo "Removing unnecessary dependencies."
    echo "==================================================="
    sudo pacman -Rncs $(pacman -Qdtq) --noconfirm
    paru -Rncs $(paru -Qdtq) --noconfirm
    echo "==================================================="
    echo "Removed unnecessary dependencies."
}

install_paru() {
    echo "==================================================="
    echo "Installing paru."
    echo "==================================================="
    if ! pacman -Qq paru &>/dev/null; then
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si --noconfirm --needed
        cd ..
        rm -rf paru
        echo "==================================================="
        echo "Installed paru."
    else
        echo "paru is already installed."
    fi
}

install_blesh() {
    echo "==================================================="
    echo "Installing ble.sh."
    echo "==================================================="
    git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
    make -C "$(pwd)/ble.sh" install PREFIX="$HOME/.local"
    rm -rf "$(pwd)/ble.sh"
    echo "==================================================="
    echo "Installed ble.sh."
}

create_symlinks() {
    echo "==================================================="
    echo "Creating symlinks."

    # / #
    sudo cp -f $(pwd)/misc/environment /etc/environment
    sudo cp -f $(pwd)/misc/fstab1 /etc/fstab1
    sudo cp -f $(pwd)/misc/profile /etc/profile
    sudo cp -f $(pwd)/misc/blacklist.conf /etc/modprobe.d/blacklist.conf
    sudo cp -f $(pwd)/misc/polkit-start.service /usr/lib/systemd/user/polkit-start.service
    sudo cp -f $(pwd)/misc/dwmstart /usr/local/bin/dwmstart
    sudo cp -f $(pwd)/misc/51-necraul.rules /usr/share/polkit1/rules.d/51-necraul.rules
    sudo cp -f $(pwd)/misc/Xsetup /usr/share/sddm/scripts/Xsetup
    sudo cp -f $(pwd)/misc/Background.png /usr/share/sddm/themes/where_is_my_sddm_theme/Background.png
    sudo cp -f $(pwd)/misc/theme.conf /usr/share/sddm/themes/where_is_my_sddm_theme/theme.conf
    sudo cp -f $(pwd)/misc/dwm.desktop /usr/share/xsessions/dwm.desktop
    # # #

    # ~ #
    cp -f $(pwd)/misc/.bashrc $HOME/.bashrc
    cp -f $(pwd)/misc/.prettierrc $HOME/.prettierrc
    cp -f $(pwd)/misc/.pypirc $HOME/.pypirc
    # # #

    # config #
    for item in \
        ".config/blesh" \
        ".config/cava" \
        ".config/czkawka" \
        ".config/dunst" \
        ".config/gallery-dl" \
        ".config/git" \
        ".config/gtk-2.0" \
        ".config/gtk-3.0" \
        ".config/gtk-4.0" \
        ".config/lf" \
        ".config/mpd" \
        ".config/mpv" \
        ".config/ncmpcpp" \
        ".config/neofetch"
        ".config/npm" \
        ".config/nsxiv" \
        ".config/nvim" \
        ".config/picom" \
        ".config/pip" \
        ".config/pyNPS" \
        ".config/python" \
        ".config/qt6ct" \
        ".config/shell" \
        ".config/tmux" \
        ".config/wal" \
        ".config/weechat" \
        ".config/wget" \
        ".config/wireplumber" \
        ".config/x11" \
        ".config/zathura" \
        ".config/zoxide" \
        ".config/mimeapps.list"; do
        ln -sf "$(pwd)/$item" "$HOME/$item"
    done
    # # # # # #

    # bin #
    for dir in \
        "$HOME/.local/bin/4chan-pywal" \
        "$HOME/.local/bin/kuroneko-themes" \
        "$HOME/.local/bin/pywal-kde" \
        "$HOME/.local/bin/pywal-kde-plasma" \
        "$HOME/.local/bin/scripts" \
        "$HOME/.local/bin/statusbar" \
        "$HOME/.local/bin/zathura-pywal"; do
        mkdir -p "$dir"
        ln -sf "$(pwd)/${dir#$HOME/}/"* "$dir"
    done
    mkdir -p "$HOME/.local/bin/pyupload-devel"
    ln -sf "$(pwd)/.local/bin/pyupload/"* "$HOME/.local/bin/pyupload-devel"
    # # # # # #

    # share #
    for file in $(pwd)/.local/share/applications/*; do
        filename=$(basename "$file")
        ln -sf "$file" $HOME/.local/share/applications/"$filename"
    done
    ln -sf $(pwd)/.local/share/kio $HOME/.local/share/kio
    ln -sf $(pwd)/.local/share/bg $HOME/.local/share/bg
    # # # # #

    echo "==================================================="
    echo "Created symlinks."
}

install_zathura_pywal() {
    echo "==================================================="
    echo "Installing zathura-pywal."

    sudo make install -C $HOME/.local/bin/zathura-pywal
    zathura-pywal -a 0.8

    echo "==================================================="
    echo "Installed zathura-pywal."
}

install_grub_theme() {
    echo "==================================================="
    echo "Installing GRUB theme."

    sudo bash $(pwd)/.local/bin/kuroneko-themes/install.sh

    echo "==================================================="
    echo "Installed GRUB theme."
}

enable_services() {
    echo "==================================================="
    echo "Enabling systemd services."

    sudo systemctl enable sddm.service
    systemctl --user enable polkit-start.service
    systemctl --user enable syncthing.service
    systemctl --user enable mpd.service
    systemctl --user enable mpd-discord-rpc.service

    echo "==================================================="
    echo "Enabled systemd services."
}

no_install_arrays() {
    # Array to hold pacman, AUR and pip packages that couldn't be installed
    declare -a no_install_pacman_packages=()
    declare -a no_install_aur_packages=()
    declare -a no_install_pip_packages=()
}

reset_package_count() {
    declare -i installed_packages=0
    declare -i attempted_packages=0
}

pypi_token() {
    echo "==================================================="
    echo "Paste your PyPI token and press Enter to finish:"
    echo "==================================================="
    read pypi
    sed -i "s/placeholder/$pypi/g" "$HOME/.pypirc"
}

github_credentials() {
    echo "==================================================="
    echo "Paste your Github username and press Enter to finish:"
    echo "==================================================="
    read gu
    echo "==================================================="
    echo "Paste your Github public access token and press Enter to finish: "
    echo "==================================================="
    read gpat
    sed -i "s/gu/$gu/g" "$HOME/.bashrc"
    sed -i "s/gpat/$gpat/g" "$HOME/.bashrc"
}

no_install_packages_to_txt() {
    mkdir -p no_install
    printf "%s\n" "${no_install_pacman_packages[@]}" >no_install/pacman.txt
    printf "%s\n" "${no_install_aur_packages[@]}" >no_install/aur.txt
    printf "%s\n" "${no_install_pip_packages[@]}" >no_install/pip.txt
    echo "==================================================="
    echo "Script has finished running. Packages that couldn't be installed were written into text files in the no_install folder."
    echo "==================================================="
}

create_folders

no_password_sudoers

enable_pacman_color

no_install_arrays

reset_package_count

install_pacman_packages

clear_pacman_cache

install_paru

reset_package_count

install_aur_packages

reset_package_count

install_aur_packages_2_electric_boogaloo

clear_aur_cache

removing_unnecessary_dependencies

create_symlinks

install_zathura_pywal

reset_package_count

install_pip_packages

install_blesh

install_grub_theme

enable_services

pypi_token

github_credentials

no_install_packages_to_txt
