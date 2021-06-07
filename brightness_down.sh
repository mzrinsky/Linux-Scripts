#!/bin/sh
HOW_MUCH=5
if [[ "$1" != "" ]]; then
	HOW_MUCH=$1
fi
pkexec brillo -U $HOW_MUCH && rumno -b $(brillo)
