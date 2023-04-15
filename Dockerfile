FROM node:lts
WORKDIR /opt
COPY . /opt
RUN npm install
ENTRYPOINT npm run start
