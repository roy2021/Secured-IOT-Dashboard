#Load devices from JSON.  Will replace existing children.
#
#Usage is loadBulkDevices filename.json
#
#User defined data below

param ($jsonFile)
$jsonFile='./'+"$jsonFile" #Assume local directory

$projectURI = "https://iot2020-ee36c.firebaseio.com" # changes rarely
$uriPath = "" # changes rarely

$jsonDevices = Get-Content -Path $jsonFile

#write-host $devicesFromFile #uncomment when troubleshooting
#These convsersions can kind of validate the JSON.  Uncomment if needed.
#$jsonDevices = ConvertFrom-Json -InputObject $jsonDevices
#$jsonDevices = ConvertTo-Json -InputObject $jsonDevices
#Write-Host $jsonDevices #uncomment when troubleshooting


$fullURLPath = "$projectURI/$uriPath.json"

Invoke-RestMethod -Method Patch -Uri $fullURLPath -Body $jsonDevices
