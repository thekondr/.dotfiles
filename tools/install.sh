set -e

hash_q() {
    hash $@ >/dev/null 2>&1
}

echo_p() {
    echo "\033[0;34m$@\033[0m"
}

mpd() {
    local path=$1
    mkdir -p $path && cd $path
}

ibckp() {
    local dfile=$1
    local nfile=$2
    if [ -f $nfile ] || [ -h $nfile ]; then
        echo_p "\033[0;33mFound $nfile.\033[0m \033[0;32mBacking up to $nfile.old";
        mv $nfile $nfile.old;
    fi
    ln -sf $dfile $nfile
}

cd

echo_p "Installing..."

for i in yum apt-get
do
    hash_q $i && sudo $i install -y git vim tmux
done

echo_p "Clonning..."

hash_q git && env git clone --depth=1 https://github.com/thekondr/.dotfiles || {
  echo_p "git not installed"
  exit
}

mpd .dotfiles/vim/bundle
env git clone --depth=1 https://github.com/gmarik/vundle
cd

echo_p "Updating config files..."

ibckp .dotfiles/vim ~/.vim
ibckp .dotfiles/vim/vimrc ~/.vimrc
ibckp .dotfiles/tmux.conf ~/.tmux.conf

unset -f ibckp
unset -f echo_p
unset -f hash_q
