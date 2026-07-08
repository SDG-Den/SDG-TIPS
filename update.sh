#!/bin/bash

WORKDIR=/home/$(whoami)/.cache/SDG-PKG/sdg-tips

rm -rf /home/$(whoami)/.local/SDG-TIPS
cp -r $WORKDIR/local/SDG-TIPS/* /home/$(whoami)/.local/SDG-TIPS/
chmod a+x /home/$(whoami)/.local/SDG-TIPS/sdg-tips

rm -rf /home/$(whoami)/.local/tips/SDG-TIPS
mkdir -p /home/$(whoami)/.local/tips/SDG-TIPS
cp $WORKDIR/local/SDG-TIPS/tips.list /home/$(whoami)/.local/tips/SDG-TIPS/tips.list
[ -d $WORKDIR/tips/SDG-TIPS ] && cp -r $WORKDIR/tips/SDG-TIPS/* /home/$(whoami)/.local/tips/SDG-TIPS/

rm -rf /home/$(whoami)/.local/docs/SDG-TIPS
mkdir -p /home/$(whoami)/.local/docs/SDG-TIPS
cp -r $WORKDIR/docs/* /home/$(whoami)/.local/docs/SDG-TIPS/

sudo ln -sf /home/$(whoami)/.local/SDG-TIPS/sdg-tips /usr/bin/sdgtip
sudo ln -sf /home/$(whoami)/.local/SDG-TIPS/sdg-tips /usr/bin/tipme
sudo ln -sf /home/$(whoami)/.local/SDG-TIPS/sdg-tips /usr/bin/alltips
