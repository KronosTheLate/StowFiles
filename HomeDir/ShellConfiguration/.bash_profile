# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc"
    fi
fi
# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in *:/home/dennishb/.julia/juliaup/bin:*);; *)
    export PATH=/home/dennishb/.julia/juliaup/bin${PATH:+:${PATH}};;
esac

# <<< juliaup initialize <<<

# >>> My own content >>>
# Source .profile if it exists
[[ -f $HOME/.profile ]] && source $HOME/.profile

# <<< My own content <<<


