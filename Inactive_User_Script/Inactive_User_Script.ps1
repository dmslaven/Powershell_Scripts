#POWERSHELL script to search active directory for users who have not logged on in the past x days. 

$ou = "" #Directory to Search in. Must include quotes Ex. "OU=Test,OU=Region,DC=company,DC=global"
$path = "" #File path to export to. Must be include quotes Ex:"C:\90_Day_Inactive_Users.csv"


Search-ADAccount -SearchBase $ou -UsersOnly -AccountInactive -TimeSpan 90.00:00:00 |where {$_.enabled} | ? {$_.DistinguishedName -NotLike "*ou=Generic Accounts*"} | Export-CSV –path $path

#-----------------------------------------------------------------------NOTES-------------------------------------------------------------------------------
#? {$_.DistinguishedName -NotLike "*ou=Generic Accounts*"} ---- Can be eliminated if looking through ALL Organizational Units. Currently exludes "Generic Accounts" from report. Change "Generic Accounts" to any other OU if excluding specific OU.
#
# Timespan can be adjusted for days. Currently set for 90 days