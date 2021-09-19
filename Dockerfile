### STAGE 1: Build ###
FROM node:slim AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
### STAGE 2: Run ###
FROM nginx:1.13.9-alpine

COPY --from=build /usr/src/app/dist/caprover-angular-app /usr/share/nginx/html

EXPOSE 80