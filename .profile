# Loads .bashrc on startup.
# by Aurélien Noce <aurelien.noce@imagine-app.fr>

if [ -n "$BASH_VERSION" ]; then
	if [ -f "$HOME/.bashrc" ]; then
		source "$HOME/.bashrc"
	fi
fi
