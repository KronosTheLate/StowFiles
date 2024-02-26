This is a github repository to store the personal dotfiles and similar intended for use with GNU Stow.

To create the symlinks, do the following:
1) Install GNU Stow, by e.g. `audo aptitude install stow`.
2) Install git, enter an appropriate directory inside which you want to have `StowFiles` (e.g. `GeekyStuff`), and run `git clone https://github.com/KronosTheLate/StowFiles`
3) Run `startdir=$PWD; cd; cd StowFiles/HomeDir; stow --target=$HOME */; cd $startdir`.

This will result in the following effect on all folders inside this repository: Any folder `Folder` will have it's contents symlinked into the home directory (`$HOME`/`~`). This means that a file `Folder/my_file.txt` will end up as a symlink located at `~/my_file.txt`.
