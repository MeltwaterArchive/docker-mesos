FROM centos:7

# Use JSONLint to check *.json files
RUN curl -Ls https://rpm.nodesource.com/setup | bash -
RUN yum -y install nodejs && yum clean all
RUN npm install -g jsonlint

# Default URL for Chronos
ENV CHRONOS_URL http://localhost:4400

# Validate json syntax
COPY json /json
COPY bin/validate.sh /validate.sh
RUN /validate.sh /json/*.json

# Default entrypoint submits all files into Chronos
COPY bin/launch.sh /launch.sh
ENTRYPOINT ["/launch.sh"]
CMD ["/json/*.json"]
