------------------------------------------------------------------------------------------------

                              AutoSetDNS by TheBrightMountain 

                              https://github.com/TheBrightMountain

------------------------------------------------------------------------------------------------

📘 What is AutoSetDNS?

AutoSetDNS is a lightweight tool that automatically configures your DNS settings based on the values defined in `AutoSetDNS.config.json`.

When you run `Install.exe`, it registers a scheduled task named AutoSetDNS in Windows Task Scheduler. This task monitors network connections and updates the DNS settings automatically to your preferred DNS servers.

By default, it uses Cloudflare DNS (1.1.1.1, 1.0.0.1), but you can easily customize it.

When you run `Uninstall.exe`, it removes the AutoSetDNS scheduled task from your system.


------------------------------------------------------------------------------------------------

⚠️ Caution: False Positive Detected

Some antivirus engines like VirusTotal may flag the AutoSetDNS.exe, Install.exe, or Uninstall.exe files as potentially dangerous. These alerts are false positives.

These .exe files are compiled from clean, transparent PowerShell source code that has been reviewed and verified to:

    Only perform local DNS configuration

    Never access the internet or modify sensitive system areas

    Use legitimate Windows Task Scheduler functionality

    Include no obfuscation, encryption, or malicious logic

These detections are likely triggered because the executables:

    Interact with system settings (like DNS)

    Register scheduled tasks (a common malware behavior)

If you prefer, you can run the scripts directly instead of using the .exe versions. Alternatively, you can compile the PowerShell Scripts to EXE yourself (only recommended if you know what you are doing).

------------------------------------------------------------------------------------------------

🛠️ Compile PowerShell Scripts to EXE (Optional, Advanced Users)

📦 Step 1: Install PS2EXE

Open PowerShell as Administrator

Run this command to install the PS2EXE module:

Install-Module -Name ps2exe -Scope CurrentUser

If prompted, type Y to trust the repository.

📄 Step 2: Compile the Scripts

Navigate to the source folder with the .ps1 files, then run:

Invoke-PS2EXE .\AutoSetDNS.ps1 .\AutoSetDNS.exe
Invoke-PS2EXE .\Install.ps1 .\Install.exe
Invoke-PS2EXE .\Uninstall.ps1 .\Uninstall.exe

✅ Done!

You now have self-built .exe files from clean source code — no surprises, no false positives. Use Install.exe to set it up, and Uninstall.exe to remove it later.

------------------------------------------------------------------------------------------------

✅ Benefits of AutoSetDNS

1. Automatic DNS Configuration

    No need to manually set your DNS every time you connect to a network. Set it and forget it.

    Great for people who frequently switch between networks (home, work, public Wi-Fi, etc.).

    Once installed, it works silently in the background using Task Scheduler.

    No service running 24/7. Minimal system resource usage.

2. Faster & More Private DNS

    By default, it uses Cloudflare DNS (1.1.1.1), which is:

        Fast – lower latency compared to many ISP DNS servers.

        Private – Fully offline. Doesn't log your IP or sell your data like some ISPs.
    
    You can ofcourse set your preferred DNS in the config file.

3. Bypass ISP Restrictions / DNS Censorship

    ISPs sometimes block access to websites.

    Using a trusted external DNS (like Cloudflare, Google DNS, or others) helps you:

        Bypass blocked or censored sites

        Avoid redirections or ads injected by some ISPs

4. No bloatware

🔍 Similar Tools / Apps compare to AutoSetDNS

| Tool / App         | Auto DNS Switching | Open Source | Lightweight | Notes 
|--------------------|--------------------|-------------|-------------|-------------------------
| AutoSetDNS         | ✅ Yes             | ✅ Yes     | ✅ Very    | Minimal + customizable
| NetSetMan          | ⚠️ Manual profiles | ❌ No      | ⚠️ Mid     | Feature-rich, but heavy and manual
| DNS Jumper         | ❌ No              | ❌ No      | ✅ Yes     | Quick switcher, but no automation
| Simple DNSCrypt    | ⚠️ DNSCrypt only   | ✅ Yes     | ⚠️ Medium  | Focused on encrypted DNS, not plain DNS
| YogaDNS            | ✅ Yes             | ❌ No      | ⚠️ Mid     | GUI, supports DoH/DoT, more complex
| Acrylic DNS Proxy  | ❌ No              | ✅ Yes     | ⚠️ Complex | DNS caching + filtering, but not plug & play
(source: chatgpt.com)

------------------------------------------------------------------------------------------------

🛠️ How to Install

1. (Optional) Open `AutoSetDNS.config.json` and set your preferred DNS servers and exclusions.  
   (Skip this step if you're okay with the default Cloudflare DNS.)

2. Run `Install.exe` as Administrator.
   Running without admin rights may cause it to not work properly.

3. Disconnect and reconnect your internet to trigger the DNS update.

------------------------------------------------------------------------------------------------

🔧 How to Configure

1. Open `AutoSetDNS.config.json` and modify the following:
   - Your preferred DNS servers
   - Any excluded network names or keywords

2. Run `Uninstall.exe` to remove the current task.

3. Run `Install.exe` as Administrator to apply the updated settings.

------------------------------------------------------------------------------------------------

❌ How to Uninstall

1. Run `Uninstall.exe` to remove the AutoSetDNS task from Task Scheduler.

------------------------------------------------------------------------------------------------
