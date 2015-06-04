FROM centos:6

# Install Epel YUM repo
RUN rpm -i "https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"

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
