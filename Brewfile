# by Aurélien Noce <aurelien.noce@imagine-app.fr>
# inspired by my own Brewfile: https://github.com/ushu/dotfiles/blob/master/Brewfile

# Update common Unix tools
brew "git"
brew "git-lfs"
brew "wget"
brew "curl"
brew "gawk"
brew "gnu-sed"
brew "ffmpeg"
brew "mutt"
brew "graphviz"

# Documentation
brew "pandoc"
brew "asciidoc"
brew "asciidoctor"

# Development tools
brew "pkg-config"
brew "vim", args: ["with-python", "with-lua", "with-python3"]
brew "neovim", args: ["HEAD"]
brew "emacs", args: ["with-cocoa", "with-gnutls"]
brew "phantomjs"
brew "imagemagick"
brew "flow"
brew "editorconfig"
brew "heroku"
brew "carthage"
brew "watchman"

# DB & Cache servers
brew "postgresql"
brew "mongodb"
brew "mysql", restart_service: true, conflicts_with: ["homebrew/versions/mysql56"]
brew "redis"
brew "memcached"
brew "sqlite"

# Common libraries
brew "libyaml"
brew "libxml2", args:[ ":with-python" ]
brew "libxslt"
brew "libksba"
brew "openssl"
brew "imagemagick"
brew "lapack"
brew "scalapack"

# Better tooling
brew "bash"
brew "bash-git-prompt"
brew "grok"
brew "ag"
brew "fzf"
brew "fzy"

# Ruby
brew "ruby"
brew "rbenv"

# Python
brew "python"
brew "python3"
brew "pyenv-virtualenv"
brew "pyenv-virtualenvwrapper"

# Node & Javascript
brew "nvm"
brew "nodejs"
brew "jsonlint"
brew "yarn"

# Elixir
brew "elixir"

# Rust
brew "rustup"

# Go
brew "go"

# Elm
brew "elm"
brew "elm-format"

# C/C++
# installs clang-tidy into "$(brew --prefix llvm)/bin/clang-tidy":
brew "llvm", args: ["with-clang", "with-clang-extra-tools"]
brew "clang-format"
brew "cmake", args: ["with-completion"]
brew "gcc", args: ["with-git", "with-nls"]

###################################
# Install GUI apps with Brew Cask #
###################################

cask_args appdir: "/Applications"
tap "caskroom/cask"

# Browsers
cask "google-chrome"
cask "firefox"
cask "opera"

# Java
cask "java" unless system "/usr/libexec/java_home --failfast"

# Dev Tools
cask "atom"
cask "visual-studio-code"
cask "gitbook-editor"
brew "antlr" # <- needs JAVA, so I put it down here...
cask "android-studio"
cask "android-sdk"
cask "android-ndk"

# Misc
cask "gpg-suite"
cask "dropbox"
cask "steam"
cask "launchrocket"
cask "vlc"
#cask "MacTex" # tooooo big...

###################################
# Install App Store apps with mas #
###################################

brew "mas"

# Fonts
tap "caskroom/fonts"
cask "font-inconsolata"
cask "font-fira-code"

