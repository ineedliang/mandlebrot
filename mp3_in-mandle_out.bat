@echo off
setlocal enabledelayedexpansion

:: Check if ffmpeg and ffprobe are available
where ffmpeg >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo FFmpeg not found. Please ensure it is installed and in your PATH.
    pause
    exit /b
)
where ffprobe >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo FFprobe not found. Please ensure it is installed and in your PATH.
    pause
    exit /b
)

:: Check if an MP3 file was dropped
if not "%~1"=="" (
    :: Validate dropped file
    ffprobe -v error -show_streams -select_streams a "%~1" >nul 2>&1
    if !ERRORLEVEL! equ 0 (
        set "input=%~1"
        set "filename=%~nx1"
        echo Using dropped file: !filename!
    ) else (
        echo Dropped file "%~1" is not a valid MP3 audio file.
        pause
        exit /b
    )
) else (
    :: List all MP3 files in the current directory if no file was dropped
    set count=0
    for %%f in (*.mp3) do (
        ffprobe -v error -show_streams -select_streams a "%%f" >nul 2>&1
        if !ERRORLEVEL! equ 0 (
            set /a count+=1
            set "file!count!=%%f"
            echo !count!. %%f
        ) else (
            echo Skipping %%f - not a valid audio file
        )
    )

    if !count!==0 (
        echo No valid MP3 files found in the current directory.
        pause
        exit /b
    )

    :: Prompt user to select an MP3 by number
    :select
    set /p choice=Enter the number of the MP3 file you want to use: 
    if "!file%choice%!"=="" (
        echo Invalid selection. Please try again.
        goto select
    )
    set "input=!file%choice%!"
    set "filename=!file%choice%!"
)

:: Generate the output filename by replacing .mp3 with .mp4
set "output=%input:~0,-4%.mp4"

:: Generate video with AAC audio
echo Generating video with AAC audio for better player compatibility...
ffmpeg -f lavfi -i "mandelbrot=s=1280x720:rate=30" ^
       -i "%input%" ^
       -map 0:v -map 1:a ^
       -c:v libx264 -pix_fmt yuv420p -c:a aac -b:a 192k -ar 48000 -ac 2 -shortest ^
       -y -loglevel verbose "%output%" > ffmpeg_log.txt 2>&1

if %ERRORLEVEL% equ 0 (
    :: Check if output has audio
    ffprobe -v error -show_streams -select_streams a "%output%" >nul 2>&1
    if !ERRORLEVEL! equ 0 (
        echo Video generated: %output%
        echo Please test in VLC or other players.
        :: Extract audio to verify
        ffmpeg -i "%output%" -vn -c:a copy "test_audio.mp3" >nul 2>&1
        echo Extracted audio to test_audio.mp3 for verification.
    ) else (
        echo No audio stream detected in %output%. Check ffmpeg_log.txt.
        goto try_mkv
    )
) else (
    echo Error during video generation. Check ffmpeg_log.txt.
    goto try_mkv
)

:: Ask if user wants to try MKV with MP3 audio
set /p mkv_choice=Generate an MKV file with original MP3 audio for comparison? (y/n): 
if /i "!mkv_choice!"=="y" (
    set "mkv_output=%input:~0,-4%.mkv"
    echo Generating MKV with original MP3 audio...
    ffmpeg -f lavfi -i "mandelbrot=s=1280x720:rate=30" ^
           -i "%input%" ^
           -map 0:v -map 1:a ^
           -c:v libx264 -pix_fmt yuv420p -c:a copy -shortest ^
           -y -loglevel verbose "!mkv_output!" >> ffmpeg_log.txt 2>&1
    if %ERRORLEVEL% equ 0 (
        echo MKV generated: !mkv_output!
        echo Please test in VLC or other players.
    ) else (
        echo Error generating MKV. Check ffmpeg_log.txt.
    )
)

goto end

:try_mkv
:: Generate MKV as a fallback
set "mkv_output=%input:~0,-4%.mkv"
echo Generating MKV with original MP3 audio as fallback...
ffmpeg -f lavfi -i "mandelbrot=s=1280x720:rate=30" ^
       -i "%input%" ^
       -map 0:v -map 1:a ^
       -c:v libx264 -pix_fmt yuv420p -c:a copy -shortest ^
       -y -loglevel verbose "!mkv_output!" >> ffmpeg_log.txt 2>&1
if %ERRORLEVEL% equ 0 (
    echo MKV generated: !mkv_output!
    echo Please test in VLC or other players.
) else (
    echo Error generating MKV. Check ffmpeg_log.txt.
)

:end
pause