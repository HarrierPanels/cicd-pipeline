#FROM node:7.8.0
FROM node:lts 
WORKDIR /opt
COPY . /opt
RUN npm install
ENTRYPOINT npm run start
