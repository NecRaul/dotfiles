#!/bin/bash

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
    echo "==================================================="
    echo "Cleared pacman cache."
}

clear_aur_cache() {
    echo "==================================================="
    echo "Clearing AUR cache."
    echo "==================================================="
    paru -Sc --noconfirm
    echo "==================================================="
    echo "Cleared AUR cache."
}

removing_unnecessary_dependencies() {
    echo "==================================================="
    echo "Removing unnecessary dependencies."
    echo "==================================================="
    sudo pacman -Rncs $(pacman -Qdtq) --noconfirm
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
    sudo cp -f $(pwd)/profile /etc/profile

    # ~ #
    cp -f $(pwd)/.bashrc $HOME/.bashrc
    cp -f $(pwd)/.pypirc $HOME/.pypirc
    # # #

    # config #
    for item in \
        ".config/blesh" \
        ".config/czkawka" \
        ".config/gallery-dl" \
        ".config/lf" \
        ".config/mpd" \
        ".config/mpv" \
        ".config/ncmpcpp" \
        ".config/npm" \
        ".config/nvim" \
        ".config/pip" \
        ".config/pyNPS" \
        ".config/python" \
        ".config/tmux" \
        ".config/wget" \
        ".config/zathura" \
        ".config/spectaclerc"; do
        ln -sf "$(pwd)/$item" "$HOME/$item"
    done
    # # # # # #

    # git #
    mkdir -p $HOME/.config/git
    ln -sf $(pwd)/.config/git/git-prompt.sh $HOME/.config/git/git-prompt.sh
    cp $(pwd)/.config/git/config $HOME/.config/git/config
    # # # #

    # scripts #
    dirs=(
        "$HOME/.local/bin/4chan-pywal"
        "$HOME/.local/bin/pyupload-devel"
        "$HOME/.local/bin/pywal-kde"
        "$HOME/.local/bin/pywal-kde-plasma"
        "$HOME/.local/bin/scripts"
        "$HOME/.local/bin/statusbar"
    )
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
        ln -sf "$(pwd)/${dir#$HOME/}/"* "$dir"
    done
    # # # # # #

    echo "==================================================="
    echo "Created symlinks."
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
    echo "==================================================="
    sed -i "s/placeholder/$pypi/g" "$HOME/.pypirc"
}

github_credentials() {
    echo "==================================================="
    echo "Paste your Github username and press Enter to finish:"
    echo "==================================================="
    read gu
    echo "==================================================="
    echo "Paste your Github e-mail and press Enter to finish:"
    echo "==================================================="
    read gmail
    echo "==================================================="
    echo "Paste your Github public access token and press Enter to finish: "
    echo "==================================================="
    read gpat
    sed -i "s/gu/$gu/g" "$HOME/.bashrc"
    sed -i "s/gpat/$gpat/g" "$HOME/.bashrc"
    sed -i "s/\(name\s*=\s*\)/\1 ${gu}/" "$HOME/.config/git/config"
    sed -i "s/\(email\s*=\s*\)/\1 ${gmail}/" "$HOME/.config/git/config"
}

no_install_packages_to_txt() {
    mkdir -p no_install
    printf "%s\n" "${no_install_pacman_packages[@]}" >no_install/pacman.txt
    printf "%s\n" "${no_install_aur_packages[@]}" >no_install/aur.txt
    printf "%s\n" "${no_install_pip_packages[@]}" >no_install/pip.txt
    echo "==================================================="
    echo "Packages that couldn't be installed were written into text files in the no_install folder"
    echo "==================================================="
}

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

reset_package_count

install_pip_packages

install_blesh

pypi_token

github_credentials

no_install_packages_to_txt
