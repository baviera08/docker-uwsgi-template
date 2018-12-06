FROM python:3-alpine
RUN apk upgrade
RUN apk add --update tzdata
RUN apk add vim apk-tools curl python3-dev build-base gcc libc-dev linux-headers
ENV TZ=America/Asuncion
RUN mkdir <yourproject>
COPY . /<yourproject>
WORKDIR /<yourproject>
# if your project have requirements
#RUN pip install -r requirements.txt
EXPOSE 5005
# ensure www-data user exists
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1
# In my case my uwsgi.ini file is in <yourproject>/app/
CMD cd app ; \
     uwsgi --ini uwsgi.ini
