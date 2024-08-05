# Use a base image that is outdated and has known vulnerabilities
FROM python:2.7-slim

# Install Flask (no version specified, which could lead to using an insecure version)
RUN pip install Flask

# Copy the application files to the container
COPY app /app

# Set the working directory
WORKDIR /app

# Expose a port (common practice, but ensure it's the correct one for your app)
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]
