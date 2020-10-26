#Update the assessment check outcome for one device
#
#usage
# changeDeviceError id severity "message"
#
#Tip - To discover the id first use getDeviceDataByType
#
param($deviceID,$severityLevel,$message)

$projectURI = "https://iot2020-ee36c.firebaseio.com" #Changes rarely
$devicePath = "devices" #change rarely

$deviceURI = "$projectURI/$devicePath/$deviceID.json"

# Create hash table and convert to JSON.  Realtime is happy with JSON.
$databaseData = @{"$severityLevel"="$message"} | ConvertTo-Json 
Write-Host "Original record"
write-host "==============="
Invoke-RestMethod -Uri $deviceURI'?print=pretty'
Write-Host "New record"
write-host "=========="
Invoke-RestMethod -Method Patch -Uri $deviceURI -Body $databaseData
Invoke-RestMethod -Uri $deviceURI'?print=pretty' #Query the database with Get method (default) to proove the change.
