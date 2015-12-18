FROM alpine:latest

# Install Python package manager
RUN apk -U add python py-pip curl

# Install webapp requirements such as Flask
ADD ./webapp/requirements.txt /tmp/requirements.txt
RUN pip install -qr /tmp/requirements.txt

# Add secretary to image
RUN curl -fsSLo /usr/bin/secretary "https://github.com/meltwater/secretary/releases/download/0.3.0/secretary-Linux-x86_64" && \
    chmod +x /usr/bin/secretary
ADD service-private-key.pem /service/keys/service-private-key.pem

# Unprivileged user to run service
RUN addgroup app && adduser -D -h / -H -g app -G app app

# Deploy the webapp
ADD ./webapp /opt/webapp/
ADD launch.sh /
WORKDIR /opt/webapp

EXPOSE 8080
ENTRYPOINT ["/launch.sh"]
