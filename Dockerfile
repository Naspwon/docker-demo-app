FROM node:18-alpine

# Use build arguments for sensitive data, or configure them in your deployment environment
ARG MONGO_DB_USERNAME
ARG MONGO_DB_PWD

ENV MONGO_DB_USERNAME=${MONGO_DB_USERNAME} \
    MONGO_DB_PWD=${MONGO_DB_PWD}

RUN mkdir -p /home/app

COPY ./app /home/app

WORKDIR /home/app

RUN npm install

CMD ["node", "server.js"]
