#!/bin/bash

echo "🔧 Enter the name of the EKS cluster to delete:"
read -p "Cluster name: " CLUSTER_NAME

echo "🌍 Enter the AWS region where the cluster is located:"
read -p "Region (e.g. us-west-1): " REGION

echo "🚨 This will permanently delete the EKS cluster \"$CLUSTER_NAME\" in region \"$REGION\""
read -p "Type 'yes' to continue: " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
  echo "❌ Aborted."
  exit 1
fi

echo "🔄 Deleting all pods, services, and deployments in ALL namespaces..."
kubectl delete svc --all --all-namespaces
kubectl delete pods --all --all-namespaces
kubectl delete deployments --all --all-namespaces

echo "🔍 Draining all nodes (ignoring DaemonSets)..."
NODES=$(kubectl get nodes -o name | cut -d'/' -f2)
for NODE in $NODES; do
  echo "🚧 Draining node: $NODE"
  kubectl drain "$NODE" --ignore-daemonsets --delete-emptydir-data --force
done

echo "🧨 Deleting EKS cluster via eksctl..."
eksctl delete cluster --name "$CLUSTER_NAME" --region "$REGION" --force

echo "🧹 Cleaning up remaining CloudFormation stacks related to the cluster..."
STACKS=$(aws cloudformation list-stacks --region "$REGION" \
  --query "StackSummaries[?starts_with(StackName, 'eksctl-$CLUSTER_NAME') && StackStatus!='DELETE_COMPLETE'].StackName" \
  --output text)

for STACK in $STACKS; do
  echo "🗑️ Deleting stack: $STACK"
  aws cloudformation delete-stack --stack-name "$STACK" --region "$REGION"
done

echo "✅ EKS cluster \"$CLUSTER_NAME\" and related resources deleted successfully!"
