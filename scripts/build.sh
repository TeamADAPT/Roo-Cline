#!/bin/bash

# Create scripts directory if it doesn't exist
mkdir -p scripts

# Temporarily disable husky
export HUSKY=0

# Stage all changes first
git add .

# Commit any pending changes
git commit -m "chore: prepare for version bump" || true

# Update version in package.json
npm version patch

# Install dependencies and build
npm install
npm run build

# Create bin directory if it doesn't exist
mkdir -p bin

# Move and rename VSIX with timestamp
VERSION=$(node -p "require('./package.json').version")
mv bin/nova-mini-${VERSION}.vsix bin/nova-mini-${VERSION}-$(date +%Y%m%d%H%M%S).vsix

# Stage and commit all changes
git add .
git commit -m "chore(release): bump version to ${VERSION}"
git push origin feature/rmq

# Re-enable husky
export HUSKY=1