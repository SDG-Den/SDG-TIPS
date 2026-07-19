#!/bin/bash

LOCALDIR=SDG-TIPS
DOCDIR=SDG-TIPS
TIPDIR=SDG-TIPS
entrypoint=sdg-tips
command=sdgtip

WORKDIR=$(pwd)

rm -rf "$HOME/.local/docs/$DOCDIR" "$HOME/.local/tips/$TIPDIR" "$HOME/.local/$LOCALDIR"

mkdir -p "$HOME/.local/$LOCALDIR"
cp -r "$WORKDIR/config/"* "$HOME/.config/" 2>/dev/null || true
cp -r "$WORKDIR/local/"* "$HOME/.local/"
cp -r "$WORKDIR/docs/"* "$HOME/.local/docs/"
cp -r "$WORKDIR/tips/"* "$HOME/.local/tips/"

sudo ln -sf "$HOME/.local/$LOCALDIR/$entrypoint" /usr/bin/sdgtip
sudo ln -sf "$HOME/.local/$LOCALDIR/$entrypoint" /usr/bin/tipme
sudo ln -sf "$HOME/.local/$LOCALDIR/$entrypoint" /usr/bin/alltips

which $command || echo "INSTALL FAILED!"
