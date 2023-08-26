FROM alpine:3.18 AS build

# primarily needed if using any git related options in hugo
RUN apk add --no-cache git

# see https://github.com/gohugoio/hugo/releases/latest
ARG HUGO_VERSION="0.117.0"

# Change file prefix to "hugo_extended_" if you want extended version
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz /hugo.tar.gz
RUN ["tar", "-xvzf", "hugo.tar.gz"]
RUN ["mv", "/hugo", "/usr/local/bin/"]
# Must be exec as shell to see output
RUN hugo version

COPY . /site
WORKDIR /site
RUN ["hugo", "--gc", "--minify"]


FROM nginx:1.23-alpine

COPY ./docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /site/public /usr/share/nginx/html

