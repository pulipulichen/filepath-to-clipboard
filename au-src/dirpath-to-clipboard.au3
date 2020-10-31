#include <File.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>

#pragma compile(Icon, 'dirpath-to-clipboard.ico')

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

$copy_duplicate_dirpath = IniRead ( @ScriptDir & "\config.ini", "config", "copy_duplicate_dirpath", "1" )

$clipboard = ""
Local $aArray[0] = []

For $i = 1 To $CmdLine[0]

   Local $filePath = $CmdLine[$i]
   ;MsgBox($MB_SYSTEMMODAL, "", $filePath)
   If FileExists ($filePath) == 1 Then

	  If $clipboard <> "" Then
		 $clipboard = $clipboard & $seperator
	  EndIf

	  Local $dirPath = StringRegExpReplace($filePath, "\\[^\\]+$", "")
	  ;MsgBox($MB_SYSTEMMODAL, _ArraySearch($aArray, $dirPath), $copy_duplicate_dirpath & _ArrayDisplay($aArray))
	  If _ArraySearch($aArray, $dirPath) == -1 Or $copy_duplicate_dirpath == "1" Then

		 _ArrayAdd($aArray, $dirPath)
		 $clipboard = $clipboard & $double_quotes & $dirPath & $double_quotes

	  EndIf

   EndIf
Next

If $clipboard <> "" Then
   ClipPut ( $clipboard )
EndIf