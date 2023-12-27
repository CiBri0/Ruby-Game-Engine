cd gamefiles
start cmd.exe /c timeout 1, taskkill /F /FI "WINDOWTITLE eq D" /T, pause
ocran game.rb --no-enc --windows
pause


