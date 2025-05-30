# Define org options and corresponding envs
$orgOptions = @{
    "1" = @{ Name = "abacus apigee demo"; Envs = @("dev", "dev2") }
    "2" = @{ Name = "abacus apigee demo2"; Envs = @("test", "test-1") }
}

# Display orgs
Write-Host "Select the organization:"
$orgOptions.GetEnumerator() | ForEach-Object {
    Write-Host "$($_.Key)) $($_.Value.Name)"
}

# Get org selection
$orgSelection = Read-Host "Enter the number of the org you want to deploy (e.g., 1 or 2)"

if (-not $orgOptions.ContainsKey($orgSelection)) {
    Write-Host "Invalid selection. Exiting."
    exit 1
}

$selectedOrg = $orgOptions[$orgSelection].Name
$availableEnvs = $orgOptions[$orgSelection].Envs

# Display environments
Write-Host "`nEnvironments available for $selectedOrg:"
for ($i = 0; $i -lt $availableEnvs.Count; $i++) {
    Write-Host "$($i+1)) $($availableEnvs[$i])"
}

# Prompt for env selection (support multiple selections)
$envInput = Read-Host "Enter the number(s) of the environments you want to deploy (comma-separated, e.g., 1,2)"
$envIndices = $envInput -split ',' | ForEach-Object { $_.Trim() }

$selectedEnvs = @()
foreach ($index in $envIndices) {
    $envIndex = [int]$index - 1
    if ($envIndex -ge 0 -and $envIndex -lt $availableEnvs.Count) {
        $selectedEnvs += $availableEnvs[$envIndex]
    }
}

if ($selectedEnvs.Count -eq 0) {
    Write-Host "No valid environments selected. Exiting."
    exit 1
}

# Save config to file
$configPath = "C:\Users\abdulraffay.khan\Downloads\New folder (3)\my-new-proxy\src\main\apigee\apiproxies\REVERSE-proxy-pipe\org-config.txt"
@"
org=$selectedOrg
env=$($selectedEnvs -join ",")
"@ | Out-File -FilePath $configPath -Encoding utf8

Write-Host "`n✅ Saved the following configuration:"
Write-Host "org=$selectedOrg"
Write-Host "env=$($selectedEnvs -join ",")"
Write-Host "Config saved to: $configPath"

# Optional: push to Git (comment out if not needed)
# git push origin main
