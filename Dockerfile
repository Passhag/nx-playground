### STAGE 1: Build ###
FROM node:12.18-alpine AS build

WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json", "nx.json", "./"]

RUN npm install
COPY . .

RUN npm install -g @angular/cli
RUN npm install -g @nrwl/cli

RUN nx build --prod

### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/apps/nx-playground /usr/share/nginx/html