@echo off
set "ShortcutPath=%USERPROFILE%\Desktop\Steam.lnk"
set "SteamExe=C:\Program Files (x86)\Steam\steam.exe"
set "Flags=-nofriendsui -no-dwrite -nointro -nobigpicture -nofasthtml -nocrashmonitor -noshaders -no-shared-textures -disablehighdpi -cef-single-process -cef-in-process-gpu -single_core -disable-winh264 -vrdisable -cef-disable-breakpad -cef-disable-d3d11 -cef-disable-gpu-compositing -cef-disable-gpu -cef-disable-js-logging -cef-disable-occlusion -cef-disable-renderer-restart -noconsole -oldtraymenu -showallbetas"
set "IconPath=C:\Program Files (x86)\Steam\steam.exe,0"

powershell -NoProfile -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut('%ShortcutPath%');$s.TargetPath='%SteamExe%';$s.Arguments='%Flags%';$s.WorkingDirectory='C:\Program Files (x86)\Steam';$s.IconLocation='%IconPath%';$s.Save()"

echo Done.
pause   
