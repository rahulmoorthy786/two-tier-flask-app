FROM python:3.9-alpine

WORKDIR /app

#  package manager to 'apk' and updated package names

RUN apk update && apk upgrade && apk add --no-cache \
    gcc \
    musl-dev \
    mariadb-dev \
    pkgconfig

COPY  requirements.txt .

# Combined pip installations to reduce image layers

RUN pip install --upgrade pip

RUN pip install --no-cache-dir mysqlclient -r requirements.txt 

COPY . .

EXPOSE 5000

RUN adduser -D appuser && chown -R appuser /app

USER appuser

# CMD array arguments must use double quotes
CMD ["python","app.py"]
