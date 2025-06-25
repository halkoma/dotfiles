PWD = $(shell pwd)
USER = $(shell whoami)

SW_COMMON = vim htop strace tree make gcc gdb \
	    fd-find ripgrep wget curl bat zsh nodejs rxvt-unicode
SW_DEBIAN = ${SW_COMMON} xxd

all: git debian vim vimplugins omz-install zsh chsh fzf neovim tmux urxvt share bin zoxide

.PHONY: git
git:
	cp git/gitconfig ~/.gitconfig

.PHONY: debian
debian:
	sudo apt-get update && sudo apt-get -y install ${SW_DEBIAN}
	mkdir -p ~/.local/bin
	ln -sf /usr/bin/batcat ~/.local/bin/bat
	ln -sf /usr/bin/fdfind ~/.local/bin/fd

.PHONY: vim
vim:
	cp vim/vimrc ~/.vimrc

.PHONY: vimplugins
vimplugins:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim -c 'PlugInstall' -c 'qa'

.PHONY: omz-install
omz-install:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

.PHONY: zsh
zsh: omz-install
	git clone https://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/wting/autojump $${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}/plugins/autojump && (cd $${ZSH_CUSTOM:-$${HOME}/.oh-my-zsh/custom}/plugins/autojump && ./install.py)
	cp zsh/zshrc ~/.zshrc
	zsh -c "source ~/.zshrc"

.PHONY: chsh
chsh:
	sudo chsh -s /usr/bin/zsh ${USER}

.PHONY: fzf
fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && yes | ~/.fzf/install

.PHONY: neovim
neovim:
	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage
	chmod 770 nvim-linux-x86_64.appimage
	./nvim-linux-x86_64.appimage --appimage-extract
	mv squashfs-root/ ~/.local/bin/nvim
	mv ~/.local/bin/nvim/AppRun ~/.local/bin/nvim/nvim
	chmod u+x ~/.local/bin/nvim/nvim
	sudo ln -sf ~/.local/bin/nvim/nvim /usr/bin/nvim
	rm nvim-linux-x86_64.appimage
	mkdir -p ~/.config/nvim/
	cp -r neovim/.config/nvim/ ~/.config/
	# install plugins, must run twice:
	# 1) install packer itself
	# 2) install plugins
	for i in 1 2; do nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'; done

.PHONY: tmux
tmux:
	cp tmux/tmux.conf ~/.tmux.conf

.PHONY: urxvt
urxvt:
	cp urxvt/Xresources ~/.Xresources

.PHONY: share
share:
	mkdir -p ~/.local/share/debian/	
	cp share/debian/* ~/.local/share/debian/

.PHONY: bin
bin: share
	mkdir -p ~/.local/bin/
	cp bin/* ~/.local/bin/
	# set x for script files but not symlinks (e.g. bat and fd)
	find ~/.local/bin/ -type f ! -type l -exec chmod 744 {} +

.PHONY: zoxide
zoxide:
	curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
