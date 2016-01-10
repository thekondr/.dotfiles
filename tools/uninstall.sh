set -e

uninstall_repo() {
    local dir=$1
    rm -rf $dir
    if [ -e $dir.old ]; then
        echo "\033[32m$dir.old -> $dir\033[0m"
        mv $dir.old $dir
    fi
}

uninstall_repo ~/.zprezto
uninstall_repo ~/.emacs.d
uninstall_repo ~/.dotfiles
