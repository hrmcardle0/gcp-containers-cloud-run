# Use a small base image for Go
FROM golang:1.23-alpine as builder

# Set the working directory
WORKDIR /app

# Copy the Go code. Despite the sidecar being copied in, build tags prevent it from being included in the final binary
COPY . .

# Install the dependencies
RUN go mod tidy

# Build the Go app
RUN go build -o . .

# Final image
FROM alpine:3.14

# Copy the built Go app
COPY --from=builder /app/gcp-cloudrun /app/main

# Expose port 8080 for the metrics endpoint
EXPOSE 8080

# Run the app
CMD ["/app/main"]
