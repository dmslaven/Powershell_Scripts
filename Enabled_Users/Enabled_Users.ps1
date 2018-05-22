#---------------------------------------------Enabled Users-----------------------------------------------------
#Checks through active directory for users who are enabled or disabled

$ou = "" #Directory to Search in. Must include quotes Ex. "OU=Test,OU=Region,DC=company,DC=global"
$path = "" #File path to export to. Must be include quotes Ex:"C:\Enabled_Users.csv"

Get-ADUser -SearchBase $ou -Filter * -Properties Enabled | Where-Object {$_.Enabled -eq $True} | ? {$_.DistinguishedName -NotLike "*ou=Generic Accounts*"} | Select givenName,surname | sort-object Surname | export-csv -NoTypeInformation $path


#----------------------------------------------------NOTES----------------------------------------------------
#Where-Object {$_.Enabled -eq $True} ---- Turn to False if looking for disabled users
#
#? {$_.DistinguishedName -NotLike "*ou=Generic Accounts*"} ---- Can be eliminated if looking through ALL Organizational Units. Currently exludes "Generic Accounts" from report. Change "Generic Accounts" to any other OU if excluding specific OU.