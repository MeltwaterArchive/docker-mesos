FROM centos:7

# Install Epel YUM repo
RUN yum -y install epel-release && yum clean all

# Install Python package manager
RUN yum -y install python-pip && yum clean all

# Install webapp requirements such as Flask
ADD ./webapp/requirements.txt /tmp/requirements.txt
RUN pip install -qr /tmp/requirements.txt

# Deploy the webapp
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

EXPOSE 8080
CMD ["python", "app.py"]
