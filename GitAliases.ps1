function Get-GitStatus
{ & git status -sb 
}
New-Alias -Name gs -Value Get-GitStatus -Force -Option AllScope

function Get-GitCheckoutNewBranch
{ & git checkout -b $args 
}
New-Alias -Name gco -Value Get-GitCheckoutNewBranch -Force -Option AllScope

function Get-GitCheckoutBranch
{ & git checkout $args 
}
New-Alias -Name gcb -Value Get-GitCheckoutBranch -Force -Option AllScope

function Get-GitWorktreeAdd
{
  param(
    [string]$Path,
    [string]$Branch
  )
  git worktree add $Path $Branch
}
New-Alias -Name gwt -Value Get-GitWorktreeAdd -Force -Option AllScope

function Get-GitWorktreeCreateBranch
{
  param (
    [string]$Branch,
    [string]$Path
  )
  $branchName = $Path.split('/')[-1]
  git worktree add -b $branchName $Path
  $untrackedFiles = git ls-files --others --directory
  
  foreach ($file in $untrackedFiles)
  {
    $sourcePath = Resolve-Path $file
    $destinationPath = Join-Path $Path $file

    if (Test-Path $sourcePath -PathType Container)
    {
      if (!(Test-Path $destinationPath -PathType Container))
      {
        New-Item -ItemType Directory -Path $destinationPath
      }
    } else
    {
      Copy-Item $sourcePath $destinationPath -Force
    }
  }
  Set-Location $Path
}
New-Alias -Name gwtb -Value Get-GitWorktreeCreateBranch -Force -Option AllScope

function Get-GitWorktreeList
{ & git worktree list 
}
New-Alias -Name gwl -Value Get-GitWorktreeList -Force -Option AllScope

function Get-GitWorktreeRemove
{
  param (
    [string]$Path,
    [string]$Branch
  )
  git worktree remove $Path
  git branch -D $Branch
}
New-Alias -Name gwr -Value Get-GitWorktreeRemove -Force -Option AllScope

function Get-GitFetchAll
{ & git fetch -a 
}
New-Alias -Name gfa -Value Get-GitFetchAll -Force -Option AllScope

function Get-GitPushWithBranch
{
  param(
    [string]$Origin = "origin",
    [string]$Branch
  )
  git push -u $Origin $Branch
}
New-Alias -Name gpb -Value Get-GitPushWithBranch -Force -Option AllScope

function Get-GitBranchList
{ & git branch -a -l 
}
New-Alias -Name gbl -Value Get-GitBranchList -Force -Option AllScope

function Get-GitPull
{
  param(
    [string]$Branch   
  )

  git pull origin $Branch
}
New-Alias -Name gp -Value Get-GitPull -Force -Option AllScope

function Get-GitAddCommit
{
  param(
    [string]$Message
  )
  git add .
  git commit -m $Message
}
New-Alias -Name gc -Value Get-GitAddCommit -Force -Option AllScope

function Get-GitBranchDeleteForce
{
  param(
    [string]$Branch
  )
  git branch -D $Branch
}
New-Alias -Name gbd -Value Get-GitBranchDeleteForce -Force -Option AllScope
