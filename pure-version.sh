#!/bin/bash

# Just you must create django superuser on setup 
WHOAMI=`whoami`
# Fill this blanks
DB_NAME=``
DB_USERNAME=``
DB_PASSWORD=``
DJANGO_PROJECT_NAME=``

# If you make changes to the /etc/systemd/system/gunicorn.service file
# sudo systemctl daemon-reload
# sudo systemctl restart gunicorn

cd
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python-pip python-dev libpq-dev postgresql postgresql-contrib nginx


sudo echo -e "
CREATE DATABASE $DB_NAME;
CREATE USER $DB_USERNAME WITH PASSWORD '$DB_PASSWORD';
ALTER ROLE $DB_USERNAME SET client_encoding TO 'utf8';
ALTER ROLE $DB_USERNAME SET default_transaction_isolation TO 'read committed';
ALTER ROLE $DB_USERNAME SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USERNAME;
" > create.sql

sudo -u postgres psql -f create.sql
rm create.sql


mkdir /home/$WHOAMI/django
mkdir /home/$WHOAMI/django/repo
cd /home/$WHOAMI/django/repo
mkdir site.git
cd site.git
git init --bare

cd hooks
echo -e "
#!/bin/sh
git --work-tree=/home/sammy/parent/myproject --git-dir=/home/sammy/parent/repo/site.git checkout -f
" > post-receive
chmod +x post-receive


mkdir /home/$WHOAMI/django/$DJANGO_PROJECT_NAME
cd /home/$WHOAMI/django/$DJANGO_PROJECT_NAME


sudo pip install virtualenv
cd /home/$WHOAMI/django/$DJANGO_PROJECT_NAME
virtualenv env
source env/bin/activate

pip install django gunicorn psycopg2

django-admin.py startproject $DJANGO_PROJECT_NAME .

python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser
python manage.py collectstatic

deactivate


sudo echo "
[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=$WHOAMI
Group=www-data
WorkingDirectory=/home/$WHOAMI/django/$DJANGO_PROJECT_NAME
ExecStart=/home/$WHOAMI/django/$DJANGO_PROJECT_NAME/env/bin/gunicorn --access-logfile - --workers 3 --bind unix:/home/$WHOAMI/django/$DJANGO_PROJECT_NAME/$DJANGO_PROJECT_NAME.sock $DJANGO_PROJECT_NAME.wsgi:application

[Install]
WantedBy=multi-user.target
" | sudo tee --append /etc/systemd/system/gunicorn.service

sudo systemctl start gunicorn
sudo systemctl enable gunicorn


read -p "Enter Server Ip:" SERVER_IP

sudo echo "
server {
    listen 80;
    server_name $SERVER_IP;

    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/$WHOAMI/django/$DJANGO_PROJECT_NAME;
    }
    location /media/ {
        root /home/$WHOAMI/django/$DJANGO_PROJECT_NAME;
    }
    location / {
        include proxy_params;
        proxy_pass http://unix:/home/$WHOAMI/django/$DJANGO_PROJECT_NAME/$DJANGO_PROJECT_NAME.sock;
    }
}" | sudo tee --append /etc/nginx/sites-available/$DJANGO_PROJECT_NAME


sudo ln -s /etc/nginx/sites-available/$DJANGO_PROJECT_NAME /etc/nginx/sites-enabled

sudo nginx -t

sudo systemctl restart nginx

sudo ufw allow 'Nginx Full'

clear
echo "You Can Deploy Repository Here;"
echo "git remote add live ssh://$WHOAMI@$SERVER_IP/home/$WHOAMI/django/repo/site.git"