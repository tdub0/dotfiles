# .bashrc

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

if ! [[ "$PATH" =~ "$HOME/go/bin" ]]; then
    PATH="$HOME/go/bin:$PATH"
fi
export PATH

if ! [[ "NVM_DIR" =~ "$HOME/.nvm" ]]; then
    NVM_DIR="$HOME/.nvm"
fi
export NVM_DIR
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# User specific aliases and functions
export EDITOR=nvim

# Run any shell script in ~/.bashrc.d to set up environment
for i in ~/.bashrc.d/*.sh; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then
            . "$i"
        else
            . "$i" >/dev/null
        fi
    fi
done

XC32_BIN="/opt/microchip/xc32/v1.42/bin"
if [ -d $XC32_BIN ]; then
    PATH="$XC32_BIN:$PATH"
fi

CA_CERT_FILE="/usr/local/share/ca-certificates/ZscalerRoot0.crt"
if [ -f $CA_CERT_FILE ]; then
    export NODE_EXTRA_CA_CERTS=$CA_CERT_FILE
    export SSL_CERT_FILE=$CA_CERT_FILE
fi
