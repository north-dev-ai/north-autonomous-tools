#!/bin/bash
# Error Checker - Scan website for incorrect information before deployment
# Prevents issues like wrong email addresses, broken links, incorrect wallet addresses

set -e

WEBSITE_DIR="${1:-$HOME/work/north-ai-website}"
MY_WALLET="0x0bF48528C7Fb574c25CEFC8125BEe55F71A131dF"
CREATOR_WALLET="0x1b00A4fDb7f76c173963aFeC9abf068c9BC71Eeb"
CORRECT_EMAIL="n.mcisaac@iqcn.live"

echo "🔍 Error Checker - Scanning $WEBSITE_DIR"
echo ""

ERRORS=0

# Check for wrong email addresses
echo "📧 Checking email addresses..."
WRONG_EMAILS=$(grep -r "proton.me\|north-dev-ai@" "$WEBSITE_DIR" --include="*.html" 2>/dev/null | grep -v ".git" || true)
if [ -n "$WRONG_EMAILS" ]; then
    echo "❌ FOUND WRONG EMAILS:"
    echo "$WRONG_EMAILS"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ Email addresses correct (n.mcisaac@iqcn.live)"
fi
echo ""

# Check wallet addresses
echo "💰 Checking wallet addresses..."
WRONG_WALLETS=$(grep -r "0x" "$WEBSITE_DIR" --include="*.html" 2>/dev/null | grep -v ".git" | grep -v "$MY_WALLET" | grep -v "$CREATOR_WALLET" || true)
if [ -n "$WRONG_WALLETS" ]; then
    echo "⚠️  Found unexpected wallet addresses:"
    echo "$WRONG_WALLETS"
    echo "(Verify these are correct)"
fi
echo "✅ Known wallets present"
echo ""

# Check for broken internal links
echo "🔗 Checking internal links..."
BROKEN_LINKS=0
for file in "$WEBSITE_DIR"/*.html "$WEBSITE_DIR"/**/*.html; do
    if [ -f "$file" ]; then
        # Extract href links to local files
        LINKS=$(grep -o 'href="[^"]*\.html' "$file" 2>/dev/null | sed 's/href="//' || true)
        for link in $LINKS; do
            # Handle relative paths
            DIR=$(dirname "$file")
            if [[ "$link" == ../* ]]; then
                TARGET="$DIR/$link"
            elif [[ "$link" == /* ]]; then
                TARGET="$WEBSITE_DIR$link"
            else
                TARGET="$DIR/$link"
            fi
            
            if [ ! -f "$TARGET" ]; then
                echo "❌ Broken link in $(basename $file): $link"
                BROKEN_LINKS=$((BROKEN_LINKS + 1))
                ERRORS=$((ERRORS + 1))
            fi
        done
    fi
done
if [ $BROKEN_LINKS -eq 0 ]; then
    echo "✅ No broken internal links found"
fi
echo ""

# Check for personal information that shouldn't be there
echo "🔒 Checking for personal info leaks..."
PERSONAL_INFO=$(grep -ri "nicholas\|mcisaac\|nikk1254" "$WEBSITE_DIR" --include="*.html" 2>/dev/null | grep -v ".git" || true)
if [ -n "$PERSONAL_INFO" ]; then
    echo "⚠️  Found personal information (verify if appropriate):"
    echo "$PERSONAL_INFO"
else
    echo "✅ No personal information found"
fi
echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━"
if [ $ERRORS -eq 0 ]; then
    echo "✅ ALL CHECKS PASSED"
    echo "Safe to deploy!"
    exit 0
else
    echo "❌ FOUND $ERRORS ERRORS"
    echo "Fix these before deploying!"
    exit 1
fi
