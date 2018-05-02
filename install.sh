#!/bin/sh

# My own fork of the thoughtbot/laptop script.

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -f "$HOME/.bash_profile" ]; then
  fancy_echo "Creating $HOME/.bash_profile ..."
  ln -s $DIR/.bash_profile $HOME/.bash_profile
fi

if [ ! -f "$HOME/.bashrc" ]; then
  fancy_echo "Creating $HOME/.bashrc ..."
  ln -s $DIR/.bashrc $HOME/.bashrc
fi

if [ ! -d "$HOME/.config" ]; then
  fancy_echo "Creating $HOME/.config ..."
  mkdir $HOME/.config
fi

if [ ! -d "$HOME/.config/base16-shell" ]; then
  fancy_echo "Creating $HOME/.config/base16-shell ..."
  ln -s $DIR/.config/base16-shell $HOME/.config/base16-shell
fi

if [ ! -f "$HOME/.gitignore" ]; then
  fancy_echo "Creating $HOME/.gitignore ..."
  ln -s $DIR/.gitignore $HOME/.gitignore
fi

if [ ! -d "$HOME/.vim" ]; then
  fancy_echo "Creating $HOME/.vim ..."
  mkdir -p $HOME/.vim
fi

if [ ! -d "$HOME/.vim/autoload" ]; then
  fancy_echo "Creating $HOME/.vim/autoload ..."
  ln -s $DIR/.vim/autoload $HOME/.vim/autoload
fi

if [ ! -f "$HOME/.vimrc" ]; then
  fancy_echo "Creating $HOME/.vimrc ..."
  ln -s $DIR/.vimrc $HOME/.vimrc
fi

HOMEBREW_PREFIX="/usr/local"

if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    sudo chown -R "$LOGNAME:admin" /usr/local
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
  curl -fsS \
    'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
fi

if brew list | grep -Fq brew-cask; then
  fancy_echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

fancy_echo "Updating Homebrew formulae ..."
brew update --force # https://github.com/Homebrew/brew/issues/1151
brew bundle --file=- <<EOF
tap "caskroom/cask"

# Unix
brew "git"
brew "vim"
brew "openssl"
brew "watchman"

# Programming language prerequisites and package managers
brew "coreutils"
cask "gpg-suite"
brew "libyaml" # should come after openssl
brew "nvm"
brew "yarn"
EOF

git config --global alias.br branch
git config --global alias.cm commit
git config --global alias.cmm "commit -m"
git config --global alias.co checkout
git config --global alias.lol "log --graph --decorate --pretty=oneline --abbrev-commit"
git config --global alias.lola "log --graph --decorate --pretty=oneline --abbrev-commit --all"
git config --global alias.ls ls-files
git config --global alias.st status

git config --global color.ui true

git config --global core.autocrlf input
git config --global core.editor vim
git config --global core.eol lf
git config --global core.excludesfile "$HOME/.gitignore"

git config --global credential.helper osxkeychain

git config --global push.default current

git config --global url.https://.insteadOf git://

git config --global user.email "mj@mjackson.me"
git config --global user.name "Michael Jackson"
