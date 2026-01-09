@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Ищем Python в стандартных местах
REM BebroComp Game Engine Editor - Portable Launcher
set PYTHON=

REM Проверяем переменную окружения
if exist "%PYTHON%" goto found_python

REM Ищем в Program Files
for /d %%D in ("C:\Program Files\Python*") do (
    if exist "%%D\python.exe" (
        set PYTHON=%%D\python.exe
        goto found_python
    )
)

REM Ищем в Program Files (x86)
for /d %%D in ("C:\Program Files (x86)\Python*") do (
    if exist "%%D\python.exe" (
        set PYTHON=%%D\python.exe
        goto found_python
    )
)

REM Ищем в AppData
for /d %%D in ("%APPDATA%\..\Local\Programs\Python*") do (
    if exist "%%D\python.exe" (
        set PYTHON=%%D\python.exe
        goto found_python
    )
)

REM Пытаемся найти через where
for /f "tokens=*" %%A in ('where python 2^>nul') do (
    set PYTHON=%%A
    goto found_python
)

REM Если Python не найден
echo.
echo ОШИБКА: Python не найден на этом компьютере
echo.
echo Решение:
echo 1. Скачайте Python с https://www.python.org/downloads/
echo 2. При установке выберите: [X] Add Python to PATH
echo 3. После установки перезагрузитесь
echo 4. Откройте эту папку и запустите start_engine.bat снова
echo.
pause
exit /b 1

:found_python
echo Python найден: !PYTHON!
echo.

REM Находим папку Python
for %%F in ("!PYTHON!") do set PYTHON_DIR=%%~dpF
set PYTHON_DIR=!PYTHON_DIR:~0,-1!

echo Python папка: !PYTHON_DIR!

REM Проверяем PyQt5
echo Проверка PyQt5...
"!PYTHON!" -c "import PyQt5; print(PyQt5.__file__)" >temp_pyqt5_path.txt 2>&1

REM Читаем путь к PyQt5
for /f "delims=" %%A in (temp_pyqt5_path.txt) do (
    set PYQT5_PATH=%%A
)
del temp_pyqt5_path.txt

REM Пытаемся найти плагины PyQt5
set QT_PLUGIN_PATH=
if exist "!PYTHON_DIR!\Lib\site-packages\PyQt5\Qt5\plugins" (
    set QT_PLUGIN_PATH=!PYTHON_DIR!\Lib\site-packages\PyQt5\Qt5\plugins
)
if exist "!PYTHON_DIR!\Lib\site-packages\PyQt5\plugins" (
    set QT_PLUGIN_PATH=!PYTHON_DIR!\Lib\site-packages\PyQt5\plugins
)

if "!QT_PLUGIN_PATH!"=="" (
    echo PyQt5 не найден. Установка зависимостей...
    echo.
    "!PYTHON!" -m pip install --upgrade PyQt5
    if errorlevel 1 (
        echo Ошибка при установке зависимостей
        echo.
        pause
        exit /b 1
    )
)

REM Устанавливаем переменные окружения для PyQt5
set QT_QPA_PLATFORM_PLUGIN_PATH=!QT_PLUGIN_PATH!
set PYTHONPATH=!PYTHON_DIR!\Lib\site-packages

echo QT_PLUGIN_PATH: !QT_PLUGIN_PATH!
echo.
echo Запуск приложения...
echo.

REM Запускаем приложение с установленными переменными
"!PYTHON!" run_engine.py
if errorlevel 1 (
    echo.
    echo Ошибка при запуске приложения!
    echo QT_PLUGIN_PATH: !QT_PLUGIN_PATH!
    echo.
    pause
)

exit /b 0