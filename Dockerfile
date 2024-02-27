FROM node:alpine3.18 as build

#Bild App
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

#Server with Nginx
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build ./ .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]