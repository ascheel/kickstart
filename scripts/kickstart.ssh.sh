# SSH dir
SSHDIR=$HOME/.ssh
if [[ ! -d "$SSHDIR" ]]; then
	echo "SSH directory not found.  Configuring."
	mkdir -p "$SSHDIR"
	chmod 700 $SSHDIR
fi

# SSH config
if [[ ! -f "$SSHDIR/config" ]]; then
	echo "SSH config not found.  Configuring."
	cat <<EOF >$SSHDIR/config
Host *
	IdentityFile $SSHDIR/id_ed25519

EOF
	chmod 600 $SSHDIR/config
fi

# SSH authorized_keys
if [[ ! -f "$SSHDIR/authorized_keys" ]]; then
	echo "SSH authorized_keys not found.  Configuring."
	touch $SSHDIR/authorized_keys
	chmod 600 $SSHDIR/authorized_keys
fi

# SSH key
if [[ ! -f "$SSHDIR/id_ed25519" ]]; then
	echo "SSH ed25519 key not found.  Configuring."
	ssh-keygen -t ed25519 -P '' -f $SSHDIR/id_ed25519
fi

