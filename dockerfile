# Alpine: ~50 MB base vs ~1 GB for the full python image, smaller attack surface
FROM python:3.12-alpine
ENV PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1
# Non-root user: limits damage if the app is compromised
RUN addgroup -S app && adduser -S app -G app
WORKDIR /app
# Dependencies copied first: this layer stays cached unless requirements.txt changes
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
USER app
# Port 5000 because a non-root user cannot bind port 80 inside the container
EXPOSE 5000
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]