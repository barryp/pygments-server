FROM python:3.9-alpine

WORKDIR /opt

COPY requirements.txt requirements.txt
COPY main.py main.py

RUN <<EOF
  python3 -m venv venv
  . venv/bin/activate
  pip install --upgrade pip
  pip install -r requirements.txt
EOF

ENV WORKERS 1
EXPOSE 7878

STOPSIGNAL SIGINT

CMD /opt/venv/bin/gunicorn main:flask_app -b 0.0.0.0:7878 -w $WORKERS --access-logfile -