# .bashrc

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if ! [[ "$RUSTPATH" =~ "$HOME/.cargo/bin" ]]; then
    RUSTPATH="$HOME/.cargo/bin:$RUSTPATH"
fi
export PATH=$PATH:$RUSTPATH

if ! [[ "$GOPATH" =~ "$HOME/go" ]]; then
    GOPATH="$HOME/go:$GOPATH"
fi
export GOPATH

# User specific aliases and functions
EDITOR=~/.local/bin/nvim
export EDITOR

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
