# pre-push.ps1

$org = Read-Host "Enter the organization name"
$env = Read-Host "Enter the environment name"

# Get the root directory of the git repo
$repoRoot = git rev-parse --show-toplevel

# Compose path to save the config file
$savePath = Join-Path $repoRoot "org-config.txt"

# Save the inputs to org-config.txt (overwrite existing)
"$org`n$env" | Out-File -FilePath $savePath -Encoding utf8 -Force

Write-Host "`n✔️  Saved organization and environment to org-config.txt"
