# Ollama + n8n Local Setup

This repository contains a Docker Compose configuration for running Ollama (AI model server) and n8n (workflow automation) locally.

## Prerequisites

- Docker and Docker Compose installed on your system
- Ollama and Ollama models installed locally

## Quick Start

1. Clone this repository: 
```bash
git clone <repository-url>
cd <repository-name>
```

2. Run the Docker Compose file:
```bash
docker compose up -d
```
The `-d` flag runs containers in detached mode (background)

3. Access the services:
   - n8n: http://localhost:5678
   - Ollama API: http://localhost:11434

## Services

### n8n
- Web Interface Port: 5678
- Workflow automation platform
- Data persisted using external volume
- Uses host.docker.internal to access host machine

### Ollama
- API Port: 11434
- AI model server
- Will use locally installed models via volume mounting
- Automatically serves models when needed (based on n8n configuration)

## Container Communication
When configuring Ollama in n8n:
- Use `http://ollama:11434` as the connection URL (already configured in docker-compose.yml)
- Models are loaded on-demand when API calls are made

## Data Persistence

### n8n Data
- Uses external volume `n8n_data`
- Use existing data, ensure volume exists and is marked as external in docker-compose.yml
- This volume is mounted from host system: `${HOME}/.n8n:/home/node/.n8n` (for MacOS and Linux)
- Using existing data will ensure that the data is persisted even after unmouting the volume
```bash
docker volume create n8n_data
docker volume ls
```

### Ollama Models
- Models mounted from host system: `${HOME}/.ollama:/root/.ollama`
- Reuses existing local models instead of downloading new copies
- ollama documentation: https://ollama.ai/docs/

## Useful Commands

```bash
# Start services in background
docker compose up -d

# View logs
docker compose logs -f

# View service-specific logs
docker compose logs -f ollama

# List available models
docker compose exec ollama ollama list

# Pull new model
docker compose exec ollama ollama pull <model-name>

# Stop services
docker compose down

# List volumes
docker volume ls
```

## Troubleshooting

1. If models aren't visible:
   - Verify models exist in local ~/.ollama directory
   - Check volume mounting permissions
   - Verify Ollama service is running

2. If n8n can't connect to Ollama:
   - Ensure correct URL is used (http://ollama:11434) (within docker-compose.yml)
   - Check if Ollama service is running
   - Verify network connectivity between containers

## Contributing

Feel free to open issues or submit pull requests if you have suggestions for improvements.

## License

[Add your license information here]
