# gdCMD
Provides a Command Shell Prompt on Windows 2008 (and up) Server using Powershell's PSRemote.

Change Log - v3.3
=====

Provides a Command Shell Prompt on Windows 2008 (and up) Server using Powershell's PSRemote.

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
4. If your seeing a Kerberos Authentication Error, then run - KList purge
