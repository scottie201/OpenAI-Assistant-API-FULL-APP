# Use Python slim base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Copy application code
COPY . .

# Copy secrets.toml file
COPY /root/studio/.streamlit/secrets.toml .streamlit/secrets.toml

# Expose port 8501
EXPOSE 8501

# Define healthcheck
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

# Run Streamlit app
CMD ["streamlit", "run", "streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]
