FROM node:19.0.0
WORKDIR /opt
ADD . /opt
RUN npm install
ENTRYPOINT npm run start
