FROM python:3.9.0b4-alpine3.12

COPY weather.py /bin/weather.py
COPY move /bin/move
COPY startserver /bin/startserver
COPY weather.html /bin/weather.html
COPY root /var/spool/cron/crontabs/root

RUN apk add bash
RUN apk update
RUN chmod +x /bin/move
RUN chmod +x /bin/startserver
RUN apk add apache2
RUN pip3 install --upgrade pip
RUN pip install requests

EXPOSE 4000
ENTRYPOINT crond -l 2 -f
CMD [ "./", "/bin/startserver" ]