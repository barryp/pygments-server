FROM python:3.12-alpine

WORKDIR /opt

COPY requirements.txt requirements.txt
COPY main.py main.py

RUN <<EOF
  pip install --upgrade pip
  pip install -r requirements.txt
EOF

EXPOSE 7878
STOPSIGNAL SIGINT

CMD ["python3", "main.py"]