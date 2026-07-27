FROM node:24-alpine@sha256:fb71d01345f11b708a3553c66e7c74074f2d506400ea81973343d915cb64eef0 AS build
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

FROM node:24-alpine@sha256:fb71d01345f11b708a3553c66e7c74074f2d506400ea81973343d915cb64eef0
WORKDIR /app
COPY --from=build /app/build ./build
RUN yarn global add serve tar@7.5.19
RUN addgroup -S group && adduser -S user -G group
RUN chown -R user:group /app
USER user
EXPOSE 3000
CMD ["serve", "-s", "build"]
