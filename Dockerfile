FROM node:9.6.1 as builder

WORKDIR /usr/src/app

ENV PATH /usr/src/app/node_modules/.bin:$PATH

COPY package.json .
COPY public public
COPY src src

RUN npm install --silent
RUN npm run build

COPY build .

RUN rm -rf src
RUN rm -rf build

FROM nginx:1.13.9-alpine

COPY --from=builder /usr/src/app /usr/share/nginx/html

EXPOSE 80