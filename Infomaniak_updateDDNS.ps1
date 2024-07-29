### script to update infomaniak.com DDNS with powershell
# if you need transcript for Schedule Task
#Start-Transcript -path "c:\ddns\logs\transcript.txt" -append
$hostname = "subdomain.mydomain.tld"

# you can choose another website like apify but need to adapt the powershell object
#ifconfig return only the ip this is why i choose it.
$ip = curl ifconfig.me
$username = "myusername"
$password = "mysuperpassword"

#api url from infomaniak source doc :https://www.infomaniak.com/fr/support/faq/2376/utiliser-dyndns-par-api-infomaniak
#if myip is not defined it use the external ip of the client by default (see doc from infomaniak)
$apiurl = "https://infomaniak.com/nic/update?hostname=$hostname&myip=$ip&username=$username&password=$password"
$response = Invoke-restMethod -uri $apiurl -method Post
$response
#Stop-Transcript
