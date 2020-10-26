#Retrieve data for all device assessments for the type of device specified.
#
#Usage is 
# getDeviceDataByType type
#
param ($type)
#User defined data below
$projectURI = "https://iot2020-ee36c.firebaseio.com" # changes rarely
$uriPath = "deviceCheckResult" # changes rarely
#User defined data above

$name = '"type"' #Must be enclosed in double quotes.
$type = "`"$type`"" #Must be enclosed in double quotes.

$deviceURI = "$projectURI/$uriPath/$deviceAssessmentID.json?print=pretty&equalTo=$type&orderBy=$name"
#write-host $deviceURI # uncomment when troubleshooting
Invoke-RestMethod -Uri $deviceURI | Format-List
