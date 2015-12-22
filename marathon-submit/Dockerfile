FROM centos:7

# Use JSONLint to check *.json files
RUN curl -fsSL https://rpm.nodesource.com/setup | bash -
RUN yum -y install epel-release && \
    yum -y install inotify-tools nodejs && \
    yum clean all
RUN npm install -g jsonlint

# Add lighter to image
RUN curl -o /usr/bin/lighter -fsSL "https://github.com/meltwater/lighter/releases/download/0.7.0/lighter-Linux-x86_64" && \
    chmod +x /usr/bin/lighter

# Default URL for Marathon
ENV MARATHON_URL http://localhost:8080

# Validate json syntax
COPY json /submit/json
COPY site /submit/site
COPY bin/validate.sh /validate.sh
RUN /validate.sh

# Expect marathon-submit to be mounted at /submit
VOLUME ["/submit"]

# Default entrypoint submits all files into Marathon
COPY bin/launch.sh /launch.sh
ENTRYPOINT ["/launch.sh"]
