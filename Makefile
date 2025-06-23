PWD = $(shell pwd)
USER = $(shell whoami)

SW_COMMON = vim htop strace tree make gcc gdb \
	    fd-find ripgrep wget curl bat zsh nodejs rxvt-unicode
SW_DEBIAN = ${SW_COMMON} xxd

all: vim neovim git tmux share vimplugins debian omz-install zsh chsh urxvt

.PHONY: vim neovim git tmux share vimplugins debian omz-install zsh chsh urxvt

vim:
	cp vim/vimrc ~/.vimrc

vimplugins:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim -c 'PlugInstall' -c 'qa'

neovim:
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage
	chmod 770 nvim-linux-x86_64.appimage
	./nvim-linux-x86_64.appimage --appimage-extract
	mv squashfs-root/ ~/.local/bin/nvim
	mv ~/.local/bin/nvim/AppRun ~/.local/bin/nvim/nvim
	chmod u+x ~/.local/bin/nvim/nvim
	sudo ln -sf ~/.local/bin/nvim/nvim /usr/bin/nvim
	rm nvim-linux-x86_64.appimage
	cp -r neovim/.config/nvim ~/.config/

omz-install:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

zsh: omz-install
	git clone https://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/wting/autojump $${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}/plugins/autojump && (cd $${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}/plugins/autojump && ./install.py)
	cp zsh/zshrc ~/.zshrc
	zsh -c "source ~/.zshrc"

chsh:
	sudo chsh -s /usr/bin/zsh ${USER}

git:
	cp git/gitconfig ~/.gitconfig

tmux:
	cp tmux/tmux.conf ~/.tmux.conf

urxvt:
	cp urxvt/Xresources ~/.Xresources

share:
	mkdir -p ~/.local/share/debian/
	cp share/debian/* ~/.local/share/debian/

fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

debian: fzf
	sudo apt-get update && sudo apt-get -y install ${SW_DEBIAN}
	mkdir -p ~/.local/bin
	ln -sf /usr/bin/batcat ~/.local/bin/bat
	ln -sf /usr/bin/fdfind ~/.local/bin/fd
