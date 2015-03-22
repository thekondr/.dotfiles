set -e

echo_p() {
    echo "\033[0;34m$@\033[0m"
}

unbackup_file() {
    local file=$1
    if [ -e $file.old ]; then
        echo_p "$file.old -> $file"
        mv $file.old $file
    fi
}

cd

echo_p "Removing..."

config_callback() {
    local file=$2
    rm -rf $file
    unbackup_file $file
}

. ~/.dotfiles/tools/configs.sh

rm -rf ~/.dotfiles
unbackup_file ~/.dotfiles

unset -f config_callback
unset -f unbackup_file
unset -f echo_p
