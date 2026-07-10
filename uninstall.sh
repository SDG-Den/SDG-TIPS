#!/bin/bash

rm -rf "$HOME/.local/SDG-TIPS"
rm -rf "$HOME/.local/tips/SDG-TIPS"
rm -rf "$HOME/.local/docs/SDG-TIPS"

sudo unlink /usr/bin/sdgtip 2>/dev/null
sudo unlink /usr/bin/tipme 2>/dev/null
sudo unlink /usr/bin/alltips 2>/dev/null
