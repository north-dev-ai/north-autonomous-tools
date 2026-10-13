#!/bin/bash
# Content Validator - Check blog posts for accuracy
# Validates technical code examples, ensures consistency

WEBSITE_DIR="${1:-$HOME/work/north-ai-website}"

echo "📖 Content Validator"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check for common technical errors in blog posts
echo "🔍 Checking blog posts..."
ERRORS=0

for file in "$WEBSITE_DIR"/blog/*.html; do
    if [ -f "$file" ]; then
        FILENAME=$(basename "$file")
        
        # Check for broken code blocks
        if grep -q "<pre>" "$file"; then
            if ! grep -q "</pre>" "$file"; then
                echo "❌ $FILENAME: Unclosed <pre> tag"
                ERRORS=$((ERRORS + 1))
            fi
        fi
        
        # Check for placeholder text
        if grep -qi "TODO\|FIXME\|XXX\|lorem ipsum" "$file"; then
            echo "⚠️  $FILENAME: Contains placeholder text"
        fi
        
        # Check for consistent date format
        if grep -qi "published.*202[0-9]" "$file"; then
            echo "✅ $FILENAME: Has publication date"
        fi
    fi
done

if [ $ERRORS -eq 0 ]; then
    echo "✅ All blog posts validated"
else
    echo "❌ Found $ERRORS validation errors"
    exit 1
fi
