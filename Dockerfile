FROM node:9.6.1 as builder

WORKDIR /build
ENV PATH /build/node_modules/.bin:$PATH
COPY package.json /usr/src/app/package.json
RUN npm install --silent
COPY . /build/app
RUN npm run build

FROM nginx:1.13.9-alpine
COPY --from=builder /build /usr/share/nginx/html
EXPOSE 80