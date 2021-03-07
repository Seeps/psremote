$computerhost = Read-Host -Prompt 'Please enter the hostname'
$cred = get-credential
$session = new-pssession -computername $computerhost -SessionOption (New-PSSessionOption -NoMachineProfile) -credential $cred

function Show-Menu
{
    param (
        [string]$Title = 'PS Remote'
    )
    Clear-Host
    Write-Host "///////////////// $Title \\\\\\\\\\\\\\\\\"
    
    Write-Host "1: Press '1' to enter an interactive session."
    Write-Host "2: Press '2' to copy files to host."
    Write-Host "3: Press '3' to copy files from host."
    Write-Host "Q: Press 'Q' to quit."
}
 
do
 {
     Show-Menu
     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
		   '1' {
             enter-pssession $session
			 Write-Host "Entering session...success!"
			 exit
         } '2' {
			 $sourcepath = Read-Host -Prompt 'Enter source path'
			 $destpath = Read-Host -Prompt 'Enter destination path'
			 Copy-Item -Path $sourcepath -Destination $destpath -ToSession $session
			 Write-Host "Success"
         } '3' {
			 $sourcepath = Read-Host -Prompt 'Enter source path'
			 $destpath = Read-Host -Prompt 'Enter destination path'
			 Copy-Item -Path $sourcepath -Destination $destpath -FromSession $session
			 Write-Host "Success"
         }
     }
     pause
 }
 until ($selection -eq 'q')