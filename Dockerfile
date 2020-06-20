FROM node:12.7-alpine AS base

ARG NODE_OPTIONS="--max-old-space-size=768"
ENV NODE_OPTIONS=$NODE_OPTIONS

RUN apk add --no-cache \
        chromium \
        nss \
        freetype \
        freetype-dev \
        harfbuzz \
        ca-certificates \
        ttf-freefont

ENV CHROME_BIN /usr/bin/chromium-browser

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
EXPOSE 4200

CMD npm run serve

#build
FROM base as build

ARG BACK_BASE_URL
ARG PRODUCTION
ARG NODE_OPTIONS="--max-old-space-size=768"

ENV BACK_BASE_URL=$BACK_BASE_URL
ENV PRODUCTION=$PRODUCTION
ENV NODE_OPTIONS=$NODE_OPTIONS

RUN npm run build-prod

#production
FROM nginx:1.17.1-alpine as prod

COPY --from=build /app/dist/internal /usr/share/nginx/html

COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf