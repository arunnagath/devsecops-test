Lab setup for devsecops pipeline

write a workflow for below requirements.
build devsecops pipeline for in github actions 
1. this is python project 
2. use workflow dispatch
3. use this for docker image https://hub.docker.com/r/we45/vul_flask/
4. SAST we are using GHAS - it should be enabled in security

Approach - 1

1. Dev pushes the code
2. push will trigger the workflow
3. SAST (SCA + SAST)
4. DAST via owasp CLI
5. building docker
6. pushes to any artifact (gcp + azure)

Approach - 2

1. Developer pushes the code
2. Building docker
3. SAST via GHAS for (codescanning, secrets and dependancy issue)
4. DAST via owasp cli
5. pushes the code to any cloud artifact

         - name: Authenticate to Google Cloud
        uses: google/cloud/deploy-gcloud-auth-action@v2
        with:
          credentials: ${{ secrets.GCP_SERVICE_ACCOUNT_KEY }}

      - name: Deploy to Cloud Run
        run: |
          gcloud run deploy ${SERVICE_NAME} \
            --image ghcr.io/<your_username>/<image_name>:<tag> \
            --platform=REGION \
            --region=${REGION}

      - name: Verify deployment
        run: |
          gcloud run services describe ${SERVICE_NAME}

      - name: Clean up (optional)
        if: always()
        run: |
          gcloud run services delete ${SERVICE_NAME}


   Main Approach 

Pipeline approach for sample python program
1. Dev pushes the code -> 1.1 secret scan -> 1.2 SAST (GHAS) -> 1.3 Build -> 1.4 docker push -> 1.5 github registry


name: Build and Push Docker Image

on:
  push:
    branches: [ main ]

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Install Python dependencies
        run: |
          python3 -m venv venv
          source venv/bin/activate
          pip install -r requirements.txt

      - name: Write Python Hello World program
        run: |
          echo "print('Hello, World!')" > hello_world.py

      - name: Build Docker image
        run: |
          docker build -t <your_username>/<image_name>:<tag> .

      - name: Login to GitHub Container Registry
        run: |
          echo "${{ secrets.GITHUB_TOKEN }}" | docker login ghcr.io

      - name: Push Docker image to GitHub Container Registry
        run: |
          docker push ghcr.io/<your_username>/<image_name>:<tag>

env:
  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}


objectivec for lab

1. Github repo python hello world program should be there
2. whenever code changes happen our on push workflow shopuld trigger
3. then start the SCA and SAST scan
4. build docker image for the hello world python program
5. then pushes to ghcr.io



Error - 15/12/2023

1. Not able to push the docker image to ghcr.io
2. Need to add sast workflow to the ci.yml file
