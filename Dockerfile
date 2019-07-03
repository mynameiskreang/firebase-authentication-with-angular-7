FROM nikolaik/python-nodejs:python2.7-nodejs8 as builder
WORKDIR '/app'
RUN npm install -g node-gyp
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist/my-app /usr/share/nginx/html

