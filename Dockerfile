FROM node:14.2.0

WORKDIR /myapp

COPY package.json .

RUN npm install -g gatsby-cli

RUN npm install

COPY gatsby-config.js .

EXPOSE 8000

CMD ["gatsby", "develop", "-H", "0.0.0.0"]
