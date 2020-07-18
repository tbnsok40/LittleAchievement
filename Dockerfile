FROM ubuntu:18.04

# code copying
COPY . /app
WORKDIR /app/LittleAchievement/

# ubuntu 기본 세팅으으으으
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip

# 가상환경 만들고 킵시당
RUN apt-get install -y virtualenv
RUN virtualenv -p python3 venv
CMD source /app/LittleAchievement/venv/bin/activate

# pip package 깔자!!!
RUN pip install -r /app/LittleAchievement/requirements.txt  

# uwsgi install
RUN pip install uwsgi 

# 이줴 nginx
RUN apt-get install -y nginx



# expose port 
EXPOSE 80 
EXPOSE 8000
EXPOSE 8080 


CMD python manage.py collectstatic
CMD python manage.py makemigrations
CMD python manage.py migrate

CMD uwsgi --ini /app/LittleAchievement/uwsgi.ini 


# nginx 설정

RUN rm -rf /etc/nginx/nginx.conf 
RUN rm -rf /etc/nginx/sites-enabled/default
# 바꾸기 위해 일단 지우고

RUN cp /app/nginx/nginx.conf /etc/nginx/
RUN cp /app/nginx/default /etc/nginx/sites-enabled
# RUN cp -f /app/LittleAchievement/nginx/nginx.conf /etc/nginx/sites-available/
# RUN rm -f /etc/nginx/sites-enalbed/*
# RUN ln -sf /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/
# WORKDIR /app/
CMD python /app/LittleAchivement/manage.py makemigrations
# CMD ["python3", "manage.py", "makemigrations"]
# RUN cat /app/LittleAchivement/manage.py
RUN cat /etc/nginx/sites-enabled/default
RUN cat /app/LittleAchievement/task/migrations/0001_initial.py
# nginx 설정해주고
CMD sudo service nginx reload



