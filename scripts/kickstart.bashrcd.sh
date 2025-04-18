# Create the directory
shopt -s dotglob
if [[ ! -d "${HOME}/.bashrc.d" ]]; then
	echo "Creating ~/.bashrc.d"
	mkdir $HOME/.bashrc.d
else
	echo "~/.bashrc.d already exists"
fi

# Copy files into place
rsync -a "${SCRIPT_DIR}"/files/.bashrc.d/ ~/.bashrc.d

# Ensure scripts are sourced
if ! fgrep ".bashrc.d" ~/.bashrc >/dev/null 2>&1; then
	echo ".bashrc.d not found in .bashrc.  Configuring."
	cat <<EOF >>~/.bashrc
# Load .bashrc.d
if [[ -d ~/.bashrc.d ]]; then
	for file in ~/.bashrc.d/*; do
		if [[ -f $file ]]; then
			source "$file"
		fi
	done
fi
EOF
fi

