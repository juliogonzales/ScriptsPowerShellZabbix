#############################################################################################
#Version: 2.1
#Data:    06/2017
#Script Powershel para verificação de arquivos de 0 ou 1 kb
#Verifica na hora anterior, caso encontre, ele__retorna 0
#Caso não encontre,_____________________________retorna 1
#Caso o caminho não exista,_____________________retorna 5
#Caso o dretorio da hora estiver vazio,_________retorna 9

$ErrorActionPreference= 'silentlycontinue'
$data = (Get-Date).AddHours(-1).ToString('yyyy\\MM\\dd\\HH')
$path = "D:\Record\"+$data+"\"
$files = Get-ChildItem $path -Recurse | Where-Object {!$_.PSIsContainer} | Measure-Object

#Verifica se o caminho existe

Try {

	If(!(test-path $path)){
		Write-Output "5"
	}
#verifica se o diretorio esta vazio
	ELSEIF ($files.Count -eq 0){
		Write-Output "9"
	}
#se o caminho existir e nao estiver vazio, verifica se existem arquivos de menor/igual a 1kb	
	ELSE {
		$files = Get-ChildItem -Force $path -Recurse | ?{($_ -like "*.wav")
		}
	foreach ($i in $files){   
	
	}
	
	If ( $i.length -le 1024){ 
	   If ($files.Count -ge 4){
	       Write-Output "0"
	   }
	}
	ELSE{
		Write-Output "1"
		}
	}
 }

Catch {
   Write-Host $_.Exception.Message
}
