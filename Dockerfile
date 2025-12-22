FROM nikolaik/python-nodejs:python3.14-nodejs24-slim

RUN apt-get update && apt-get install -y \
    make \
    gcc \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . .
RUN corepack enable pnpm
RUN pnpm -F api make:setup
RUN pnpm -F admin install --frozen-lockfile
RUN pnpm -F admin build
CMD ["sh", "-c", "pnpm -F api make:migrate && pnpm start"]
# CMD ["sh", "-c", "pnpm -F api make:migrate && pnpm dev"]
