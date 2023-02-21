# Use Node.js LTS version as the base image
FROM node:lts AS builder

# Set working directory
WORKDIR /app

# Copy the rest of the application code to the working directory
COPY . .

# Install dependencies
RUN npm install && npm run build -- --prod


FROM docker.io/node:lts-alpine AS deploy

ENV HOST=0.0.0.0
ENV PORT=3000

WORKDIR /app

RUN addgroup --system sample-backend && \
          adduser --system -G sample-backend sample-backend

COPY --from=builder dist/sample-backend sample-backend
RUN chown -R sample-backend:sample-backend .

CMD [ "node", "sample-backend" ]
