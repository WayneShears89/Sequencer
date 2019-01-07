$dirlist = gci -Filter *.xml
$wdir = (get-location).path + "\"
$numOK = $false
do
{
	try
	{
		[int]$newseqnum = Read-host -Prompt "Enter the starting sequence number"
		$numOK = $true
	}
	catch
	{
		Write-Host -foregroundcolor Red "We need a number please!!"
	}
}
until ($numOK)
for ($i=0; $i -lt $dirlist.Count; $i++)
{
	$filename = $dirlist.name[$i]
	[xml]$XML = gc $filename
    $XML.POSBasket.Trailer.SequenceNumber = [string]$newseqnum
	$fpath = $wdir + $filename
    $XML.PreserveWhitespace = $true
	$XML.Save($fpath)
	Write-Host Amended sequence number in $filename to $newseqnum
	$newseqnum++
}
Write-Host Complete.