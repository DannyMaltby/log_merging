#Where the file is written to
$DestinationFile = "C:\Salamander\accounts\All Sites Accounts\Staff Accounts.csv"

#Specify the files
$TargetDirectory = "C:\Salamander\accounts"
$Files = (Get-ChildItem -Path $TargetDirectory -Recurse | where {$_.name -Like "*-StaffMember*"}).FullName

#Create File
$Content = foreach ($File in $Files)
{
	Import-CSV $File | Select-Object *,@{Name="{identifier column for which is thorigin file}";Expression={"$File"}} | Export-CSV $DestinationFile -NoTypeInformation -Force -Append
}

#Fix File
$RemoveDuplicates = Import-CSV $DestinationFile | Sort-Object * -Unique
$RemoveDuplicates | Export-CSV $DestinationFile -NoTypeInformation -Force
