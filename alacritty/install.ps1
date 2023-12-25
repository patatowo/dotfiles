New-Item -Path "$env:APPDATA" -Name "alacritty" -ItemType "directory"
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\alacritty\alacritty.yml" -Target "$PWD\alacritty.yml"
