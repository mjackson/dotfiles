# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # Shell is non-interactive. Be done now!
  return
fi

alias ll="ls -al"

export PAGER=/usr/local/bin/less

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"

# Load homebrew bash completion
HOMEBREW_DIR=$(brew --prefix)
[ -s "$HOMEBREW_DIR/etc/bash_completion" ] && . "$HOMEBREW_DIR/etc/bash_completion"

# Load base16 shell helpers
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Load gcloud
export GCLOUD_DIR="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
[ -s "$GCLOUD_DIR/completion.bash.inc" ] && . "$GCLOUD_DIR/completion.bash.inc"
[ -s "$GCLOUD_DIR/path.bash.inc" ] && . "$GCLOUD_DIR/path.bash.inc"
