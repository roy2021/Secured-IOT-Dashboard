#Update the assessment check outcome for one device
#
#usage
# changeDeviceState id state "message"
#
#
#Tip - To discover the id first use getDeviceDataByType
#TIP - state can be either danger, warn or safe.
param($deviceID,$state,$message)

$projectURI = "https://iot2020-ee36c.firebaseio.com" #Changes rarely
$devicePath = "deviceCheckResult" #change rarely

$deviceURI = "$projectURI/$devicePath/$deviceID.json"

# Create hash table and convert to JSON.  Realtime is happy with JSON.
$databaseData = @{
    "message"="$message";
    "state"="$state";
    };
$databaseData = ConvertTo-Json -InputObject $databaseData
Write-Host "Original record"
write-host "==============="
Invoke-RestMethod -Uri $deviceURI'?print=pretty'
Write-Host "New record"
write-host "=========="
Invoke-RestMethod -Method Patch -Uri $deviceURI -Body $databaseData
Invoke-RestMethod -Uri $deviceURI'?print=pretty' #Query the database with Get method (default) to proove the change.
