


function DeployScript($hostname){
    $IPhost = [System.Net.Dns]::GetHostAddresses($hostname)[0].IPAddressToString
    NET use ('\\' + $IPhost + '\c$') "/user:lmcorp\usr_conversor" "w7v)slad"
    robocopy "\\spgpfileserv\Publico\JulioGonzales\" "\\$IPhost\c$\Program Files (x86)\GenesysPrime"  
}



DeployScript "SPOSMILESUR01"

