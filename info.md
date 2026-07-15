Package Name: sdg-tips
Descriptive Name: SDG Tip-of-the-Day System
Source: https://github.com/SDG-Den/SDG-TIPS
Maintainer: SDGDen
Version:0.2.1

Dependencies: 
bash, coreutils (shuf, find, wc, mktemp), sed
Optional: fzf, cowsay, lolcat

Description: 
Modular tip-of-the-day system for SDG-OS. Aggregates tip files from every installed module's ~/.local/tips/<MODULE>/ directory. Commands: sdgtip (random), tipme (random), alltips (list browser). Features TOML-based module exclusion, cowsay/lolcat support, and fzf integration.
