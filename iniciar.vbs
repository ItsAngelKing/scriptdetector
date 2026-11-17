' Lanzador invisible: ejecuta script.ps1 sin que PowerShell aparezca
' en la barra de tareas ni muestre ninguna ventana de consola.
' Colocalo junto a la carpeta bin y a script.conf; haz doble clic en este archivo.
Set shell = CreateObject("WScript.Shell")
ruta = Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\"))
shell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & ruta & "bin\script.ps1""" , 0, False
Set shell = Nothing
