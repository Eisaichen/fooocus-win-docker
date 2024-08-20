@robocopy C:\Fooocus\_models C:\Fooocus\models /E /XC /XN /XO /R:3 /W:1 /NP >nul
@echo Fooocus is Running at 0.0.0.0:7865
@if /i %MODEL%==anime python.exe -s launch.py --preset anime --listen --disable-in-browser %ARGS%
@if /i %MODEL%==realistic python.exe -s launch.py --preset realistic --listen --disable-in-browser %ARGS%
@python.exe -s launch.py --listen --disable-in-browser %ARGS%
@exit