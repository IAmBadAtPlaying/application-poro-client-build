FROM node:alpine

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
RUN dos2unix /app/entrypoint.sh && chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]