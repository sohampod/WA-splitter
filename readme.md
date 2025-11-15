# Productivity-Splitter: Dual-Client Launch Utility

This repository contains a simple yet powerful Windows automation script written in PowerShell to solve a common workflow inefficiency: manually launching and snapping multiple applications side-by-side.

This specific script instantly launches two different browser profiles (e.g., dedicated 'Work' and 'Personal' browser sessions) and automatically places them into a perfect 50/50 split-screen view, ready for parallel work.


# Key Features

One-Click Launch: Eliminates manual window management and alignment.

Persistent Profiles: Uses different browser profiles (e.g., 'Comet' and 'Zen') to maintain separate sessions for clients like WhatsApp Web.

PowerShell Execution Policy: Includes clear instructions on securely running the script using the -ExecutionPolicy Bypass flag via a shortcut.

Technical Focus: Demonstrates proficiency in using PowerShell for Win32 API interactions, process management, and timing control.

# Implementation Details

The core logic of the script relies on:

Process Management: Using Start-Process to launch the required browsers with specific profile arguments.

Window Manipulation: Utilizing the .NET Framework (specifically System.Windows.Forms.SendKeys) to simulate the keyboard input ($\text{Win} + \text{Left Arrow}$ and $\text{Win} + \text{Right Arrow}$) required to snap windows in Windows 10/11.

Timing Control: Employing Start-Sleep to introduce necessary delays, ensuring each browser fully loads before the snap command is sent.

# How to Use the Script

1. Save the Script

Save the Open_Split_WA.ps1 file to a secure location on your machine (e.g., C:\Scripts\).

2. Create the One-Click Shortcut (Mandatory Setup)

The script must be launched correctly using powershell.exe to allow for the temporary execution bypass and to pass the script path as an argument.

Right-click on your desktop and select New > Shortcut.

In the location field, paste the following command, replacing the path in quotes with the absolute path to your saved .ps1 file:

powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Scripts\Open_Split_WA.ps1"


Note: The -WindowStyle Hidden argument prevents the PowerShell terminal window from appearing on the screen.

Click Next, name your shortcut (e.g., "WA Dual Launch"), and click Finish.

Now, double-clicking the shortcut will execute the automation script instantly.


# Example Open_Split_WA.ps1 Content

(Assuming a structure where two distinct browser clients are used for two different WhatsApp sessions, e.g., using Chrome Profiles or standalone browsers like Comet/Zen.)

```
# Open_Split_WA.ps1
# This script launches two browser instances and snaps them side-by-side.

# --- Configuration ---
$BrowserPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$URL = "[https://web.whatsapp.com/](https://web.whatsapp.com/)"
$DelaySeconds = 2  # Time to wait for the browser to launch before snapping

# --- Launch & Snap First Instance (Left Side) ---
# NOTE: Replace --profile-directory with your specific profile name if using Chrome.
Start-Process -FilePath $BrowserPath -ArgumentList "--profile-directory=Comet", $URL

# Wait for the browser to open and become the active window
Start-Sleep -Seconds $DelaySeconds

# Send Win + Left Arrow (Requires .NET Framework)
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Windows.Forms.SendKeys]::SendWait("+(%{LEFT})") 
# Win+Left: (Alt + Shift + Left) is often used as a direct Win+Left replacement in SendKeys

# --- Launch & Snap Second Instance (Right Side) ---
Start-Process -FilePath $BrowserPath -ArgumentList "--profile-directory=Zen", $URL

# Wait for the second browser to open and become the active window
Start-Sleep -Seconds $DelaySeconds

# Send Win + Right Arrow
[System.Windows.Forms.SendKeys]::SendWait("+(%{RIGHT})")

# Script finished.


```