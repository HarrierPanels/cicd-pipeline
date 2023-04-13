FROM node:16.16.0
WORKDIR /opt
ADD . /opt
RUN npm install
ENTRYPOINT npm run start
