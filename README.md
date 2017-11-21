## Bash Script for Set Up Django with Postgres, Nginx and Gunicorn on DigitalOcean  

### (Bonus: Automatic Deployment with Git)  

## Usage  

### 1. Initial Server Set Up  

$ `ssh root@your_server_ip`  

\# `adduser sammy`  
\# `usermod -aG sudo sammy`  

$ `ssh-copy-id sammy@your_server_ip`  
$ `ssh sammy@your_server_ip`  

### 2. Downloading and Starting Script  

```
 wget --no-check-certificate --content-disposition  https://raw.githubusercontent.com/turkerdotpy/django-setup-digitalocean/master/setup.sh && bash setup.sh
```  

> And follow instructions.  

### 3. Minor Edits  

> Do not forget to change the settings.py content. (Ex: ALLOWED_HOSTS, DATABASES)  
