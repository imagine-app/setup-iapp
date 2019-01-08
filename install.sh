#!/usr/bin/env bash

# Call me from the web:
#
#   $ curl https://raw.githubusercontent.com/imagine-app/setup-iapp/master/install.sh | bash
#

set -e
set -u

CONTENT_URL="https://raw.githubusercontent.com/imagine-app/setup-iapp/master"
# Files to copy locally
REMOTE_FILES=(Brewfile .bashrc .gitconfig .profile .bundle.config)
# Ruby version to install (using rbenv)
RUBY_VERSION="2.6.0"
# Libraries for developers
GEMS=(rails nokogiri)
NODE_MODULES=(create-react-app react-native typescript react-scripts-ts express)
PYTHON_PIPS=(httpie scipy matplotlib jupyter virtualenv virtualenvwrapper)
GO_PACKAGES=(
  "golang.org/x/tools/cmd/goimports" 
  "github.com/sourcegraph/go-langserver"
  "github.com/mdempsky/gocode"
)


NAME=""
EMAIL=""
GITHUB_USERNAME=""

main()  {
  header

  read -p "Appuyer sur une touche pour continuer... " -n1 -s </dev/tty
  echo
  echo

  read -p "Votre nom complet: " NAME </dev/tty
  read -p "Votre email: " EMAIL </dev/tty
  read -p "Votre ID Github: " GITHUB_USERNAME </dev/tty
  if [ -z "$NAME" ] || [ -z "$EMAIL" ] || [ -z "$GITHUB_USERNAME" ]; then
      echo
      echo -e "☠️ ☠️  Please enter name & email: aborting ☠️ ☠️ " 
      exit 1
  fi
  echo

  trap "echo; echo -e '☠️ ☠️  Installation failed. ☠️ ☠️ '" EXIT

  copy_files

  install_brew_files
  install_node_modules
  install_ruby_gems
  install_python_eggs
  install_go_modules

  trap - EXIT
}

header() {
  echo -e "\\033[34m"
  echo " _                       _                                    "
  echo "(_)_ __ ___   __ _  __ _(_)_ __   ___        __ _ _ __  _ __  "
  echo "| | '_ \` _ \\ / _\` |/ _\` | | '_ \\ / _ \\_____ / _\` | '_ \\| '_ \\ "
  echo "| | | | | | | (_| | (_| | | | | |  __/_____| (_| | |_) | |_) |"
  echo "|_|_| |_| |_|\\__,_|\\__, |_|_| |_|\\___|      \\__,_| .__/| .__/ "
  echo "                   |___/                         |_|   |_|    "
  echo -e "\\033[0m"

  echo "Ce script va installer la machine avec le setup de \"base\"".
  echo
  echo -e "\\033[31mATTENTION\\033[0m il faut installer Xcode \\033[31mavant\\033[0m de continuer."
  echo -e "  De plus, on ne peut pas utiliser \\033[32mmas\\033[0m pour installer des apps qui"
  echo -e "  n'ont pas été achetés: donc ça ne marche pas sur les nouveaux comptes !"
  echo
  echo "Une petite liste d'apps à installer sur un nouveau Mac:"
  echo
  echo -e "  \\033[32m•\\033[0m Xcode"
  echo -e "  \\033[32m•\\033[0m Keynote"
  echo -e "  \\033[32m•\\033[0m Pages"
  echo -e "  \\033[32m•\\033[0m Numbers"
  echo -e "  \\033[32m•\\033[0m Harvest"
  echo -e "  \\033[32m•\\033[0m Skitch"
  echo
}

copy_files() {
  echo -e "\\033[32mCopying\\033[0m remote files..."
  for f in "${REMOTE_FILES[@]}"; do
    if [ ! -e "$HOME/$f" ]; then 
      echo -e "  \\033[32mCopying\\033[0m $f..."
      curl "$CONTENT_URL/$f" > "$HOME/$f"

      echo -e "  \\033[32mPatching\\033[0m $f..."
      sed -i -e "s/%NAME%/$NAME/g" "$HOME/$f"
      sed -i -e "s/%EMAIL%/$EMAIL/g" "$HOME/$f"
      sed -i -e "s/%GITHUB_USERNAME%/$GITHUB_USERNAME/g" "$HOME/$f"
    else
      echo -e "  \\033[31mSkipping\\033[0m $f (already present)"
    fi
  done
}

install_brew_files() {
  echo -e "\\033[32mInstalling\\033[0m Homebrew itself..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo -e "\\033[32mInstalling\\033[0m Homebrew dependencies..."
  pushd "$HOME"
    brew bundle
  popd
}

install_node_modules() {
  echo -e "\\033[32mConfiguring\\033[0m yarn..."
  yarn config set init-author-name "$NAME"
  yarn config set init-author-email "$EMAIL"
  yarn config set init-license "©2018 imagine-app"
  yarn config set yarn-offline-mirror .yarn-offline-cache
  yarn config set yarn-offline-mirror-pruning true

  echo -e "\\033[32mInstalling\\033[0m Node.js modules..."
  yarn global add "${NODE_MODULES[@]}"
}

install_ruby_gems() {
  echo -e "\\033[32mInstalling\\033[0m latest ruby using rbenv..."
  rbenv install "$RUBY_VERSION" --skip-existing 
  rbenv local "$RUBY_VERSION"
  echo "$RUBY_VERSION" > "$HOME/.ruby-version"

  echo -e "\\033[32mInstalling\\033[0m Ruby gems..."
  gem install "${GEMS[@]}" --no-ri --no-rdoc
}

install_python_eggs() {
  local python2_site_path=$(python2 -m site --user-site)
  local python2_version=$(python2 -c "import sys;print(str(sys.version_info.major) + '.' + str(sys.version_info.minor))")
  local python3_site_path=$(python3 -m site --user-site)
  local python3_version=$(python3 -c "import sys;print(str(sys.version_info.major) + '.' + str(sys.version_info.minor))")

  echo -e "\\033[32mInstalling\\033[0m Latest pip..."
  "easy_install-${python2_version}" pip
  "easy_install-${python3_version}" pip

  echo -e "\\033[32mInstalling\\033[0m Python eggs..."
  pip install -U "${PYTHON_PIPS[@]}" 
  pip3 install -U "${PYTHON_PIPS[@]}" 
}

install_go_modules() {
  echo -e "\\033[32mInstalling\\033[0m GCP components for go..."
  gcloud components update --quiet
  gcloud components install app-engine-go --quiet
  
  echo -e "\\033[32mInstalling\\033[0m go packages & tools..."
  for pkg in ${go_packages[@]}; do
    go get "$pkg"
  done
}

main
