#include <Array.au3>
#include <File.au3>

#pragma compile(Icon, 'filelink-mk-to-clipboard.ico')

$double_quotes = ''

$multifiles_seperator = IniRead ( @ScriptDir & "\config.ini", "config", "multifiles_seperator", "1" )
$seperator = ' '
If $multifiles_seperator == "2" Then
   $seperator = @LF
EndIf

$clipboard = ""
For $i = 1 To $CmdLine[0]
   Local $filePath = $CmdLine[$i]

   If FileExists ($filePath) == 1 Then
	  Local $sDrive = "", $sDir = "", $sFileName = "", $sExtension = ""
	  Local $aPathSplit = _PathSplit($filePath, $sDrive, $sDir, $sFileName, $sExtension)

	  If $clipboard <> "" Then
		 $clipboard = $clipboard & $seperator
	  EndIf
	  $clipboard = $clipboard & '[' & $sFileName & '](' & $CmdLine[$i] & ')'
   EndIf
Next

If $clipboard <> "" Then
   ClipPut ( $clipboard )
EndIf