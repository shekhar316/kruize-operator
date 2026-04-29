#!/bin/bash

# Build and push Kruize operator for Catalogathon
# Builds for amd64 architecture and pushes to catalogathon registry

set -e

# Configuration
REGISTRY="dev-registry-quay-catalogathon-registry.apps.hthon-dev.svl.ibm.com"
NAMESPACE="sccat-7aa7afd3-ca2a-43e2-81a8-8f5e22900927"
IMAGE_NAME="kruize-operator"
TAG="catalogathon"
FULL_IMAGE="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${TAG}"

echo "========================================="
echo "Building Kruize Operator for Catalogathon"
echo "========================================="
echo "Image: ${FULL_IMAGE}"
echo "Architecture: amd64"
echo ""

# Build the operator binary
echo "Step 1: Building operator binary..."
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o manager cmd/main.go

# Build Docker image for amd64
echo ""
echo "Step 2: Building Docker image..."
docker build --platform linux/amd64 -t ${FULL_IMAGE} .

# Push to registry
echo ""
echo "Step 3: Pushing to registry..."
docker push ${FULL_IMAGE}

echo ""
echo "========================================="
echo "✅ Build and push complete!"
echo "========================================="
echo "Image: ${FULL_IMAGE}"
echo ""
echo "Next steps:"
echo "1. Verify image in registry"
echo "2. Update operator-deployment.yaml if needed"
echo "3. Test deployment"

# Made with Bob
