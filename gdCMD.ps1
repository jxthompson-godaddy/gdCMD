<#
	Provides a Powershell Prompt on Windows 2008 (and up) Server using Powershells PSSession.
	Author: Jon Thompson
	Email: jxthompson@godaddy.com
	Version: 3.4
#>

# Setting up Incoming Params
param(
	[string]$priValue
)

# A Function for Variable Cleaning
Function Clean-Memory {
Get-Variable |
Where-Object { $startupVariables -notcontains $_.Name } |

ForEach-Object {

    try { Remove-Variable -Name "$($_.Name)" -Force -Scope "global" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue}
        catch { }
    }

}


# Clean and Format Param Data
$priValue = $priValue.Trim().ToUpper()


# Path to be generated - C:\Users\USER_NAME\AppData\Local\gdApps\GDHOSTING\chap.txt
$myChapPath = "$Env:LocalAppData\gdApps\GDHOSTING\"
$myChapFile = "chap.txt"
$myChapSet = $myChapPath + $myChapFile


# Function to Build the Chap
function setCHAP {

	# Create the Chap
	if ((Test-Path $myChapSet) -eq $FALSE) {
		New-Item $myChapPath -ItemType directory -Force | Out-Null
		New-Item $myChapFile -ItemType file -Force | Out-Null
		Write-Host
		Write-Host "*** Setting your Password File ***" -ForegroundColor Yellow
		Write-Host "We don't see that you have setup a password file for GDHOSTING."
		Write-Host "Let's create your password file now. Please enter your password for your GDHOSTING User:"
		Write-Host
		Read-Host -AsSecureString | ConvertFrom-SecureString | Out-file $myChapSet
		Write-Host
		Write-Host "Thank you! Password File has been set for the GDHOSTING Domain"
		Write-Host "Now enter in .\gdCMD.ps1 HOSTNAME to connect to a Windows Host."
		Write-Host
	}
	# Update the Chap
	else{
		Write-Host
		Write-Host "*** Updating your Password File ***" -ForegroundColor Yellow
		Write-Host "You have requested to update your password file."
		Write-Host "Please enter your password for your GDHOSTING User:"
		Write-Host
		Read-Host -AsSecureString | ConvertFrom-SecureString | Out-file $myChapSet
		Write-Host
		Write-Host "Thank you! Password File has been updated for the GDHOSTING Domain"
		Write-Host
	}
}


# Checking Paramater Values and App
if($priValue -eq "set"){
	setCHAP
}
elseif ($priValue -ne "") {
	if ((Test-Path $myChapSet) -eq $FALSE) {
		setCHAP
	}
	else {

		# Switch by Paul Smith
		switch -wildcard ($priValue){
		'p3nwvpweb*' { $formattedsysName = "$priValue.PHX3.GDHOSTING.GDG" }
  		'p3nwshhv*' { $formattedsysName =  "$priValue.GDHOSTING.GDG" }
		'a2nwvpweb*' { $formattedsysName =  "$priValue.IAD2.GDHOSTING.GDG" }
  		'a2nwshhv*' { $formattedsysName =  "$priValue.GDHOSTING.GDG" }
		'sg2*' { $formattedsysName =  "$priValue.SIN2.GDHOSTING.GDG" }
		'n3*' { $formattedsysName =  "$priValue.AMS1.GDHOSTING.GDG" }
		default { $formattedsysName = $priValue }
	}

	Write-Host
	Write-Host
	Write-Host 'Hello'$env:UserName'.'
	Write-Host 'Attempting a connection to:'$formattedsysName'...'
	Write-Host
	Write-Host
	Write-Host


		# Run a Ping to make sure the host is ALIVE #
		if (Test-Connection $formattedsysName -Count 1 -Quiet) {
			$password = get-content $myChapSet | ConvertTo-SecureString
			$credentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist "GDHOSTING\$env:UserName",$password
			Enter-PSSession -ComputerName $formattedsysName -Credential $credentials
		}

		# Server is dead, run a constant ping to show when the host is ALIVE
		else {
			Write-Host "*** WARNING ***" -ForegroundColor Red
			Write-Host "Server is not pinging, please open a KVM Sessions or send a reboot request."
			Write-Host
			while($TRUE){Test-Connection -Quiet $formattedsysName}
		}
}
}
else{
	# No Paramater Value Set - Basic Help File
	Write-Host
	Write-Host "*** gdCMD Help Information ***" -ForegroundColor Yellow
	Write-Host "Please make sure to add a server name such as .\gdCMD.ps1 P3NW8SHG332."
	Write-Host "If you need to change your GDHOSTING Password, enter in .\gdCMD.ps1 SET"
	Write-Host
}

# Cleaning Variable Memory
Clean-Memory
