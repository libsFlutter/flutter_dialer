#!/bin/bash

# Flutter Dialer Git Update Script

echo "Flutter Dialer - Git Update Script"
echo "=================================="

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "Current branch: $CURRENT_BRANCH"

# Add all changes
echo "Adding all changes..."
git add .

# Get commit message from user
echo "Enter commit message (or press Enter for default):"
read COMMIT_MSG

if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="Update flutter_dialer plugin"
fi

# Commit changes
echo "Committing changes with message: $COMMIT_MSG"
git commit -m "$COMMIT_MSG"

# Push to remote
echo "Pushing to remote..."
git push origin $CURRENT_BRANCH

echo "Git update completed successfully!" 