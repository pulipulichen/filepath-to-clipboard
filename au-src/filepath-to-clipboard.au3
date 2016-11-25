$add_double_quotes = IniRead ( @ScriptDir & "\config.ini", "config", "add_double_quotes", "1" )
$double_quotes = '"'
If $add_double_quotes <> "1" Then
   $double_quotes = ''
EndIf

$multifiles_seperator = IniRead ( @ScriptDir & "\config.ini", "config", "multifiles_seperator", "1" )
$seperator = ' '
If $multifiles_seperator == "2" Then
   $seperator = @LF
EndIf

$clipboard = ""
For $i = 1 To $CmdLine[0]
   Local $filePath = $CmdLine[$i]
   If FileExists ($filePath) == 1 Then
	  If $clipboard <> "" Then
		 $clipboard = $clipboard & $seperator
	  EndIf
	  $clipboard = $clipboard & $double_quotes & $CmdLine[$i] & $double_quotes
   EndIf
Next

If $clipboard <> "" Then
   ClipPut ( $clipboard )
EndIf