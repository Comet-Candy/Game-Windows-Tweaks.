@echo off
rem DONT USE: -dev -console -cef-disable-sandbox -no-cef-sandbox
rem -cef-force-32bit breaks launch

cd "C:\Program Files (x86)\Steam"
start steam.exe -nointro -nobigpicture -nocrashmonitor -disablehighdpi -vrdisable -cef-disable-breakpad -cef-disable-js-logging -noconsole -oldtraymenu -showallbetas -nofriendsui -no-dwrite -nofasthtml -noshaders -no-shared-textures -single_core -disable-winh264 -cef-disable-occlusion -cef-disable-renderer-restart +open steam://open/minigameslist   
