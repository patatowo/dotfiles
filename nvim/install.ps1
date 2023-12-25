    New-Item -ItemType Directory -Force -Path "$HOME\AppData\Local\nvim" 1>$null

Remove-Item -Recurse -Path "$HOME\AppData\Local\nvim\init.lua"
New-Item -ItemType SymbolicLink -Target "$PWD\init.lua" -Path "$HOME\AppData\Local\nvim\init.lua" 
