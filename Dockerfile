# Use a base image with Dart and Flutter pre-installed
FROM ghcr.io/cirruslabs/flutter:3.10.6 AS build

# Set the working directory
WORKDIR /app

# Copy the pubspec files to the container
COPY pubspec.yaml .
COPY pubspec.lock .

# Install dependencies
RUN flutter pub get

# Copy the rest of the application code
COPY . .

# Build the Flutter web app
RUN flutter build web

# Use a lightweight web server to serve the app
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]