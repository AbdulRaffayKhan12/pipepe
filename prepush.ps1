# Define where to save the org and env configuration
$configPath = "C:\Users\abdulraffay.khan\Downloads\New folder (3)\my-new-proxy\src\main\apigee\apiproxies\REVERSE-proxy-pipe\org-config.txt"

# Define available orgs and their corresponding environments
$orgs = @(
    @{
        name = "abacus-apigee-demo"
        envs = @("dev", "dev2")
    },
    @{
        name = "abacus-apigee-demo2"
        envs = @("demo", "sandbox")
    }
)

# Display org options
Write-Host "`nSelect the organization:"
for ($i = 0; $i -lt $orgs.Count; $i++) {
    Write-Host "$($i+1)) $($orgs[$i].name)"
}

# Prompt for org selection
$orgChoice = Read-Host "Enter choice number"
$orgIndex = [int]$orgChoice - 1

if ($orgIndex -lt 0 -or $orgIndex -ge $orgs.Count) {
    Write-Host "Invalid org selection. Exiting."
    exit 1
}

$selectedOrg = $orgs[$orgIndex].name
$availableEnvs = $orgs[$orgIndex].envs

# Display environments
Write-Host "`nEnvironments available for ${selectedOrg}:"
for ($i = 0; $i -lt $availableEnvs.Count; $i++) {
    Write-Host "$($i+1)) $($availableEnvs[$i])"
}

# Prompt for environment selection
$envChoice = Read-Host "Enter choice number"
$envIndex = [int]$envChoice - 1

if ($envIndex -lt 0 -or $envIndex -ge $availableEnvs.Count) {
    Write-Host "Invalid environment selection. Exiting."
    exit 1
}

$selectedEnv = $availableEnvs[$envIndex]

# Save selected org and env to config file
@"
org=$selectedOrg
env=$selectedEnv
"@ | Out-File -FilePath $configPath -Encoding utf8

Write-Host "`nSaved org and env to: $configPath"

# Optional: Trigger git push
git push origin main
