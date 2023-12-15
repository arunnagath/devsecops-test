Lab setup for devsecops pipeline

write a workflow for below requirements.
build devsecops pipeline for in github actions 
1. this is python project 
2. use workflow dispatch
3. use this for docker image https://hub.docker.com/r/we45/vul_flask/
4. SAST we are using GHAS - it should be enabled in security
6. for DAST use owasp zap cli
7. 

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
   

Pipeline approach for sample python program
1. Dev pushes the code -> 1.1 secret scan -> 1.2 SAST (GHAS) -> 1.3 Build -> 1.4 docker push -> 1.5 github registry for / any cloud artifact
