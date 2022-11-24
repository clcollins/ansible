#!/usr/bin/env sh
# Golang Helper functions

function gopath () {
    if [ -z "$GOPATH" ]
    then
      echo "GOPATH not set..."
      exit 1
    fi

    local gopath="${GOPATH}"
    local max_index="$(awk -F: '{ print NF }' <<< \"${gopath}\")"
    local re="^[0-9]+$"

    if [[ "${1}" =~ ${re} ]]
    then
      local index="${1}"
    else
      printf "${gopath}\n"
      return
    fi

    # Increment index because awk doesn't start with 0
    ((index++))

    if [ "${index}" -gt "${max_index}" ]
    then
      printf "ERROR: index out of range\n"
    fi

    # Print the directory from $gopath at $index
    awk -v ind=${index} '{split($0, gopaths, ":"); print gopaths[ind]}' <<< "${gopath}"
}

function gosrc () {
    if [ -z "$GOPATH" ]
    then
      echo "GOPATH not set..."
      exit 1
    fi

    read -p "Change directory to ${GOPATH}/src/github.com/clcollins? (y/n) " \
	-n 1 -r
    echo    # newline
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    else
        cd $GOPATH/src/github.com/clcollins
    fi
}