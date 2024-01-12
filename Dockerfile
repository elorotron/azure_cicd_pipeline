FROM nginx:1.25-alpine

ARG cred_azure
ENV AZURE_APPCONFIG_CONNECTION_STRING=$cred_azure

COPY ./python-app/nginx-config.py /
COPY ./html /var/www/html
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html && \
    apk update && \
    apk add python3 && \
    apk add py3-pip && \
    pip install azure-appconfiguration-provider && \
    python3 /nginx-config.py > /etc/nginx/conf.d/default.conf

EXPOSE 80
EXPOSE 443