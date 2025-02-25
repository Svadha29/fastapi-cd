# Use Ubuntu as the base image
FROM ubuntu:latest

# Install Python and necessary dependencies
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Set the working directory
WORKDIR /app

# Copy application files
COPY . /app

# Create a virtual environment and install dependencies
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install -r requirements.txt

# Expose the necessary port
EXPOSE 8000

# Command to run FastAPI application inside the virtual environment
CMD ["/app/venv/bin/uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
