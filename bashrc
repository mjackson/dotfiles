# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # Shell is non-interactive. Be done now!
  return
fi

# Disable flow control (Ctrl+s will not suspend input to the terminal, so now
# we can use it to open split panes in vim)
stty -ixon -ixoff

alias ls="ls -G"
alias ll="ls -alG"

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# Load base16 shell helpers
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$($BASE16_SHELL/profile_helper.sh)"

HOMEBREW_DIR=$(brew --prefix)

# Set pager
export PAGER="$HOMEBREW_DIR/bin/less"

# Set Postgres data dir
export PGDATA="$HOMEBREW_DIR/var/postgres"

# Load bash completion
[ -s "$HOMEBREW_DIR/etc/bash_completion" ] && . "$HOMEBREW_DIR/etc/bash_completion"

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Load gcloud
export GCLOUD_DIR="$HOMEBREW_DIR/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
[ -s "$GCLOUD_DIR/completion.bash.inc" ] && . "$GCLOUD_DIR/completion.bash.inc"
[ -s "$GCLOUD_DIR/path.bash.inc" ] && . "$GCLOUD_DIR/path.bash.inc"

# Load Travis
[ -s /Users/michael/.travis/travis.sh ] && . /Users/michael/.travis/travis.sh
