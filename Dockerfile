FROM --platform=linux/amd64 node:16 AS stage
WORKDIR /app
COPY package*.json .
RUN npm config set registry https://registry.npmmirror.com/ && \
    npm install
COPY . .
RUN npm run build:prod
FROM --platform=linux/amd64 nginx:latest
COPY --from=stage /app/dist/ /usr/share/nginx/html/ruoyi/
COPY --from=stage /app/ci/nginx.conf /etc/nginx/conf.d/default.conf