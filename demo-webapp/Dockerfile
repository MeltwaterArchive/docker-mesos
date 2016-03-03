FROM alpine:latest

# Install Python package manager
RUN apk -U add python py-pip curl

# Install webapp requirements such as Flask
ADD ./webapp/requirements.txt /tmp/requirements.txt
RUN pip install -qr /tmp/requirements.txt

# Add secretary to image
RUN curl -fsSLo /usr/bin/secretary "https://github.com/meltwater/secretary/releases/download/0.7.0/secretary-Linux-x86_64" && \
    chmod +x /usr/bin/secretary
ADD service-private-key.pem /service/keys/service-private-key.pem

# Unprivileged user to run service
RUN addgroup app && adduser -D -h / -H -g app -G app app

# Add gosu to run service as unprivileged user
RUN apk -U add gpgme
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    curl -o /usr/local/bin/gosu -fsSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" && \
    curl -o /usr/local/bin/gosu.asc -fsSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64.asc" && \
    gpg --verify /usr/local/bin/gosu.asc && \
    rm /usr/local/bin/gosu.asc && \
    rm -r /root/.gnupg/ && \
    chmod +x /usr/local/bin/gosu

# Add tini to avoid PID 1 zombie reaping problem
RUN curl -o /usr/local/bin/tini -fsSL https://github.com/krallin/tini/releases/download/v0.8.4/tini-static && \
    chmod +x /usr/local/bin/tini

# Deploy the webapp
ADD ./webapp /opt/webapp/
ADD launch.sh /
WORKDIR /opt/webapp

EXPOSE 8080
ENTRYPOINT ["/launch.sh"]
