FROM node:16 AS stage
WORKDIR /app
COPY package*.json ./
RUN npm config set registry https://registry.npmmirror.com/ && \
    npm install
COPY . .
RUN npm run build:prod
FROM nginx:latest
COPY --from=stage /app /usr/share/nginx/html
COPY --from=stage /app/ci/nginx.conf /etc/nginx/conf.d/default.conf