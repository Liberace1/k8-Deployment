
---

```
==================================================
🌐 DevOps EKS Project - Beginner Setup Guide
==================================================

Welcome to the DevOps EKS Project!

This project helps you learn how to deploy containerized applications
to Amazon EKS using Kubernetes, Docker, and a set of automation scripts.

Everything here is designed to make it easy for beginners to spin up clusters,
deploy applications, and manage the lifecycle of your Kubernetes resources.

--------------------------------------------------
📁 Project Structure
--------------------------------------------------

.
├── scripts/
│   ├── dockerhub.sh       => Push images to DockerHub
│   ├── delcluster.sh      => Delete all workloads and drain nodes
│   ├── alias.sh           => Kubernetes command aliases
├── App-deployment/        => YAML files for various applications
├── config.yml             => EKS cluster definition for eksctl
├── README.txt             => You're reading it :)

--------------------------------------------------
🧰 Prerequisites
--------------------------------------------------

Before getting started, make sure you have:

- AWS CLI installed and configured
- eksctl installed
- kubectl installed
- Docker installed and running
- An AWS IAM Role (e.g., eks-role-iam) with EKS admin access
- A DockerHub account

--------------------------------------------------
⚙️ Setup Steps
--------------------------------------------------

1. Clone the Repository

   git clone <this-repo-url>
   cd inside the repo folder

2. Create Your EKS Cluster

   eksctl create cluster -f config.yml

3. Verify Cluster is Working

   kubectl get nodes

4. Deploy Applications

   cd App-deployment
   kubectl apply -f <your-app>.yaml

   Or deploy everything in the folder:
   kubectl apply -f .

5. Push Docker Images to DockerHub

   chmod +x scripts/dockerhub.sh
   ./scripts/dockerhub.sh

   Make sure you're logged into Docker before trying to push image to docker:
   docker login

6. Use Helpful kubectl Aliases (Optional)

   source scripts/alias.sh

   Example Aliases:
   - kga => kubectl get all
   - kdel => kubectl delete
   - kd => kubectl describe

7. Delete Cluster & Resources (When Done)

   chmod +x scripts/delcluster.sh
   ./scripts/delcluster.sh

--------------------------------------------------
📦 Applications
--------------------------------------------------

This project includes fun and useful sample apps in the App-deployment folder.
You can explore and deploy any of them to your EKS cluster.

Examples include:
- Puzzle games
- Retro emulators
- Simple web apps

and many more....

--------------------------------------------------
📌 Notes
--------------------------------------------------

- All apps in App-deployment can be customized and extended.
- Scripts are meant to simplify your day-to-day Kubernetes and Docker workflow.
- AWS permissions must be properly configured before running eksctl.

--------------------------------------------------
🧠 Helpful Commands
--------------------------------------------------

kubectl get pods
kubectl logs <pod-name>
kubectl get svc

--------------------------------------------------
📬 Feedback & Contributions
--------------------------------------------------

Contributions are welcome!

You can fork the repo, make changes, and submit a pull request.
If you have ideas for new scripts or apps to add, go for it!

Happy Deploying 🚀
```

---
