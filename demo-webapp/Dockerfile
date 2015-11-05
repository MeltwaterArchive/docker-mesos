FROM alpine:latest

# Install Python package manager
RUN apk -U add python py-pip

# Install webapp requirements such as Flask
ADD ./webapp/requirements.txt /tmp/requirements.txt
RUN pip install -qr /tmp/requirements.txt

# Deploy the webapp
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

EXPOSE 8080
CMD ["python", "app.py"]
