#!/usr/bin/env bash
# DO NOT EDIT: installed by update-golang.sh

if ! echo "$PATH" | grep -Eq "(^|:)/usr/local/go/bin($|:)"
then
    export PATH=/usr/local/go/bin:$PATH
fi
if ! echo "$PATH" | grep -Eq "(^|:)$HOME/go/bin($|:)"
then
    export PATH=$PATH:$HOME/go/bin
fi
# update-golang.sh: end

# export PATH="/home/art/.local/bin:/home/art/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/mnt/c/Program Files/NVIDIA Corporation/NVIDIA NvDLISR:/mnt/c/WINDOWS/system32:/mnt/c/WINDOWS:/mnt/c/WINDOWS/System32/Wbem:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/:/mnt/c/WINDOWS/System32/OpenSSH/:/mnt/c/Program Files/dotnet/:/mnt/c/Users/Art/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/Art/AppData/Local/Programs/Microsoft VS Code/bin:/snap/bin:/usr/local/go/bin:/home/art/go/bin:/home/art/bin:/usr/local/go/bin"
