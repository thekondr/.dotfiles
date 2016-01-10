set -e

hash_q() {
    hash $@ >/dev/null 2>&1
}

for i in yum apt-get
do
    hash_q $i && sudo $i install -y git zsh vim tmux
done

hash_q git || {
    echo "\033[31mgit not found\033[0m"
    exit
}

install_repo() {
    local url=$1
    local dir=$1
    if [ -e $dir ]; then
        echo "\033[32m$dir -> $dir.old\033[0m"
        mv $dir $dir.old
    fi
    env git clone --depth=1 --recursive $url $dir
}

install_repo https://github.com/thekondr/.dotfiles ~/.dotfiles
install_repo https://github.com/syl20bnr/spacemacs ~/.emacs.d
install_repo https://github.com/sorin-ionescu/prezto ~/.zprezto

echo 'source $HOME/.dotfiles/vim/vimrc' >> ~/.vimrc
echo 'source $HOME/.dotfiles/zsh/zlogin' >> ~/.zlogin
echo 'source $HOME/.dotfiles/zsh/zprofile' >> ~/.zprofile
echo 'source $HOME/.dotfiles/zsh/zshenv' >> ~/.zshenv
echo 'source $HOME/.dotfiles/zsh/zshrc' >> ~/.zshrc
echo 'source $HOME/.dotfiles/tmux.conf' >> ~/.tmux.conf
echo '(load-file "$HOME/.dotfiles/spacemacs")' >> ~/.spacemacs

chsh -s `which zsh`
