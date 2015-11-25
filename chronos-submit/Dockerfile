FROM alpine:latest

# Use JSONLint to check *.json files
RUN apk -U add curl nodejs
RUN npm install -g jsonlint

# Default URL for Chronos
ENV CHRONOS_URL http://localhost:4400

# Validate json syntax
COPY json /json
COPY bin/validate.sh /validate.sh
RUN /validate.sh /json/*.json

# Default entrypoint submits all files into Chronos
COPY bin/launch.sh /launch.sh
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/launch.sh /json/*.json"]
