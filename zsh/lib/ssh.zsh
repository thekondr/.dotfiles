function print-public-key() {
    cat ~/.ssh/id_rsa.pub
}

function authorize-key() {
    print-public-key | ssh $@ 'cat - >> ~/.ssh/authorized_keys'
}

alias vissh='vim ~/.ssh/config'
