FROM ollama/ollama:0.20.5

# YOU MUST ADD THESE TWO LINES HERE
ARG OLLAMA_SMALL_MODEL=gemma4:e4b-it-q8_0
ARG OLLAMA_MEDIUM_MODEL=gemma4:e4b-it-q8_0

# Pre-download the model during the build
RUN ollama serve & sleep 5 && ollama pull ${OLLAMA_SMALL_MODEL} && ollama pull ${OLLAMA_MEDIUM_MODEL} && pkill ollama

# Optionally, set a default model to keep loaded in memory
ENV OLLAMA_KEEP_ALIVE=24h

ENTRYPOINT ["ollama", "serve"]