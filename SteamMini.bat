@echo off
rem DONT USE: -dev -console -cef-disable-sandbox -no-cef-sandbox
rem -cef-force-32bit breaks launch

:: --- Delete old Steam desktop shortcuts ---
del /q "%USERPROFILE%\Desktop\Steam.lnk" 2>nul
del /q "%PUBLIC%\Desktop\Steam.lnk" 2>nul

:: --- Create new shortcut with real Steam logo ---
set "STEAM_PATH=C:\Program Files (x86)\Steam\steam.exe"
set "LNK_PATH=%USERPROFILE%\Desktop\Steam.lnk"

powershell -NoProfile -Command ^
  "$ws = New-Object -ComObject WScript.Shell; " ^
  "$s = $ws.CreateShortcut('%LNK_PATH%'); " ^
  "$s.TargetPath = '%STEAM_PATH%'; " ^
  "$s.WorkingDirectory = 'C:\Program Files (x86)\Steam'; " ^
  "$s.IconLocation = '%STEAM_PATH%'; " ^
  "$s.Description = 'Steam'; " ^
  "$s.Save()"

:: --- Launch Steam with your flags ---
cd "C:\Program Files (x86)\Steam"
start steam.exe -nointro -nobigpicture -nocrashmonitor -disablehighdpi -vrdisable -cef-disable-breakpad -cef-disable-js-logging -noconsole -oldtraymenu -showallbetas -nofriendsui -no-dwrite -nofasthtml -noshaders -no-shared-textures -single_core -disable-winh264 -cef-disable-occlusion -cef-disable-renderer-restart +open steam://open/minigameslist   
