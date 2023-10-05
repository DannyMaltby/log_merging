#Get today's date
$Date = Get-Date -Format "yyyyMMdd"
$DateHumanReadable = Get-Date -Format "yyyyMMdd dddd dd-MM"

#Where the file is written to
$DestinationFile = "C:\Salamander\logs\All Sites Warnings\$DateHumanReadable.log"

#Specify the files
$TargetDirectory = "C:\Salamander\logs"
$Files = (Get-ChildItem -Path $TargetDirectory -Recurse | where {$_.name -Like "*-$Date*"}).FullName

#File Merge, purge redundant information, remove timestamp, then remove duplicate lines
foreach ($File in $Files)
{
	(Get-Content $File) -notmatch "Excluded from processing by ID|Pupil records from arbor|for map returning|for map pupil from|for map save to csv file from|for map azure user from|PupilLeaver records from arbor|for map pupilLeaver from|for map pupilLeaverAzure from|Staff records from arbor with additional data|for map staff from C:|StaffFuture records from arbor with additional data|There were|StaffLeaver records from arbor with additional data|map staffLeaver from C:|map staffLeaverAzure from C:|for map arbor writeback from C:|PupilFuture records from arbor with additional data|map students by house|map staff by site udf|90 days deleted|switch function should have a default value if no case statement evaluates to true" | ForEach-Object {$_.substring(24,$_.Length -24)} |  sort | get-unique | Add-Content $DestinationFile
}
