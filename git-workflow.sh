#!/bin/bash
# Git Workflow Manager - Reliable git operations with error recovery
# Handles commits, pushes, branch management, prevents permission issues

COMMAND="$1"
shift  # Remove first arg, rest are parameters

echo "🔧 Git Workflow Manager"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo ""

case "$COMMAND" in
    safe-push)
        REPO_DIR="$1"
        MESSAGE="${2:-Update $(date +%Y-%m-%d)}"
        
        cd "$REPO_DIR" || exit 1
        
        # Check if there are changes
        if [ -z "$(git status --porcelain)" ]; then
            echo "ℹ️  No changes to push"
            exit 0
        fi
        
        # Run error checker if available
        if [ -f ~/tools/error-checker.sh ]; then
            echo "Running error checker first..."
            if ! bash ~/tools/error-checker.sh "$REPO_DIR"; then
                echo "❌ Error checker failed. Fix errors before pushing."
                exit 1
            fi
        fi
        
        # Stage, commit, push
        git add -A
        git commit -m "$MESSAGE" || echo "Nothing new to commit"
        
        if git push origin master 2>&1; then
            echo "✅ Pushed successfully!"
        else
            echo "❌ Push failed. Checking for common issues..."
            
            # Try to diagnose
            if git remote -v | grep -q "https://"; then
                echo "💡 Using HTTPS. Make sure GH_TOKEN is set correctly."
                echo "   Try: git remote set-url origin https://\${GH_TOKEN}@github.com/..."
            fi
            exit 1
        fi
        ;;
        
    new-branch)
        REPO_DIR="$1"
        BRANCH_NAME="$2"
        
        cd "$REPO_DIR" || exit 1
        git checkout -b "$BRANCH_NAME"
        echo "✅ Created and switched to branch: $BRANCH_NAME"
        ;;
        
    clean-status)
        REPO_DIR="$1"
        cd "$REPO_DIR" || exit 1
        
        echo "Repository: $REPO_DIR"
        echo ""
        git status --short
        echo ""
        git log --oneline -5
        ;;
        
    *)
        echo "Usage: git-workflow.sh <command> [args]"
        echo ""
        echo "Commands:"
        echo "  safe-push <repo-dir> [message]  - Validate, commit, and push changes"
        echo "  new-branch <repo-dir> <name>    - Create and switch to new branch"
        echo "  clean-status <repo-dir>         - Show clean status summary"
        exit 1
        ;;
esac
