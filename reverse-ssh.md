`sudo apt install autossh -y`

`sudo crontab -e`

    @reboot sleep60 && sudo nmcli device wifi hotspot ifname wlan0 con-name <WIFINAME> ssid Yonetim password <WIFIPASSWORD>

`sudo vim /etc/systemd/system/autossh-fd.service`

    [Unit]
    Description=AutoSSH reverse tunnel
    After=network.target
    
    [Service]
    Environment="AUTOSSH_GATETIME=0"
    ExecStart=/usr/bin/autossh -NR *:<REMOTEMACHINE_PORT>:localhost:22 <USER>@<REVERSSHIP>  >/dev/null 2>&1
    User=<USERNAME>
    
    [Install]
    WantedBy=multi-user.target

`ssh-keygen`

`ssh-copy-id <USER>@<REVERSSHIP>`

`sudo systemctl daemon-reload && sudo systemctl enable autossh-fd && sudo systemctl start autossh-fd `

