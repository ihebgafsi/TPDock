import os, socket, redis
from flask import Flask

app = Flask(__name__)
r = redis.Redis(host=os.getenv("REDIS_HOST", "db-service"), port=6379, decode_responses=True)

@app.route("/")
def index():
    hits = r.incr("hits")
    return f"Bonjour ! Cette page a été vue {hits} fois. Je suis le conteneur {socket.gethostname()}\n"