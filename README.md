# AutoSetDNS by TheBrightMountain

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

🔗 https://github.com/TheBrightMountain/AutoSetDNS

---

## 📘 What is AutoSetDNS?

**AutoSetDNS** is a lightweight tool that automatically configures your DNS settings based on the values defined in `AutoSetDNS.config.json`.

- `Install.exe` registers a scheduled task named **AutoSetDNS** in Windows Task Scheduler.
- This task monitors network connections and updates the DNS settings automatically to your preferred DNS servers.
- `Uninstall.exe` removes the scheduled task from your system.

> By default, it uses **Cloudflare DNS** (`1.1.1.1`, `1.0.0.1`), but you can easily customize it.

---

## ⚠️ Caution: False Positive Detected

Some antivirus engines like VirusTotal may flag the `AutoSetDNS.exe`, `Install.exe`, or `Uninstall.exe` files as potentially dangerous.  
These alerts are **false positives**.

These `.exe` files are compiled from **clean, transparent PowerShell source code** that has been reviewed and verified to:

- ✅ Only perform local DNS configuration  
- ✅ Never access the internet or modify sensitive system areas  
- ✅ Use legitimate Windows Task Scheduler functionality  
- ✅ Include no obfuscation, encryption, or malicious logic

Detections are likely triggered because the executables:
- Interact with system settings (like DNS)
- Register scheduled tasks (a behavior sometimes flagged by antivirus engines)

You can run the `.ps1` scripts directly or **compile them yourself** if preferred.

---

## 🛠️ Compile PowerShell Scripts to EXE (Optional)

### 📦 Step 1: Install `ps2exe`

Open PowerShell as Administrator and run:

```powershell
Install-Module -Name ps2exe -Scope CurrentUser
```

### 📄 Step 2: Compile the Scripts

Navigate to the folder with your `.ps1` files and run:

```powershell
Invoke-PS2EXE .\AutoSetDNS.ps1 .\AutoSetDNS.exe
Invoke-PS2EXE .\Install.ps1 .\Install.exe
Invoke-PS2EXE .\Uninstall.ps1 .\Uninstall.exe
```

✅ You now have clean, self-built `.exe` files from trusted source code.

---

## ✅ Benefits of AutoSetDNS

1. **Automatic DNS Configuration**  
   No need to manually update DNS settings when switching networks.

2. **Faster & More Private DNS**  
   Uses Cloudflare DNS by default, which is:
   - Fast – low latency  
   - Private – fully offline and does not log your IP

3. **Bypass ISP Restrictions / DNS Censorship**  
   Helps bypass blocked or hijacked DNS entries from your ISP.

4. **No bloatware**  
   Clean, minimal, and transparent. No background services, no telemetry.

---

## 🔍 Comparison With Similar Tools

| Tool / App         | Auto DNS Switching | Open Source | Lightweight | Notes |
|--------------------|--------------------|-------------|-------------|-------|
| **AutoSetDNS**     | ✅ Yes              | ✅ Yes      | ✅ Very     | Minimal + customizable |
| **NetSetMan**      | ⚠️ Manual profiles  | ❌ No       | ⚠️ Mid      | Feature-rich, but heavy |
| **DNS Jumper**     | ❌ No               | ❌ No       | ✅ Yes      | No automation |
| **Simple DNSCrypt**| ⚠️ DNSCrypt only    | ✅ Yes      | ⚠️ Medium   | Focused on encrypted DNS |
| **YogaDNS**        | ✅ Yes              | ❌ No       | ⚠️ Mid      | GUI-based, more complex |
| **Acrylic DNS Proxy** | ❌ No            | ✅ Yes      | ⚠️ Complex  | DNS caching/filtering |

---

## 🛠️ How to Install

1. *(Optional)* Edit `AutoSetDNS.config.json` to set your preferred DNS servers and exclusions.
2. Run `Install.exe` as **Administrator**.
3. Disconnect and reconnect your internet to trigger DNS updates.

---

## 🔧 How to Configure

1. Edit `AutoSetDNS.config.json`:
   - Set your preferred DNS servers
   - Add any network names or keywords to exclude
2. Run `Uninstall.exe` to remove the current task.
3. Run `Install.exe` again to reapply with new settings.

---

## ❌ How to Uninstall

- Simply run `Uninstall.exe` to remove the AutoSetDNS task from Task Scheduler.

---

## 📂 Repository Structure

```
📁 AutoSetDNS/
├── AutoSetDNS.config.json     # Your DNS settings and exclusions
├── AutoSetDNS.ps1             # Core script that sets DNS
├── Install.ps1                # Script to register the scheduled task
├── Uninstall.ps1              # Script to remove the task
├── *.exe                      # Optional compiled versions of the above
└── README.md                  # This file
```
