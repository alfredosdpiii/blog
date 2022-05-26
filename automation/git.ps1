Set-Location ..
git add .

# helpers 
# for clearing console
function Use-Clear
{
  if (($IsLogEnabled -eq "Y") -or ($IsLogEnabled -eq "y"))
  {
    Clear-Host
  }
}


Write-Host "For Clearing Logs"
Write-Host "Enter"
Write-Host "Y/y - for logs disabled"
Write-Host "N/n - for logs enabled"
$IsLogEnabled = Read-Host

Use-Clear

Write-Host "For Git Workflow"
Write-Host "Enter"
Write-Host "1 - for Normal commit"
$CommitPath = Read-Host

Use-Clear

if ( $CommitPath -eq 1 )
{
  Write-Host "Enter Commit message: " -NoNewLine
  $CommitMessage = Read-Host
  git commit -m $($CommitMessage)

} 

Use-Clear

Write-Host "Pushing Updates Please wait..."
Write-Host ""

git push

Use-Clear

Set-Location automation
