FROM node:20-alpine@sha256:fb4cd12c85ee03686f6af5362a0b0d56d50c58a04632e6c0fb8363f609372293 AS build
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

FROM node:20-alpine@sha256:fb4cd12c85ee03686f6af5362a0b0d56d50c58a04632e6c0fb8363f609372293
WORKDIR /app
COPY --from=build /app/build ./build
RUN yarn global add serve
RUN addgroup -S group && adduser -S user -G group
RUN chown -R user:group /app
USER user
EXPOSE 3000
CMD ["serve", "-s", "build"]