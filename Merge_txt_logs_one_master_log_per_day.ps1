#Get today's date
$Date = Get-Date -Format "yyyyMMdd"
$DateHumanReadable = Get-Date -Format "yyyyMMdd dddd dd-MM"

#Where the file is written to
$DestinationFile = "{Desired destination file}"

#Specify the files
$TargetDirectory = "{Top folder of all desired log files}"
$Files = (Get-ChildItem -Path $TargetDirectory -Recurse | where {$_.name -Like "*-$Date*"}).FullName

#File Merge, purge redundant information, remove timestamp, then remove duplicate lines
foreach ($File in $Files)
{
	(Get-Content $File) -notmatch "{phrases that are unique to redundant lines that need removing, multiple entries seperated by a pipe '|'" | ForEach-Object {$_.substring(24,$_.Length -24)} |  sort | get-unique | Add-Content $DestinationFile
}
