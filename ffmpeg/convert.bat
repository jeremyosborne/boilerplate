REM
REM Convert flip camera videos to more friendly youtube format.
REM

@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
for %%F IN (*.mp4) DO (set "fd=%%~tF" & ffmpeg -i %%F -c:v libx264 -preset slow -crf 23 -c:a copy -threads 0 -pix_fmt yuv420p !fd:~6,4!!fd:~0,2!!fd:~3,2!_!fd:~11,2!!fd:~14,2!.mkv)
endlocal
