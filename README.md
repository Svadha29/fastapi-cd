# Continuous Delivery of a Dockerized FastAPI Application using GitHub Actions

## Overview
This project demonstrates Continuous Delivery by automating the creation and deployment of a Dockerized FastAPI application using GitHub Actions.

## Project Structure
```
├── main.py                 # FastAPI server script
├── requirements.txt        # Dependencies for FastAPI
├── Dockerfile              # Docker configuration file
├── .github/
│   └── workflows/
│       └── DockerBuild.yml # GitHub Actions workflow for automation
└── README.md               # Project documentation
```

## Installation and Running Locally
### Prerequisites
- Python 3.8+
- FastAPI
- Uvicorn

### Steps
1. Clone the repository:
   ```sh
   git clone https://github.com/<your-username>/<repo>.git
   cd <repo>
   ```
2. Install dependencies:
   ```sh
   pip install -r requirements.txt
   ```
3. Run the FastAPI server:
   ```sh
   uvicorn main:app --host 0.0.0.0 --port 8000
   ```
4. Access the API at:
   - Swagger UI: [http://localhost:8000/docs](http://localhost:8000/docs)
   - JSON response: [http://localhost:8000](http://localhost:8000)

## Building and Running Docker Image
### Prerequisites
- Docker or Podman installed

### Steps
1. Build the Docker image:
   ```sh
   docker build -t <your-dockerhub-username>/fastapi-app .
   ```
2. Run the container:
   ```sh
   docker run -p 8000:8000 <your-dockerhub-username>/fastapi-app
   ```
3. Access the API at the same URLs as above.

## GitHub Actions Workflow Explanation
The `.github/workflows/DockerBuild.yml` file automates the following:
- Triggers on push events
- Logs in to Docker Hub using a secret token
- Builds and pushes the Docker image to Docker Hub

### GitHub Actions Workflow File
```yaml
name: Docker image build

on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Build & Push Image
        run: |
          echo ${{ secrets.DOCKERTOKEN }} | docker login -u "<your-dockerhub-username>" --password-stdin
          docker build -t <your-dockerhub-username>/fastapi-app:latest .
          docker push <your-dockerhub-username>/fastapi-app:latest
```

## Setting up Docker Token and Secrets
### Generating a Docker Token
1. Go to [Docker Hub](https://hub.docker.com/) and sign in.
2. Navigate to Account Settings → Security → Access Tokens.
3. Click "Generate Token" and copy the generated token.

### Adding DOCKERTOKEN as a GitHub Secret
1. Go to your GitHub repository.
2. Navigate to Settings → Secrets and Variables → Actions.
3. Click "New repository secret" and name it `DOCKERTOKEN`.
4. Paste the generated token and save.

## Docker Hub Image URL
Once the workflow runs successfully, your Docker image will be available at:
```
https://hub.docker.com/r/<your-dockerhub-username>/fastapi-app
```

