param (
    [Parameter(Mandatory=$true)]$cliente = 0
)

$ErrorActionPreference= 'silentlycontinue'

$dataLog = (Get-Date).ToString('yyyy-MM-dd-HH')

function DeployFile($lista){
    
   
    '=============' >> "C:\Users\julio.gonzales\Desktop\teste\$cliente-$dataLog.Log"
    foreach ($item in $lista) {
        Try {
            
            $IPhost = [System.Net.Dns]::GetHostAddresses($item.hostname)
            Write-Host ('Iniciando Copia para o Host: ' + $IPhost)
            NET use ('\\' + $IPhost + '\c$') "/user:lmcorp\usr_conversor" "w7v)slad"
            robocopy "\\spgpfileserv\Publico\JulioGonzales\" "\\$IPhost\c$\Program Files (x86)\GenesysPrime" /R:1 /w:2
            $item.hostname + ' OK' >> "C:\Users\julio.gonzales\Desktop\teste\$cliente-$dataLog.Log"
            }
        catch {
            Write-Host ($IPhost +' Host Inacessivel')
            $item.hostname + ' ERRO '+ $_.Exception.Message >> "C:\Users\julio.gonzales\Desktop\teste\$cliente-$dataLog.Log"
      
            continue
        }
        Write-Host ('IP: ' + $IPhost)
        
    } 
    '=============' >> "C:\Users\julio.gonzales\Desktop\teste\$cliente-$dataLog.Log"
}


$Query = "SELECT DISTINCT h.name AS hostname FROM zabbix.hosts h WHERE h.host LIKE '%$cliente" + "UR%' AND STATUS=0;"
#$Query = "SELECT DISTINCT h.name AS hostname FROM zabbix.hosts h WHERE h.host LIKE '%$cliente%' AND STATUS=0;"
$MySQLAdminUserName = 'usr_agentzbx'
$MySQLAdminPassword = 'zabbix'
$MySQLDatabase = 'zabbix'
$MySQLHost = '10.81.1.204'
$ConnectionString = "server=" + $MySQLHost + ";port=3306;uid=" + $MySQLAdminUserName + ";pwd=" + $MySQLAdminPassword + ";database="+$MySQLDatabase

Try {
  [void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
  $Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
  $Connection.ConnectionString = $ConnectionString
  $Connection.Open()

  $Command = New-Object MySql.Data.MySqlClient.MySqlCommand($Query, $Connection)
  $DataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
  $DataSet = New-Object System.Data.DataSet
  $RecordCount = $dataAdapter.Fill($dataSet, "data")
  $lista = $DataSet.Tables[0]
  
  }

Catch {
   Write-Host $_.Exception.Message
 }

Finally {
  DeployFile($lista)
  $Connection.Close()
  
  }