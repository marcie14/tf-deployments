# tf-deployments

Environment-specific deployments that wire together modules from `tf-modules`. This is where infrastructure actually gets created. Each environment folder is an independent Terraform root — it sources versioned modules and provides the environment-specific values (names, sizes, counts, etc.).

---

## What Lives Here

### `environments/dev/aws/`
Deploys the full AWS stack (VPC + ECS service) into the dev environment. This is where you iterate and test changes before promoting to prod.

### `environments/prod/aws/`
Same infrastructure as dev, but with production-grade sizing and tighter IAM permissions. Changes here only happen via GitHub Actions on merge to `main`.

### `environments/dev/gcp/`
Deploys a GKE cluster and Kubernetes workloads into GCP for the dev environment. Runs the same containerized app as ECS but on Kubernetes.

### `environments/prod/gcp/`
Production GKE deployment. Mirrors the AWS prod pattern.

---

## Branching Strategy

Branch name maps directly to environment:

| Branch | Environment | How Applied |
|--------|-------------|-------------|
| `feature/*` | none | `terraform plan` only (PR comment) |
| `dev` | dev | auto `apply` on merge |
| `main` | prod | auto `apply` on merge |

This means you never manually run `terraform apply` against prod — it only happens through a merge to `main` after a PR review.

---

## GitHub Actions

Two workflows live in `.github/workflows/`:

- **`plan.yml`** — triggers on every PR, runs `terraform plan` and posts the output as a PR comment so reviewers can see what will change
- **`apply.yml`** — triggers on merge to `dev` or `main`, runs `terraform apply` against the corresponding environment

Authentication to AWS uses **OIDC** (set up in `tf-platform/iam/`) — no AWS credentials stored in GitHub secrets.

---

## Remote State

All environments use the S3 backend created in `tf-platform/state-backend/`. Each environment has its own state file key:

```
s3://marciedev-tf-state/
├── dev/aws/terraform.tfstate
├── prod/aws/terraform.tfstate
├── dev/gcp/terraform.tfstate
└── prod/gcp/terraform.tfstate
```

---

## Structure

```
tf-deployments/
├── .github/
│   └── workflows/
│       ├── plan.yml
│       └── apply.yml
└── environments/
    ├── dev/
    │   ├── aws/
    │   │   ├── main.tf       # sources vpc + ecs-service modules
    │   │   ├── variables.tf
    │   │   ├── outputs.tf
    │   │   └── backend.tf    # points to S3 state bucket
    │   └── gcp/
    │       ├── main.tf       # sources gke-cluster module
    │       ├── variables.tf
    │       ├── outputs.tf
    │       └── backend.tf
    └── prod/
        ├── aws/
        └── gcp/
```
