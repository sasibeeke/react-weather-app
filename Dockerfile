FROM node:18-alpine AS Build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

FROM node:18-alpine AS runtime

WORKDIR /app

COPY --from=build /app /app

EXPOSE 3000

CMD ["npm", "start"]