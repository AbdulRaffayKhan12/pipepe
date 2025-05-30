# Define the path to save the org-config.txt file
$configPath = "C:\Users\abdulraffay.khan\Downloads\New folder (3)\my-new-proxy\src\main\apigee\apiproxies\REVERSE-proxy-pipe\org-config.txt"

# Prompt the user for inputs
$org = Read-Host "Enter the org name"
$env = Read-Host "Enter the environment name"

# Save the variables to the file in simple key=value format
@"
org=$org
env=$env
"@ | Out-File -FilePath $configPath -Encoding utf8

Write-Host "Saved org and env to $configPath"
# Now run git push origin main
git push origin main