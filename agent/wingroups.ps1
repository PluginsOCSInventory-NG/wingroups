#################################
#            Groups             #
#################################
$xml = ""
# Add your SIDs here
$sidArray = @("S-1-5-32-544")  

foreach ($sid in $sidArray) {
    $elems = Get-LocalGroupMember -SID $sid -ErrorAction SilentlyContinue
    $group = Get-LocalGroup -SID $sid | Select Name

    foreach ($elem in $elems) {
        $elemType = $elem.ObjectClass
        $elemName = $elem.Name
        $elemSource = $elem.PrincipalSource
        $elemSID = $elem.SID
        $groupName = $group.Name

        $xml += "<WINGROUPS>`n"
        $xml += "<GROUPNAME>"+ $groupName +"</GROUPNAME>`n"
        $xml += "<NAME>"+ $elemName +"</NAME>`n"
        $xml += "<TYPE>"+ $elemType +"</TYPE>`n"
        $xml += "<SOURCE>"+ $elemSource +"</SOURCE>`n"
        $xml += "<SID>"+ $elemSID +"</SID>`n"
        $xml += "</WINGROUPS>`n"
    }
}

# Set output encoding to UTF-8 and display the XML string
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::WriteLine($xml)
