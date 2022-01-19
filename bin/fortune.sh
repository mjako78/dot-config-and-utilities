#!/bin/bash

# Funny script to show a random fortnues quote
# Dependencies: fortunes, cowsay, lolcat
which fortune > /dev/null || exit
which cowsay > /dev/null || exit
which lolcat > /dev/null || exit

fortune | cowsay -f tux | lolcat
