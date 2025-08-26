# CI/CD for Risk Stratification & Care Management (AWS, EC2, CodeDeploy)

This folder contains the AWS CI/CD definitions to build with **CodeBuild** and deploy to **EC2** using **CodeDeploy**.

## Prereqs

- EC2 Amazon Linux 2 instance with:
  - IAM role allowing SSM (optional) and S3 read to your artifact bucket
  - CodeDeploy agent installed and running
  - Security group open on TCP 80/8000 (or behind ALB)
- S3 bucket for CodePipeline/CodeBuild artifacts
- CodePipeline wired to:
  - Source: GitHub repo
  - Build: CodeBuild project using `ci_cd/buildspec.yml`
  - Deploy: CodeDeploy Application + Deployment Group (EC2)

## Secrets (recommended)

Store secrets in SSM Parameter Store and fetch them in `install_dependencies.sh`:
- `/risk-app/DATABASE_URL` → e.g., your Postgres URL
- SMTP creds (if needed) as separate parameters

## Repo layout expected

- `backend/` → FastAPI app, with `backend/main.py` exposing `app`
- `ml_model/` → includes `risk_model.pkl`
- `requirements.txt` at repo root

## Local test

Run locally:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn backend.main:app --reload
