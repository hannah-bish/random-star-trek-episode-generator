FROM node:14.2.0 as app

WORKDIR /app
COPY package*.json ./

RUN npm install -g gatsby-cli

RUN npm install

COPY . .

EXPOSE 8000

CMD ["gatsby", "develop", "-H", "0.0.0.0"]
