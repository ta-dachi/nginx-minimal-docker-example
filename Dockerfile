# FROM node:alpine
# ENV NODE_ENV=production
# RUN apk add nodejs npm
# ADD . /src
# RUN cd /src; npm install
# EXPOSE 8080
# CMD ["node", "/src/index.js"]
FROM alpine:latest

# Try printenv in an attached shell to a container and see if foo=bar
ENV foo=bar

RUN apk update && apk add \
  curl \
  nano \
  nginx

# Copy files from your own system to the image/ for nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/index.html

# Allow ports to be accessed outside.
EXPOSE 9090 
# Volumes are used to persist data in containers
VOLUME ["/usr/share/nginx/html"]

# root user will run 'nginx: master process'
# nobody user will run 'nginx: worker process' as dictated in the nginx.non-root.conf
CMD ["nginx", "-g", "daemon off;"]