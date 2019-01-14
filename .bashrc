# Very basic config for the bash shell, mostly loading all the dev tools.
# by Aurélien Noce <aurelien.noce@imagine-app.fr>

# Default editor
export EDITOR=vim

# Homebrew install options
export BREW_PREFIX="/usr/local"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Android SDK tools
export ANDROID_HOME="${HOME}/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
# This one helps Android tools work w/ Java 9
export JAVA_OPTS="-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee"

# Setup GOPATh
export GOPATH="$HOME"
export GOMAXPROCS=1
export PATH="$GOPATH/bin:$PATH"

# Expose Cargo (Rust) binaries
export PATH="$HOME/.cargo/bin:$PATH"

# Virtualenv (Python) stuff
if [ -e /usr/local/bin/virtualenvwrapper.sh ]; then
	export WORKON_HOME="$HOME/.virtualenvs"
	[ -d /usr/local/bin/python-3.6 ] && \
		export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.6
	source "$BREW_PREFIX/bin/virtualenvwrapper.sh"
fi

# Config for FZF (CLI fuzzy finder)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag -l -g ""'

# Useful alias(es)
alias l="git lg"
alias ac="git add -all && git commit"
alias be="bundle exec"

# Version managers
export NVM_DIR=~/.nvm
[ -e "$BREW_PREFIX/opt/nvm/nvm.sh" ] && source "$BREW_PREFIX/opt/nvm/nvm.sh"
[ -e "$BREW_PREFIX/bin/rbenv" ] && eval "$($BREW_PREFIX/bin/rbenv init -)"

# Cool prompt (with git support !)
[ -e "$BREW_PREFIX/opt/bash-git-prompt/share/gitprompt.sh" ] && \
	source "$BREW_PREFIX/opt/bash-git-prompt/share/gitprompt.sh"
[ -e "/usr/local/etc/bash_completion.d/git-completion.bash" ] && \
	source /usr/local/etc/bash_completion.d/git-completion.bash

