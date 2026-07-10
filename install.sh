#!/bin/bash

WORKDIR="$HOME/.cache/SDG-PKG/sdg-tips"

cp -r "$WORKDIR/local/"* "$HOME/.local/"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

mkdir -p "$HOME/.config/SDG-TIPS"
[ ! -f "$HOME/.config/SDG-TIPS/config.toml" ] && cp "$WORKDIR/config/SDG-TIPS/config.toml" "$HOME/.config/SDG-TIPS/config.toml"

sudo ln -sf "$HOME/.local/SDG-TIPS/sdg-tips" /usr/bin/sdgtip
sudo ln -sf "$HOME/.local/SDG-TIPS/sdg-tips" /usr/bin/tipme
sudo ln -sf "$HOME/.local/SDG-TIPS/sdg-tips" /usr/bin/alltips

which sdgtip || echo "INSTALL FAILED!"
