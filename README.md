# dotfiles

My dotfiles and post-install script for Arch Linux.

## Installation

``` Bash
cd /path/to/where/you/keep/your/git/repositories
git clone --recursive git@github.com:NecRaul/dotfiles.git
cd dotfiles
bash install.sh
source ~/.bashrc
```

## After reboot

I excluded copying the sddm configuration, because it would cause a loop on my end. After rebooting your computer and logging in, to set the sddm settings run the command below (from this repo's root).

```Bash
sudo cp -f $(pwd)/misc/sddm.conf /etc/sddm.conf
```
