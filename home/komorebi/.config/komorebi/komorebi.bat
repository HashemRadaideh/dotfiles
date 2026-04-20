@echo off
REM place this file in $HOME/AppData/Roaming/Microsoft/Start `Menu\Programs\Startup
start /B komorebic start -c %USERPROFILE%\.config\komorebi.json --whkd
