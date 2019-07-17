<#
	.SYNOPSIS
         Backs up files and directories to a specified location.
         
	.DESCRIPTION
		 Use function Backup-FilesFolders to backup source directories/files to a destination.
	       
	.PARAMETER Sources	
        Specify the source directory or file to be backed up (Can be multiple).
        
	.PARAMETER SourceFile
        Specify a text file containing a list of directories to be backed up. 
        
	.PARAMETER Destination	
        Specify the destination folder to save archived files/folders.
        
	.PARAMETER Compress	
		Archived files/folders will be saved in a Zip compressed archive.
 	       
	.PARAMETER Debuger	
		Debug mode.
		
	.EXAMPLE
		Backup single directory and save as compress archive.
		
		PS C:\> Backup-FilesFolders -Sources "C:\TestDirectory" -Destination "D:\BackupDirectory" -Compress
	
	.EXAMPLE
		Backup multiple directories listed in text file and compress archive.
		
        PS C:\> Backup-FilesFolders -SourceFile "C:\sourcelist.txt" -Destination "D:\BackupDirectory" -Compress
        
	.NOTES
		Author: Tony Cavella
		Blog  : https://revokehq.github.io
		
	.LINK
        https://github.com/revokehq/psbackup
        
	.LINK
		Backup-Utility	
#>

Function Start-Virtender
{
	[CmdletBinding()]
	Param
	(
		#Mode options
		[parameter()]
		[switch]$Debuger,
		[parameter()]
		[String]$ComputerName
	)

	Begin
	{
		If($PSBoundParameters['Debuger'])
		{
			$DebugPreference = "Continue"
		} #End If $PSBoundParameters['Debuger'] 

		Write-Debug "Checking for administrative privileges."
		$User = [Security.Principal.WindowsIdentity]::GetCurrent()
		$Role = (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

		If(!$Role)
		{
			Write-Warning "To perform some operations you must run an elevated Windows PowerShell console."	
		} #End If !$Role
		[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

  }

  Process
  {
		While($true)
		{
			$i++
			Write-Host "Loop number: $i"
			Get-WifiStatus
			Start-Sleep -Seconds 15
		}
  }

  End{}
}
Function Get-WifiStatus 
{
	$WifiStatus = Get-NetAdapter -Name "Wi-Fi" | Select-Object -ExpandProperty "Status"
	If($WifiStatus -ne "Up") 
	{
		Write-Verbose "Wi-Fi connection has been lost, restarting connection."
		$wifireset = [System.Windows.Forms.MessageBox]::Show("Wi-Fi connection has been lost, restarting connection.","Error: Wi-Fi Connection",0,48)

		If($WifiReset -eq "OK")
		{
			Disable-NetAdapter -Name "Wi-Fi"
			Start-Sleep -Seconds 3
			Enable-NetAdapter -Name "Wi-Fi"
		}
	}
}