# Use a minimal base image
FROM golang:alpine

# Set the working directory
WORKDIR /app

# Copy the Go application code to the working directory
COPY . .

# Build the Go application
RUN go build -tags=sidecar -o sidecar.

# Run the sidecurl binary
CMD ["./sidecar"]