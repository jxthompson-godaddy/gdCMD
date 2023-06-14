# gdCMD
Provides a Command Shell Prompt on Windows 2008 (and up) Server using Powershell's PSRemote.

Change Log - v3.4
=====

Provides a Command Shell Prompt on Windows 2008 (and up) Server using Powershell's PSRemote.

  3.4 - Updated N1 to N3 as all Plesk hosts are now in N3

  3.3 - Added Variable Cleaning

  3.2 - Added Color for Warnings and Help Sections

  3.1 - Added Support to check WSMan Trusted Hosts
  
  3.0 - Adds password management for GDHOSTING and a few small bug fixes, cleaned code.
  
  2.2 - Fix a bug for when a server was not added.
  
  2.1 - General Clean up, fixed a small problem I was running into with Remoting.
  
  2.0 - Switched to PSRemote instead of PSExec. Added supported for Encrypted Login.
  
  1.1 - Converted to Powershell from CMD.


If you have any issues running this script, please follow the below.

1. To setup powershell, here is a great local article - https://confluence.godaddy.com/display/EB/Powershell+Script+Execution+Guide
2. Make sure to set the execution policy (covered above as well) - Set-ExecutionPolicy RemoteSigned
3. Make sure to add gdhosting to the trusted hosts list - Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value '*.gdhosting.gdg' -Force | Out-Null
    A. If you still have problems with the above and getting the same error. Just manually update your systems Registry with "regedit"
    B. In Regedit you can paste this into find to open it up
        [Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client]
    C. Delete what you have for domains and replace with this.
        *.jomax.paholdings.com,*.dc1.corp.gd,*.int.godaddy.com,*.prod.iad2.gdg,*.prod.iad2.secureserver.net,*.iad2.gdg,*.gdhosting.gdg,*.phx3.gdhosting.gdg,*.ams1.gdhosting.gdg,*.sin2.gdhosting.gdg,*.prod.phx3.gdg,*.cloud.phx3.gdg
5. If your seeing a Kerberos Authentication Error, then run - KList purge
