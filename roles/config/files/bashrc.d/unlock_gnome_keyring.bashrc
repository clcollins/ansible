#!/usr/bin/env sh

if [ -n "$DESKTOP_SESSION" ] && [ $(command -v gnome-keyring-daemon) ]
then
    for env_var in $(gnome-keyring-daemon --start); do
        export env_var
    done
fi

