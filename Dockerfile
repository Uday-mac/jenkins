FROM python:3.12-slim

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir requirements.txt 

EXPOSE 5000

CMD [ "app.py" ]

ENTRYPOINT [ "python" ]
