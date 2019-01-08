# by Aurélien Noce <aurelien.noce@imagine-app.fr>
# inspired by my own Brewfile: https://github.com/ushu/dotfiles/blob/master/Brewfile

# Update common Unix tools
brew "bash"
brew "git"
brew "git-lfs"
brew "mutt"
brew "curl"
brew "wget"

# Python
brew "python3", args: [ "build-from-source" ]
brew "python@2", args: [ "build-from-source" ]

# Development tools
brew "pkg-config"
brew "vim", args: ["with-python", "with-lua", "with-python3"]
brew "imagemagick"
brew "ffmpeg"
brew "watchman"
tap "heroku/brew"
brew "heroku/brew/heroku"
tap "sass/sass"
brew "sass/sass/sass"

# DB & Cache servers
brew "postgresql", restart_service: :changed
brew "redis", restart_service: :changed
brew "memcached", restart_service: :changed

# Common libraries
brew "libyaml"
brew "libxml2", args: [ "with-python" ]

# Better tooling
brew "bash-git-prompt"
brew "ag"
brew "fzf"

# Ruby
brew "rbenv"

# Node & Javascript
brew "nvm"
brew "yarn"
brew "flow"

# Go
brew "go"
brew "dep"

# Additional dev tools
brew "cmake", args: [ "with-completion" ]
brew "carthage"
brew "letsencrypt"

###################################
# Install GUI apps with Brew Cask #
###################################

cask_args appdir: "/Applications"
tap "caskroom/cask"

# Browsers
cask "google-chrome"
cask "firefox"

# Java
cask "java" unless system "/usr/libexec/java_home --failfast >/dev/null 2>&1"

# Java
cask "googleappengine"

# Dev Tools
brew "antlr" # <- needs java !
cask "visual-studio-code"
cask "google-cloud-sdk"
# Android
cask "android-studio"
cask "android-sdk"

# Misc
cask "launchrocket"
#cask "vlc"
cask "omnidisksweeper"

# JetBrains IDEs
cask "jetbrains-toolbox"

