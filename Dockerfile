# Use Node.js LTS version as the base image
FROM node:lts

ENV HOST=0.0.0.0
ENV PORT=3000

# Set working directory
WORKDIR /app

# RUN addgroup --system sample-backend && adduser --system -G sample-backend sample-backend

# Copy the rest of the application code to the working directory
COPY . .

# Install dependencies
RUN npm install && npm run build -- --prod

CMD [ "node", "dist/sample-backend" ]
