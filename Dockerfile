FROM python:3.12-alpine

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./main.py /code/main.py

ENV WORKERS 1
EXPOSE 80

# STOPSIGNAL SIGINT

CMD fastapi run main.py --proxy-headers --port 80 --workers $WORKERS