FROM centos:7

# Use JSONLint to check *.json files
RUN curl -Ls https://rpm.nodesource.com/setup | bash -
RUN yum -y install nodejs && yum clean all
RUN npm install -g jsonlint

# Default URL for Marathon
ENV MARATHON_URL http://localhost:8080

# Validate json syntax
COPY json /json
COPY bin/validate.sh /validate.sh
RUN /validate.sh /json/*.json

# Default entrypoint submits all files into Marathon
COPY bin/launch.sh /launch.sh
ENTRYPOINT ["/launch.sh"]
CMD ["/json/*.json"]
