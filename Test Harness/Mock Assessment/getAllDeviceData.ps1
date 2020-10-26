#List all device data
#
#usage
# getAllDeviceData
#

$projectURI = "https://iot2020-ee36c.firebaseio.com" #Changes rarely
$devicePath = "deviceCheckResult" #change rarely

$deviceURI = "$projectURI/$devicePath.json"

Invoke-RestMethod -Uri $deviceURI #Query the database with Get method (default).
