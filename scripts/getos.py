#!/usr/bin/env python3

import os
import platform
import argparse


class Detect:
    def __init__(self, **kwargs):
        self.get_distro  = kwargs.get('get_distro')
        self.get_version = kwargs.get('get_version')
    
    @property
    def distro(self):
        if self.is_ubuntu:
            return 'ubuntu'
        elif self.is_amazon_linux_1:
            return 'amazon_linux_1'
        elif self.is_amazon_linux_2:
            return 'amazon_linux_2'
        elif self.is_amazon_linux_3 or self.is_amazon_linux_2023:
            return 'amazon_linux_3'
        elif self.is_amazon_linux:
            return 'amazon_linux'
        elif self.is_centos:
            return 'centos'
        elif self.is_debian:
            return 'debian'
        elif self.is_redhat:
            return 'redhat'
        else:
            return 'unknown'
    
    @property
    def is_centos(self):
        # Not yet supported.
        return False
    
    @property
    def is_debian(self):
        # Not yet supported.
        return False
    
    @property
    def is_redhat(self):
        # Not yet supported.
        return False

    @property
    def is_wsl(self):
        return 'WSL' in platform.uname().release

    @property
    def is_ubuntu(self):
        return self.os_release_line('NAME').lower() == 'ubuntu'

    @property
    def is_amazon_linux(self):
        return self.os_release_line('NAME').lower() == 'amazon linux'

    @property
    def is_amazon_linux_1(self):
        return self.is_amazon_linux and self.version == '1'

    @property
    def is_amazon_linux_2(self):
        return self.is_amazon_linux and self.version == '2'

    @property
    def is_amazon_linux_3(self):
        return self.is_amazon_linux and self.version == '2023'

    @property
    def is_amazon_linux_2023(self):
        return self.is_amazon_linux_3

    @property
    def pretty_name(self):
        return self.os_release_line('PRETTY_NAME')

    @property
    def version(self):
        return self.os_release_line('VERSION_ID')    

    def os_release_line(self, key):
        _file_list = [
            '/etc/os-release',
            '/usr/lib/os-release'
        ]
        for _file in _file_list:
            if os.path.isfile(_file):
                with open(_file, 'r') as f_in:
                    for line in f_in:
                        line = line.strip()
                        if '=' not in line:
                            continue
                        _key, _value = line.split('=')
                        if _key == key:
                            if _value.startswith('"'):
                                _value = _value[1:]
                            if _value.endswith('"'):
                                _value = _value[:-1]
                            return _value
        raise ValueError(f'Key {key} does not exist.')

    def print(self):
        if self.get_distro:
            print(self.distro)
        elif self.get_version:
            print(self.version)
        else:
            print(self.pretty_name)


def main():
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        '-d',
        '--distro',
        help='Get distro name',
        action='store_true'
    )
    group.add_argument(
        '-v',
        '--version',
        help='Get distro version',
        action='store_true'
    )
    args = parser.parse_args()
    detect = Detect(
        get_distro=args.distro,
        get_version=args.version
    )
    detect.print()


if __name__ == "__main__":
    main()
