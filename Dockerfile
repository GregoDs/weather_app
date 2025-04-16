# Step 1: Base image with flutter
FROM ghcr.io/cirruslabs/flutter:stable

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy all the flutter project files into the container
COPY . .

# Step 4: Create a non-root user and switch to it 
RUN useradd -m flutteruser
RUN chown -R flutteruser:flutteruser /sdks/flutter /app
USER flutteruser

#Step 5: Configure git safe directory for flutter so that it recognizes the userer
RUN git config --global --add safe.directory /sdks/flutter

# Step 5: Install dependencies
RUN flutter pub get

# Step 6: Optional - Build the app (e.g., for web)
# RUN flutter build apk