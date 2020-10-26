#Retrieve data for one device assessment based on the ID number in the database.
#
#Usage is getDeviceDataByID id
#
param ($deviceAssessmentID)
#User defined data below
$projectURI = "https://iot2020-ee36c.firebaseio.com" # changes rarely
$uriPath = "deviceCheckResult" # changes rarely
#User defined data above

$deviceURI = "$projectURI/$uriPath/$deviceAssessmentID.json?print=pretty"

Invoke-RestMethod -Uri $deviceURI
