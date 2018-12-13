# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # Shell is non-interactive. Be done now!
  return
fi

alias ll="ls -al"

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"

# Load base16 shell helpers
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$($BASE16_SHELL/profile_helper.sh)"

HOMEBREW_DIR="/usr/local"

# Set pager
export PAGER="$HOMEBREW_DIR/bin/less"

# Load bash completion
[ -s "$HOMEBREW_DIR/etc/bash_completion" ] && . "$HOMEBREW_DIR/etc/bash_completion"

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_DIR/opt/nvm/nvm.sh" ] && . "$HOMEBREW_DIR/opt/nvm/nvm.sh"

# Load gcloud
export GCLOUD_DIR="$HOMEBREW_DIR/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
[ -s "$GCLOUD_DIR/completion.bash.inc" ] && . "$GCLOUD_DIR/completion.bash.inc"
[ -s "$GCLOUD_DIR/path.bash.inc" ] && . "$GCLOUD_DIR/path.bash.inc"

# Load Travis
[ -s /Users/michael/.travis/travis.sh ] && . /Users/michael/.travis/travis.sh
