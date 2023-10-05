#Where the file is written to
$DestinationFile = "{Desired path of the output file, as well as desired output file name and extension}"

#Specify the files, this looks for files that includes the phrase -StaffMember
$TargetDirectory = "{Path to top directory where all the log files are stored}"
$Files = (Get-ChildItem -Path $TargetDirectory -Recurse | where {$_.name -Like "*-StaffMember*"}).FullName

#Create File
$Content = foreach ($File in $Files)
{
	Import-CSV $File | Select-Object *,@{Name="{identifier column for which is the origin file}";Expression={"$File"}} | Export-CSV $DestinationFile -NoTypeInformation -Force -Append
}

#Tidy up output file
$RemoveDuplicates = Import-CSV $DestinationFile | Sort-Object * -Unique
$RemoveDuplicates | Export-CSV $DestinationFile -NoTypeInformation -Force
