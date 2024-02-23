This is a github repository to store the personal dotfiles and similar intended for use with GNU Stow.

To create the symlinks, do the following:
1) Install GNU Stow, by e.g. `audo aptitude install stow`.
2) `cd` into this directory, and run `stow */` to run stow on all directories inside this one.

This will result in the following effect on all folders inside this repository: Any folder `Folder` will have it's contents symlinked into the home directory (`$HOME`/`~`). This means that a file `Folder/my_file.txt` will end up as a symlink located at `~/my_file.txt`.
