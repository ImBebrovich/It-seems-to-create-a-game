Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

strPath = objFSO.GetParentFolderName(WScript.ScriptFullName)
objShell.CurrentDirectory = strPath

' Запускаем с Python прямо, без cmd окна
Set objProcess = objShell.Exec("cmd /c start_engine.bat")
