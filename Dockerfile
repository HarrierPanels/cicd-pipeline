FROM node:7.8.0 
# t2.micro 100% CPU loads
# FROM node:lts
WORKDIR /opt
COPY . /opt
RUN npm install
ENTRYPOINT npm run start
