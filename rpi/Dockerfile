ARG NODE_VERSION=10.3.0
FROM node:10.3.0-stretch

RUN apt-get update
#RUN apt-get install -y python-rpi.gpio

# add support for gpio library
#RUN pip3 install 

# Home directory for Node-RED application source code.
RUN mkdir -p /usr/src/node-red

# User data directory, contains flows, config and nodes.
RUN mkdir /data

WORKDIR /usr/src/node-red

# Add node-red user so we aren't running as root.
RUN useradd --home-dir /usr/src/node-red --no-create-home domu \
    && chown -R domu:domu /data \
    && chown -R domu:domu /usr/src/node-red

USER domu

# package.json contains Node-RED NPM module and node dependencies
COPY package.json /usr/src/node-red/
RUN npm install

# User configuration directory volume
EXPOSE 1880

# Environment variable holding file path for flows configuration
ENV FLOWS=flows.json
ENV NODE_PATH=/usr/src/node-red/node_modules:/data/node_modules

CMD ["npm", "start", "--", "--userDir", "/data"]
