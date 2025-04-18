# No gitconfig?
GITCONFIG=~/.gitconfig
if [[ ! -f $GITCONFIG ]]; then
	echo "Git config not found.  Configuring."
	git config --global user.email "$(yq -r '.git.email' "${CONFIGFILE}")"
	git config --global user.name "$(yq -r '.git.name' "${CONFIGFILE}")"
fi

# No email configured?
if ! fgrep "email =" $GITCONFIG >/dev/null 2>&1; then
	echo "Git email not configured.  Configuring."
	git config --global user.email "$(yq -r '.git.email' "${CONFIGFILE}")"
fi

# No name configured?
if ! fgrep "name = " $GITCONFIG >/dev/null 2>&1; then
	echo "Git name not configured.  Configuring."
	_name=$(yq -r '.git.name' "${CONFIGFILE}")
	git config --global user.name "Art Scheel"
fi

if ! fgrep "github.com" ~/.ssh/config >/dev/null 2>&1; then
    echo "GitHub SSH config not found.  Configuring."
    # GitHub SSH config
    cat <<EOF >>~/.ssh/config
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
EOF
fi
