# Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

# Run stage
FROM node:20-alpine
WORKDIR /app
COPY --from=build /app/build ./build
RUN yarn global add serve
RUN addgroup -S group && adduser -S user -G group
RUN chown -R user:group /app

USER user
EXPOSE 3000
CMD ["serve", "-s", "build"]