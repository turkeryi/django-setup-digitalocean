           ___     _     _   _        ___  _                                      
          / __|___| |_  | | | |_ __  |   \(_)__ _ _ _  __ _ ___                   
          \__ / -_|  _| | |_| | '_ \ | |) | / _` | ' \/ _` / _ \                  
          |___\___|\__|  \___/| .__/ |____/ \__,_|_||_\__, \___/                  
             _ _   _      ___ |_|    _  |__/          |___/  _  _      _          
     __ __ _(_| |_| |_   | _ \___ __| |_ __ _ _ _ ___ ___   | \| |__ _(_)_ _ __ __
     \ V  V | |  _| ' \  |  _/ _ (_-|  _/ _` | '_/ -_(_-<_  | .` / _` | | ' \\ \ /
      \_/\_/|_|\__|_||_| |_| \___/__/\__\__, |_| \___/__( ) |_|\_\__, |_|_||_/_\_\
                             _    ___   |___/   _       |/       |___/            
                __ _ _ _  __| |  / __|_  _ _ _ (_)__ ___ _ _ _ _                  
               / _` | ' \/ _` | | (_ | || | ' \| / _/ _ | '_| ' \                 
               \__,_|_||_\__,_|  \___|\_,_|_||_|_\__\___|_| |_||_|


 wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh



 This script will let you setup your own VPN server in no more than a minute, even if you haven't used OpenVPN before. It has been designed to be as unobtrusive and universal as possible.


### Bash Script for Set Up Django with Postgres, Nginx and Gunicorn on DigitalOcean
### (Bonus: Automatic Deployment with Git)

> If you wanna use purse version, don't forget to set vars


## Usage

### 1. Initial Server Set Up

```
$ ssh root@your_server_ip
```

```
# adduser sammy
# usermod -aG sudo sammy
```

```
$ ssh-copy-id sammy@your_server_ip
$ ssh sammy@your_server_ip
```

### 2. Setting Up

```
# nano setup.sh
```

> Paste setup.sh content in this repository. Save and quit.

```
# chmod +x setup.sh
```

### 3. Start

```
# ./setup.sh
```

> And follow instructions.

### 4. Minor Edits

> Do not forget to change the settings.py content. (Ex: ALLOWED_HOSTS, DATABASES)
