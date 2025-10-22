# Download Fooocus

$i=Invoke-WebRequest -Uri https://github.com/lllyasviel/Fooocus
foreach ($n in $i.content.split()) {if ($n -match 'https://github.com/lllyasviel/Fooocus/releases/download/'){$url=[Regex]::Match($n, '(?<="\s*)[^"]+').Value.Replace('\','')}}
[string]$7z="$PWD"+'\temp'
[string]$version="v$($url.substring($url.length-8,5).Replace('-','.'))"

.\wget --no-hsts -q $url -O .\Fooocus.7z
Invoke-Expression ".\7z\7za.exe x .\Fooocus.7z -o$7z"

$zipName=(dir -Directory .\temp).name
mv .\temp\$zipName\* .\build
rm -Recurse -Force .\build\Fooocus

git clone https://github.com/lllyasviel/Fooocus --branch $env:GH_CI_TAG --single-branch .\build\Fooocus
Rename-Item .\build\Fooocus\models _models
mkdir .\build\Fooocus\models
rm .\build\*.bat



# Build ltsc2022

if ($env:GH_CI_LATEST -eq "true") {
    docker build --isolation hyperv --no-cache --pull -t eisai/fooocus:latest -t eisai/fooocus:$env:GH_CI_TAG .\build
} else {
    docker build --isolation hyperv --no-cache --pull -t eisai/fooocus:$env:GH_CI_TAG .\build
}

# Push
if ($env:GH_CI_PUSH -eq "true") {
    docker push eisai/ollama -a
}

# Clean up
docker system prune --all -f



# Build ltsc2025

$i=Get-Content -Path .\build\Dockerfile
Set-Content -Path .\build\Dockerfile -Value $($i.replace("FROM mcr.microsoft.com/windows/server:ltsc2022","FROM mcr.microsoft.com/windows/server:ltsc2025"))

if ($env:GH_CI_LATEST -eq "true") {
    docker build --isolation hyperv --no-cache --pull -t eisai/fooocus:ltsc2025 -t eisai/fooocus:$env:GH_CI_TAG-ltsc2025 .\build
} else {
    docker build --isolation hyperv --no-cache --pull -t eisai/fooocus:$env:GH_CI_TAG-ltsc2025 .\build
}

# Push
if ($env:GH_CI_PUSH -eq "true") {
    docker push eisai/ollama -a
}
