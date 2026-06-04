# This is how you install neovim appimage on remote machine

* Install appimage first, I'll use $HOME/bin/ as the default path
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
```

* Set the path to ~/.bashrc
```bash
alias nvim='~/bin/nvim-linux-x86_64.appimage'
source ~/.bashrc
nvim
```

* If nvim fails, try:
```bash
./nvim-linux-x86_64.appimage --appimage-extract
./squashfs-root/AppRun --version
```


* Last pull this directory to your ~/.config/nvim/
```bash
git clone https://github.com/weakson/nvim.git
```
