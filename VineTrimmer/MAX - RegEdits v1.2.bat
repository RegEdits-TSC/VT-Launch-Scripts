@echo off
TITLE MAX - RegEdits v1.2
:: 
:: =================================================================
:: Script Name: Max Download Script
:: Description: This script helps users input and validate various
::              parameters for downloading content from MAX. 
::              It allows users to specify the URL, quality, range,
::              codec, subtitles preference, and whether to remux 
::              after decryption.
:: Author: RegEdits
:: Updated: 08/01/2024
:: Version: 1.2
:: =================================================================
:: 

ECHO                                                                                         Copyright (c) 2024 RegEdits
ECHO.
ECHO                                         ====================================
ECHO.
ECHO                                          Max Upload Script For VineTrimmer
ECHO.
ECHO                                         ====================================
ECHO.
ECHO.
ECHO.
ECHO  ====================================================================================================================
ECHO.
ECHO [Info] This script is designed to facilitate the use of VineTrimmer for downloading videos from Max. I have 
ECHO        customized it to enhance user-friendliness according to my standards, making it more accessible and 
ECHO        intuitive for both myself and others. This script does not download content from Max directly but rather
ECHO        streamlines the process through VineTrimmer.         
ECHO.
ECHO.

:: URL Input and Validation
:URL
SET /p url=Paste MAX URL (or type "exit" to quit): 
IF /I "%url%"=="exit" EXIT

:: Check if URL starts with the required string
echo %url% | findstr /b /c:"https://play.max.com/movie/" >nul
IF ERRORLEVEL 1 (
    ECHO Invalid link. The URL should start with "https://play.max.com/movie/".
    GOTO URL
)

:Quality

:: Checks if value has been set once already to avoid asking questions that are already answered
IF "%URL_SET%"=="1" GOTO LAST_SECTION

:: Set URL flag
IF "%URL_SET%"=="0" SET URL_SET=1

SET /p quality=Quality (1080 or 2160, or type "exit" to quit): 
IF /I "%quality%"=="exit" EXIT
IF "%quality%"=="1080" GOTO Release
IF "%quality%"=="2160" GOTO Release
ECHO Invalid quality. Please enter 1080 or 2160.
GOTO Quality

:Release

:: Checks if value has been set once already to avoid asking questions that are already answered
IF "%QUALITY_SET%"=="1" GOTO LAST_SECTION

:: Set quality flag
IF "%QUALITY_SET%"=="0" SET QUALITY_SET=1

SET /p release=Range (SDR, HDR or DV, or type "exit" to quit): 
IF /I "%release%"=="exit" EXIT
IF /I "%release%"=="SDR" GOTO Codec
IF /I "%release%"=="HDR" GOTO Codec
IF /I "%release%"=="DV" GOTO Codec
ECHO Invalid range. Please enter SDR, HDR, or DV.
GOTO Release

:Codec

:: Checks if value has been set once already to avoid asking questions that are already answered
IF "%RELEASE_SET%"=="1" GOTO LAST_SECTION

:: Set release flag
IF "%RELEASE_SET%"=="0" SET RELEASE_SET=1

SET /p codec=Codec (H264 or H265, or type "exit" to quit): 
IF /I "%codec%"=="exit" EXIT
IF /I "%codec%"=="H264" GOTO Subtitles
IF /I "%codec%"=="H265" GOTO Subtitles
ECHO Invalid codec. Please enter H264 or H265.
GOTO Codec

:Subtitles

:: Checks if value has been set once already to avoid asking questions that are already answered
IF "%CODEC_SET%"=="1" GOTO LAST_SECTION

:: Set codec flag
IF "%CODEC_SET%"=="0" SET CODEC_SET=1

SET /p subs=Do you want subtitles only? (yes or no, or type "exit" to quit): 
IF /I "%subs%"=="exit" EXIT
IF /I "%subs%"=="yes" GOTO DisplayValuesAndRunSubtitles
IF /I "%subs%"=="no" GOTO Remux
ECHO Invalid choice. Please enter yes or no.
GOTO Subtitles

:Remux

:: Checks if value has been set once already to avoid asking questions that are already answered
IF "%SUBTITLES_SET%"=="1" GOTO LAST_SECTION

:: Set subtitles flag
IF "%SUBTITLES_SET%"=="0" SET SUBTITLES_SET=1

SET /p remux=Do you want to remux after decryption? (yes or no, or type "exit" to quit): 
IF /I "%remux%"=="exit" EXIT
IF /I "%remux%"=="yes" GOTO DisplayValuesAndRunRemux
IF /I "%remux%"=="no" GOTO DisplayValuesAndRunNoRemux
ECHO Invalid choice. Please enter yes or no.
GOTO Remux

:DisplayValuesAndRunRemux

cls
ECHO                                                                                         Copyright (c) 2024 RegEdits
ECHO.
ECHO                                         ====================================
ECHO.
ECHO                                          Max Upload Script For VineTrimmer
ECHO.
ECHO                                         ====================================
ECHO.
ECHO.
ECHO.
ECHO  ====================================================================================================================      
ECHO.
ECHO.

:: Set last section so it can properly loop back if values are corrected
SET LAST_SECTION=DisplayValuesAndRunRemux

:: Set remux flag
IF "%REMUX_SET%"=="0" SET REMUX_SET=1

ECHO.
ECHO You have entered the following values:
ECHO URL: %url%
ECHO Quality: %quality%
ECHO Range: %release%
ECHO Codec: %codec%
ECHO Subtitles Only: %subs%
ECHO Remux After Decryption: %remux%
ECHO.
SET /p confirm=Is this correct? (yes to continue, no to change values, exit to quit): 
IF /I "%confirm%"=="exit" EXIT
IF /I "%confirm%"=="no" GOTO Choose
IF /I "%confirm%"=="yes" GOTO RunRemux
ECHO Invalid choice. Please enter yes or no.
GOTO DisplayValuesAndRunRemux

:RunRemux
poetry run vt dl -al en-US -q %quality% -v %codec% -r %release% Max %url%
GOTO End

:DisplayValuesAndRunNoRemux

cls
ECHO                                                                                         Copyright (c) 2024 RegEdits
ECHO.
ECHO                                         ====================================
ECHO.
ECHO                                          Max Upload Script For VineTrimmer
ECHO.
ECHO                                         ====================================
ECHO.
ECHO.
ECHO.
ECHO  ====================================================================================================================       
ECHO.
ECHO.

:: Set last section so it can properly loop back if values are corrected
SET LAST_SECTION=DisplayValuesAndRunNoRemux

:: Set remux flag
IF "%REMUX_SET%"=="0" SET REMUX_SET=1

ECHO.
ECHO You have entered the following values:
ECHO URL: %url%
ECHO Quality: %quality%
ECHO Range: %release%
ECHO Codec: %codec%
ECHO Subtitles Only: %subs%
ECHO Remux After Decryption: %remux%
ECHO.
SET /p confirm=Is this correct? (yes to continue, no to change values, exit to quit): 
IF /I "%confirm%"=="exit" EXIT
IF /I "%confirm%"=="no" GOTO Choose
IF /I "%confirm%"=="yes" GOTO RunNoRemux
ECHO Invalid choice. Please enter yes or no.
GOTO DisplayValuesAndRunNoRemux

:RunNoRemux
poetry run vt dl -nm -al en-US -q %quality% -v %codec% -r %release% Max %url%
GOTO End

:DisplayValuesAndRunSubtitles

cls
ECHO                                                                                         Copyright (c) 2024 RegEdits
ECHO.
ECHO                                         ====================================
ECHO.
ECHO                                          Max Upload Script For VineTrimmer
ECHO.
ECHO                                         ====================================
ECHO.
ECHO.
ECHO.
ECHO  ====================================================================================================================       
ECHO.
ECHO.

:: Set last section so it can properly loop back if values are corrected
SET LAST_SECTION=DisplayValuesAndRunSubtitles

:: Set remux flag back to 0 since subtitles only was picked
IF "%REMUX_SET%"=="1" SET REMUX_SET=0

ECHO.
ECHO You have entered the following values:
ECHO URL: %url%
ECHO Quality: %quality%
ECHO Range: %release%
ECHO Codec: %codec%
ECHO Subtitles Only: %subs%
ECHO.
SET /p confirm=Is this correct? (yes to continue, no to change values, exit to quit): 
IF /I "%confirm%"=="exit" EXIT
IF /I "%confirm%"=="no" GOTO Choose
IF /I "%confirm%"=="yes" GOTO RunSubtitles
ECHO Invalid choice. Please enter yes or no.
GOTO DisplayValuesAndRunSubtitles

:RunSubtitles
poetry run vt dl -S -al en-US -q %quality% -v %codec% -r %release% Max %url%
GOTO End

:Choose

:: Determine if remux option should be displayed as a variable to edit
IF "%LAST_SECTION%"=="DisplayValuesAndRunSubtitles" (
    GOTO Choose1
) else GOTO Choose2
 
:Choose1
ECHO.
ECHO Choose which value to change:
ECHO 1. URL
ECHO 2. Quality
ECHO 3. Range
ECHO 4. Codec
ECHO 5. Subtitles
ECHO 6. Exit
SET /p choice=Enter your choice: 

IF "%choice%"=="1" GOTO URL
IF "%choice%"=="2" GOTO Quality
IF "%choice%"=="3" GOTO Release
IF "%choice%"=="4" GOTO Codec
IF "%choice%"=="5" GOTO Subtitles
IF "%choice%"=="6" EXIT
ECHO Invalid choice. Please enter a number between 1 and 6.
GOTO Choose1

:Choose2
ECHO.
ECHO Choose which value to change:
ECHO 1. URL
ECHO 2. Quality
ECHO 3. Range
ECHO 4. Codec
ECHO 5. Subtitles
ECHO 6. Remux After Decryption
ECHO 7. Exit
SET /p choice=Enter your choice: 

IF "%choice%"=="1" GOTO URL
IF "%choice%"=="2" GOTO Quality
IF "%choice%"=="3" GOTO Release
IF "%choice%"=="4" GOTO Codec
IF "%choice%"=="5" GOTO Subtitles
IF "%choice%"=="6" GOTO Remux
IF "%choice%"=="7" EXIT
ECHO Invalid choice. Please enter a number between 1 and 7.
GOTO Choose2

:End
pause