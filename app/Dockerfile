FROM node:8.5.0-alpine

RUN mkdir app
COPY index.js package.json app/

WORKDIR app

RUN npm install

EXPOSE 80

CMD ["node", "index.js"]