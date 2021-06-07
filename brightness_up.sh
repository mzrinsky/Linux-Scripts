#!/bin/sh

HOW_MUCH=2
if [[ "$1" != "" ]]; then
	HOW_MUCH=$1
fi
pkexec brillo -A $HOW_MUCH && rumno -b $(brillo)
