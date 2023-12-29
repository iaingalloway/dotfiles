Set-PSReadLineOption -EditMode Emacs
Invoke-Expression (&starship init powershell)

# dotnet
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
  param($commandName, $wordToComplete, $cursorPosition)
  dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}

# git
New-Alias g git
Import-Module posh-git

function gs { git status $args }
function ga { git add $args }

# kubectl
$KubectlCompletionScript = (kubectl completion powershell)
$KubectlCompletionScript | Out-String | Invoke-Expression

New-Alias k kubectl
$KubectlAliasCompletionScript = $KubectlCompletionScript -replace "kubectl", "k"
$KubectlAliasCompletionScript | Out-String | Invoke-Expression

function kclear { kubectl config unset current-context }
function kuse {
  param(
    [string]$Context
  )

  kubectl config use-context $Context
}

Register-ArgumentCompleter -CommandName kuse -ParameterName Context -ScriptBlock {
  param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
  $Contexts = (kubectl config get-contexts --output='name') | Where-Object { $_ -like "$wordToComplete*" }
  return $Contexts
}

#winget
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
  $Local:word = $wordToComplete.Replace('"', '""')
  $Local:ast = $commandAst.ToString().Replace('"', '""')
  winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}
