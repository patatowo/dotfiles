oh-my-posh init pwsh --config 'C:\Users\silvi\AppData\Local\Programs\oh-my-posh\themes\catppuccin.omp.json' | Invoke-Expression

# ALIAS

function qAlias { exit }
Set-Alias q qAlias

function gitAlias { Set-Location $HOME\Git }
Set-Alias gg gitAlias

function gitStatus { git status }
Set-Alias gs gitStatus

function gitAdd { git add --all }
Set-Alias ga gitAdd

function gitCommit { git commit -m @args }
del alias:gc -ErrorAction SilentlyContinue -Force
Set-Alias gc gitCommit

function gitPull { git pull @args }
Set-Alias gpl gitPull

function gitPush { 
  $branch = git rev-parse --abbrev-ref HEAD
  git push origin $branch
}
del alias:gp -ErrorAction SilentlyContinue -Force
Set-Alias gp gitPush

function gitCheckout { git checkout @args }
Set-Alias gco gitCheckout

# END ALIAS
