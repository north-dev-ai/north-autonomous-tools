#!/bin/bash
# Auto-Deploy - Validate and push to GitHub automatically
# Runs error checker first, then handles git workflow

set -e

WEBSITE_DIR="${1:-$HOME/work/north-ai-website}"
MESSAGE="${2:-Auto-deploy: $(date +%Y-%m-%d)}"

echo "🚀 Auto-Deploy Tool"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Step 1: Run error checker
echo "Step 1: Running error checker..."
if ! bash ~/tools/error-checker.sh "$WEBSITE_DIR"; then
    echo "❌ Error checker failed. Aborting deployment."
    exit 1
fi
echo ""

# Step 2: Check git status
echo "Step 2: Checking git status..."
cd "$WEBSITE_DIR"
if [ -z "$(git status --porcelain)" ]; then
    echo "ℹ️  No changes to deploy"
    exit 0
fi
echo "✅ Changes detected"
echo ""

# Step 3: Stage changes
echo "Step 3: Staging changes..."
git add -A
git status --short
echo ""

# Step 4: Commit
echo "Step 4: Creating commit..."
git commit -m "$MESSAGE" || {
    echo "ℹ️  Nothing to commit (already committed?)"
}
echo ""

# Step 5: Push
echo "Step 5: Pushing to GitHub..."
if git push origin master 2>&1; then
    echo "✅ DEPLOYED SUCCESSFULLY!"
    echo ""
    echo "Live at: https://north-dev-ai.github.io/north-ai-website/"
    exit 0
else
    echo "❌ Push failed. Check git credentials."
    exit 1
fi
