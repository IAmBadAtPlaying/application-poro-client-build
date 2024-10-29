FROM node:20.18-alpine3.19

# Update and install necessary packages
RUN apk update && apk add --no-cache \
    openjdk8 \
    maven \
    git \
    curl

# Set JAVA_HOME and PATH otherwise maven might error out
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH="$JAVA_HOME/bin:${PATH}"

RUN npm install -g npm@latest
WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh

# Add permissions to the entrypoint script
RUN ["chmod", "+x", "/app/entrypoint.sh"]

RUN ["mkdir", "/app/out"]
ENTRYPOINT ["/app/entrypoint.sh"]