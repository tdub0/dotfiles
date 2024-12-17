# .bashrc

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

source "$HOME/.cargo/env"

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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
