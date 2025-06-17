@echo off
setlocal enabledelayedexpansion

set count_stable=0
set count_canary=0

for /L %%i in (1,1,50) do (
    for /f "tokens=*" %%r in ('curl -s -H "Host: app.kirandns.site" http://a484635b35fad4e8a99c28cc0118e3e7-604355872.ap-south-1.elb.amazonaws.com') do (
        echo %%r | findstr /i "CANARY" >nul
        if !errorlevel! equ 0 (
            set /a count_canary+=1
        ) else (
            set /a count_stable+=1
        )
    )
)

echo --------------------------------------
echo Canary Hits:  !count_canary!
echo Stable Hits:  !count_stable!
echo Total Hits:   50
echo --------------------------------------
pause