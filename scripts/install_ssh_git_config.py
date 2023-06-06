#!/usr/bin/env python3

import os


class Install:
    def __init__(self):
        self.HOME = os.path.expanduser('~')
        self.sshdir = os.path.join(self.HOME, '.ssh')
        self.config = os.path.join(self.sshdir, 'config')
    
    def exists(self):
        if not os.path.isfile(self.config):
            return False
        with open(self.config, 'r') as f_in:
            for line in f_in:
                line = line.strip()
                if 'github.com' in line:
                    return True
        return False

    def install(self):
        if not self.exists():
            text = [
                "",
                "Host github.com",
                "\tUser git",
                "\tIdentityFile ~/.ssh/id_rsa_github"
            ]
            open(self.config, 'a').write('\n'.join(text))


def main():
    install = Install()
    install.install()

if __name__ == "__main__":
    main()
