#!/usr/bin/env bash

# Call me from the web:
#
#   $ curl https://raw.githubusercontent.com/imagine-app/setup-iapp/master/install.sh | bash
#

set -e
set -u

CONTENT_URL="https://raw.githubusercontent.com/imagine-app/setup-iapp/master"
REMOTE_FILES=(Brewfile .bashrc .gitconfig .profile .bundle.config)
GEMS=(sass rails nokogiri)
NODE_MODULES=(create-react-app create-react-native-app typescript react-scripts-ts express)

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
  reload_env

  install_brew_files
  install_node_modules
  install_ruby_gems

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

reload_env() {
  echo -e "\\033[32mReloading\\033[0m bash config..."
  set +u
  source "$HOME/.bashrc" # re-load the config !
  set -u
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
  echo -e "\\033[32mInstalling\\033[0m Ruby gems..."
  gem install "${GEMS[@]}" --no-ri --no-rdoc
}

main
