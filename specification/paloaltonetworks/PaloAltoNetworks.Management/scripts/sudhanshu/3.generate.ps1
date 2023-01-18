Push-Location $PSScriptRoot

# generate examples in management folder
Push-Location ../../PaloAltoNetworks.Cloudngfw
Get-ChildItem -Include openapi.json -File -Recurse | ForEach-Object { $_.FullName } |
ForEach-Object {
  npx oav generate-examples $_
}
Pop-Location
Push-Location ../../
npx oav generate-examples openapi.json
Pop-Location

Pop-Location