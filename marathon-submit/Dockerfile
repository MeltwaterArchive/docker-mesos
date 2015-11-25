FROM centos:7

# Use JSONLint to check *.json files
RUN curl -fsSL https://rpm.nodesource.com/setup | bash -
RUN yum -y install epel-release && \
    yum -y install inotify-tools nodejs && \
    yum clean all
RUN npm install -g jsonlint

# Add lighter to image
RUN curl -fsSLo /bin/lighter "https://github.com/meltwater/lighter/releases/download/0.3.1/lighter-Linux-x86_64" && \
    chmod +x /bin/lighter

# Default URL for Marathon
ENV MARATHON_URL http://localhost:8080

# Validate json syntax
COPY json /submit/json
COPY bin/validate.sh /validate.sh
RUN /validate.sh /submit/json/*.json

# Expect marathon-submit to be mounted at /submit
VOLUME ["/submit"]

# Default entrypoint submits all files into Marathon
COPY bin/launch.sh /launch.sh
ENTRYPOINT ["/launch.sh"]
