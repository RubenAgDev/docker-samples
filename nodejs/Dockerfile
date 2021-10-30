FROM node:16

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# npm ci helps provide faster, reliable, reproducible builds for production environments
RUN npm ci

# Bundle app source
COPY . .

EXPOSE $PORT

# The node images provide the node user, set the user to use when running this image
USER node

CMD [ "node", "index.js" ]
