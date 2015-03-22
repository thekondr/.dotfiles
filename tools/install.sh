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

backup_file() {
    local file=$1
    if [ -e $file ]; then
        echo_p "$file -> $file.old"
        mv $file $file.old
    fi
}

cd

echo_p "Installing..."

for i in yum apt-get
do
    hash_q $i && sudo $i install -y git vim tmux
done

echo_p "Cloning..."

hash_q git && backup_file ~/.dotfiles && env git clone --depth=1 https://github.com/thekondr/.dotfiles || {
  echo_p "git not installed"
  exit
}

mpd ~/.dotfiles/vim/bundle
env git clone --depth=1 https://github.com/gmarik/vundle
cd
vim +PluginInstall +qall

echo_p "Updating config files..."

config_callback() {
    local src_file=$1
    local dst_file=$2
    backup_file $dst_file
    ln -sf $src_file $dst_file
}

. ~/.dotfiles/tools/configs.sh

unset -f config_callback
unset -f backup_file
unset -f mpd
unset -f echo_p
unset -f hash_q
