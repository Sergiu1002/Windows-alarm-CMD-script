@echo off
setlocal enabledelayedexpansion

set bell_sound="C:\Users\USER\Desktop\alarm.mp3"
set player_command="C:\Program Files (x86)\Windows Media Player\wmplayer.exe"

:loop
for /f "tokens=2 delims==" %%a in ('wmic path win32_localtime get DayOfWeek /format:list ^| findstr "="') do (
    set "day_of_week=%%a"
    if !day_of_week! gtr 0 if !day_of_week! lss 6 (
        for %%i in (13:47, 7:50, 8:00, 8:50, 9:00, 9:50, 10:00, 10:50, 11:00, 11:50, 12:00, 12:50, 13:00, 13:50, 14:00, 14:50, 15:00, 15:50, 16:00, 16:50, 17:00, 17:50, 18:00, 18:50, 19:00) do (
			set "bell_time=%%i"
            for /f "tokens=1-2 delims=: " %%a in ("!time!") do (
                set "current_time=%%a:%%b"
                if "!current_time!"=="!bell_time!" (
                    echo !current_time!
                    echo !bell_time!
                    start "" wmplayer.exe %bell_sound%
                    timeout /t 60 /nobreak >nul
                    taskkill /f /im wmplayer.exe
                )
            )
        )
    )
)
timeout /t 15 /nobreak >nul
goto loop
