# I use .profile for shell configuration that is common to 
# both zsh and bash (and others). .profile will be sourced in 
# .bash_profile and .zshrc. 

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in *:/home/dennishb/.julia/juliaup/bin:*);; *)
    export PATH=/home/dennishb/.julia/juliaup/bin${PATH:+:${PATH}};;
esac

# <<< juliaup initialize <<<

# >>> My own content >>>

#! Path stuff:
# For files, use -f instead of -d
add_dir_to_path() {
    local directory="$1"
    if [[ ":$PATH:" != *":$directory:"* ]] && [[ -d "$directory" ]]; then
        export PATH=${PATH:+${PATH}:}$directory
    fi
}

add_dir_to_path "/bin"
add_dir_to_path "/sbin"
add_dir_to_path "$HOME/Applications"
add_dir_to_path "/home/linuxbrew/.linuxbrew/bin"
add_dir_to_path "$HOME/.juliaup/bin"
add_dir_to_path "$HOME/.julia/juliaup/bin"

# case ":$PATH:" in *:$HOME/.local/bin:*);; *)
#     if [[ -d $HOME/.local/bin ]] ; then
#         export PATH=${PATH:+${PATH}:}$HOME/.local/bin
#     fi;;
# esac

# case ":$PATH:" in *:/bin:*);; *)
#     if [[ -d /bin ]] ; then
#         export PATH=${PATH:+${PATH}:}/bin
#     fi;;
# esac

# case ":$PATH:" in *:/sbin:*);; *)
#     if [[ -d /sbin ]] ; then
#         export PATH=${PATH:+${PATH}:}/sbin
#     fi;;
# esac

# case ":$PATH:" in *:$HOME/Applications:*);; *)
#     if [[ -d $HOME/Applications ]] ; then
#         export PATH=${PATH:+${PATH}:}$HOME/Applications
#     fi;;
# esac

# case ":$PATH:" in *:/home/linuxbrew/.linuxbrew/bin:*);; *)
#     if [[ -d /home/linuxbrew/.linuxbrew/bin ]] ; then
#         export PATH=${PATH:+${PATH}:}/home/linuxbrew/.linuxbrew/bin
#     fi;;
# esac

#! Exports
# Make micro default in terminal, for e.g. git commit messages
export EDITOR="micro"
export VISUAL="micro"
# I can not remember why I have these
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IN_MODULE=ibus

#! Sourcing other files/directoryes
[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env

#! Functions
stow_home() {
    local startdir="$PWD"
    local stow_dir="$HOME/StowFiles/HomeDir"
    
    (
        cd "$stow_dir" || return
        for package in */; do
            package="${package%/}"  # Remove trailing slash
            stow --target="$HOME" "$package"
        done
    )

    cd "$startdir" || return
}

# See https://unix.stackexchange.com/questions/85352/how-can-i-alias-sudo for the inspiration
fuck() {
	sudo $(fc -ln -1)	
}
#! Aliases
#alias fuck="sudo !!"  # Makes running `fuck` rerun the previous command as sudo
#alias ssh='kitty +kitten ssh'

#! Misc
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Open tmux always. Taken from https://unix.stackexchange.com/questions/43601/how-can-i-set-my-default-shell-to-start-up-tmux
# Disables, as it messes up VSCode :(
##if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  #exec tmux new-session -A -s main  # From comment by Verena in same stackexchange
#fi

# <<< My own content <<<

