#!/bin/bash

rm -rf /home/$(whoami)/.local/SDG-TIPS
rm -rf /home/$(whoami)/.local/tips/SDG-TIPS
rm -rf /home/$(whoami)/.local/docs/SDG-TIPS
rm -f /home/$(whoami)/.config/tips.state

sudo unlink /usr/bin/sdgtip 2>/dev/null
sudo unlink /usr/bin/tipme 2>/dev/null
sudo unlink /usr/bin/alltips 2>/dev/null
