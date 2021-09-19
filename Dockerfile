When you build the application it's building in another cointainer/layer. You i'll need to build the application before and copy the build folder to /usr/src/app.

So, this is fine:

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