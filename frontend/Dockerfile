# 1 - Build
FROM node:20-alpine AS builder

WORKDIR /app

COPY . .

# 2 - Production
FROM nginx:alpine AS production

COPY --from=builder /app/index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
