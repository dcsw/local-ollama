# Local Ollama

A lightweight, self‑hosted setup for running Ollama models locally.

## Features
- Simple Docker‑compose configuration
- Automatic model download on first run
- Health‑check endpoint
- Persistent storage for models and data

## Quick start
```bash
# Clone the repo
git clone https://github.com/yourorg/local-ollama.git
cd local-ollama

# Start services
docker compose up -d
```

The API will be available at `http://localhost:11434`. You can test it with:
```bash
curl http://localhost:11434/api/version
```

## Configuration
- **`docker-compose.yml`** – edit ports, volumes, and environment variables.
- **`ollama.env`** – set `OLLAMA_HOST`, `OLLAMA_MODELS_PATH`, etc.

## Updating models
```bash
# Pull a new model (e.g., llama2)
ollama pull llama2
```

## Development
To use different or additional pre‑loaded models, edit the environment variables that control model loading. The primary variables are defined in `ollama.env` and referenced in `docker-compose.yml`.

### 1. Choose models in `ollama.env`
```
# ollama.env
# Space‑separated list of model names to pull on container start
OLLAMA_PRELOAD_MODELS="llama2 llama2:13b mistral"
```
Add any model names supported by Ollama. The container will automatically pull them the first time it starts.

### 2. Ensure the Dockerfile copies the `.env`
If you customise the Dockerfile, make sure it includes:
```Dockerfile
COPY ollama.env /app/ollama.env
ENV $(cat /app/ollama.env | xargs)
```
This loads the variables into the container environment.

### 3. Re‑build and restart
```bash
docker compose build --no-cache   # rebuild with new env changes
docker compose up -d            # restart services
```

### 4. Linting and testing
```bash
make lint   # run linter
make test   # execute test suite (if present)
```

## License
MIT © 2024 Local Ollama contributors
