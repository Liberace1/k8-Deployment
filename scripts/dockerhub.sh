#!/bin/bash
echo "Ensure you have docker authenticated with your CLI"
sleep 2s
echo "This is programmed to work with an alreayd authenticated CLI"

echo "🐳 Welcome to the Docker Image Re-Tag & Push Script"

# Prompt for source image
read -p "🔗 Enter the source image (e.g. bharathshetty4/supermario): " SOURCE_IMAGE

# Prompt for Docker Hub username
read -p "👤 Enter your Docker Hub username: " DOCKER_USERNAME

# Prompt for new image name (repo)
read -p "📦 Enter the new image name (e.g. supermario-game): " NEW_IMAGE_NAME

# Prompt for tag
read -p "🏷️  Enter the tag (default: latest): " TAG
TAG=${TAG:-latest}

# Optional description
read -p "📝 Enter a short description (optional): " DESCRIPTION

# Final image name
FINAL_IMAGE="${DOCKER_USERNAME}/${NEW_IMAGE_NAME}:${TAG}"

echo ""
echo "🚀 Pulling image: $SOURCE_IMAGE..."
docker pull "$SOURCE_IMAGE"

echo "🔁 Tagging image as: $FINAL_IMAGE"
docker tag "$SOURCE_IMAGE" "$FINAL_IMAGE"

echo "🔐 Logging into Docker Hub..."
docker login || { echo "❌ Login failed! Exiting."; exit 1; }

echo "📤 Pushing image to Docker Hub..."
docker push "$FINAL_IMAGE"

echo ""
echo "✅ Successfully pushed image!"
echo "🔗 Image: https://hub.docker.com/r/$DOCKER_USERNAME/$NEW_IMAGE_NAME"
echo "📝 Description (for your reference): $DESCRIPTION"

echo ""
echo "📌 Reminder: To officially add a description, go to your Docker Hub repo and edit it manually in the UI."
