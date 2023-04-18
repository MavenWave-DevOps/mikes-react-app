# ========== BUILD ===========
FROM node:19-alpine3.16 as build

WORKDIR /app

COPY package.json .
COPY package-lock.json .
RUN npm install --production

COPY . .
RUN npm run build

# ========== RUN ==========
FROM nginx:1.17

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/build /usr/share/nginx/html
