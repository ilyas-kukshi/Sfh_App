# Use an official Flutter image from DockerHub
FROM flutter/flutter:stable

# Set the working directory inside the container
WORKDIR /app

# Copy all project files into the container
COPY . .

# Enable web support
RUN flutter config --enable-web

# Get dependencies
RUN flutter pub get

# Build the Flutter web app
RUN flutter build web

# Set the command to run after the container starts
CMD ["cp", "-r", "build/web/.", "/app"]
