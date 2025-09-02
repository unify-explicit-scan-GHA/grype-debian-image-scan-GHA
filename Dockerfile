# Use a potentially vulnerable older Python version
FROM python:3.6-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the application files into the container
COPY . /app

# Upgrade pip (optional but helpful)
RUN pip install --upgrade pip

# Install required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Expose the Flask default port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
