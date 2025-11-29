@echo off
echo Batch Tweaks by SopyTheFennec
echo Disable Dynamic Tick
echo Disable Synthetic Timers
@echo
bcdedit /set disabledynamictick yes
bcdedit /set useplatformtick yes
pause