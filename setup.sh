#!/bin/bash

# Install Dependencies (Homebrew)
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo `Installing Homebrew`
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo `Homebrew already installed`
    brew update
fi

# Install Zsh
brew install zsh

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Copy Custom Theme into oh-my-zsh
cp "ztheme.zsh-theme" $ZSH_CUSTOM/themes/

# Zsh Autosuggestions
git clone "git://github.com/zsh-users/zsh-autosuggestions" ${ZSH_CUSTOM}/plugins/zsh-autosuggestions

# Zsh Syntax highlighting
git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
echo "source ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
