# Written by Daniel Kats
# This script will automatically setup the dotfiles to 'just work'

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# write bashrc
echo "source \"${HERE}/bashrc\"" >> ~/.bashrc

which vim>/dev/null
if [ $? -eq 0 ]; then
    if [ -e ~/.vimrc ]; then
        echo "Error: vimrc already exists">&1
    else
        # write vimrc
        ln -s "$HERE/vimrc" ~/.vimrc
    fi

    # write colorscheme
    mkdir -p ~/.vim/colors ln -s "${HERE}/config/dbk_sublime.vim" ~/.vim/colors/dbk_sublime.vim

    if [ ! -e ~/.vim/bundle ]; then
        # install pathogen
        mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    fi
fi