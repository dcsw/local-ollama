# Local Ollama

A lightweight, self‑hosted setup for running Ollama models locally.

## Features
- Simple Docker‑compose configuration
- Automatic model download at container build time, not runtime
- Open WebUI
- Persistent storage for models and data

## Quick start
```bash
# Clone the repo
git clone https://github.com/yourorg/local-ollama.git
cd local-ollama
```

## Create a .env file w/a new Open WebUI secret
```bash
sed 's/your_open_webui_secret_here/'\'$(openssl rand -hex 32)\''/' .example.env > moo
```

# Start services
```bash
docker compose up -d
```

Ollama's API will be available at `http://localhost:11434`. 

You can test it with:
```bash
curl http://localhost:11434/api/version
```

Open WebUI will be available at [http://localhost:4000](http://localhost:4000).

## Configuration
- **`compose.yml`** – edit ports, volumes, and environment variables.
- **`.env`** – set `OLLAMA_SMALL_MODEL`, `OLLAMA_MEDIUM_MODEL`, `OPENROUTER_API_KEY`, etc.

## Updating models

You can add new models to your setup by pulling them.

```bash
# Pull a new model (e.g., llama2)
ollama pull llama2
```

These will persist through restarts

## Removing models

You can remove models using a similar process.

```bash
# Remove a model permanently
ollama remove llama2
```

Note that the models defined in `OLLAMA_SMALL_MODEL` and `OLLAMA_MEDIUM_MODEL` will be reloaded when the container is rebuilt.

## Development
To use different or additional pre‑loaded models, edit the environment variables that control model loading. The primary variables are defined in `.env` and referenced in `compose.yml`.

### 1. Choose models in `.env`
```
# .env
OLLAMA_SMALL_MODEL=gemma4:e4b
OLLAMA_MEDIUM_MODEL=gemma4:e4b
```
Add any model names supported by Ollama. The container will automatically pull them on build.

### 2. Re‑build and restart
```bash
docker compose build --no-cache   # rebuild with new env changes
docker compose up -d            # restart services
```

## License
MIT © 2024 Local Ollama contributors
