FROM nikolaik/python-nodejs:python3.14-nodejs24-slim

RUN apt-get update && apt-get install -y \
    make \
    gcc \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . .
WORKDIR /app/api
RUN make setup
WORKDIR /app/admin
RUN corepack enable pnpm
RUN pnpm install --frozen-lockfile
CMD ["sh", "-c", "pnpm start"]
