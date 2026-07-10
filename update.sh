#!/bin/bash

WORKDIR="$HOME/.cache/SDG-PKG/sdg-tips"

rm -rf "$HOME/.local/SDG-TIPS"
cp -r "$WORKDIR/local/"* "$HOME/.local/"

rm -rf "$HOME/.local/docs/SDG-TIPS" "$HOME/.local/tips/SDG-TIPS"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

sudo ln -sf "$HOME/.local/SDG-TIPS/sdg-tips" /usr/bin/sdgtip
sudo ln -sf "$HOME/.local/SDG-TIPS/sdg-tips" /usr/bin/tipme
sudo ln -sf "$HOME/.local/SDG-TIPS/sdg-tips" /usr/bin/alltips
