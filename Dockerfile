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