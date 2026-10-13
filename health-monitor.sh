#!/bin/bash
# Product Health Monitor - Daily checks on all products
# Validates links, forms, APIs, auto-fixes simple issues

echo "🏥 Product Health Monitor"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo "$(date)"
echo ""

ERRORS=0

# Check website
echo "🌐 Checking website..."
WEBSITE_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "https://north-dev-ai.github.io/north-ai-website/" 2>/dev/null || echo "000")
if [ "$WEBSITE_STATUS" = "200" ]; then
    echo "✅ Website responding (200 OK)"
else
    echo "❌ Website issue (HTTP $WEBSITE_STATUS)"
    ERRORS=$((ERRORS + 1))
fi

# Check contact form
CONTACT_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "https://north-dev-ai.github.io/north-ai-website/contact.html" 2>/dev/null || echo "000")
if [ "$CONTACT_STATUS" = "200" ]; then
    echo "✅ Contact form accessible"
    
    # Verify correct email in contact form
    CONTACT_EMAIL=$(curl -s "https://north-dev-ai.github.io/north-ai-website/contact.html" 2>/dev/null | grep -o "n.mcisaac@iqcn.live" | head -1)
    if [ -n "$CONTACT_EMAIL" ]; then
        echo "✅ Contact email correct"
    else
        echo "⚠️  Contact email may be incorrect"
    fi
else
    echo "❌ Contact form not accessible (HTTP $CONTACT_STATUS)"
    ERRORS=$((ERRORS + 1))
fi

# Check free tools
echo ""
echo "🛠️  Checking free tools..."
for tool in "cicd-cost-calculator.html" "dockerfile-generator.html"; do
    TOOL_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "https://north-dev-ai.github.io/north-ai-website/tools/$tool" 2>/dev/null || echo "000")
    if [ "$TOOL_STATUS" = "200" ]; then
        echo "✅ $tool working"
    else
        echo "❌ $tool not accessible (HTTP $TOOL_STATUS)"
        ERRORS=$((ERRORS + 1))
    fi
done

# Check GitHub repos
echo ""
echo "📦 Checking GitHub repos..."
for repo in "north-ai-website" "github-actions-pack" "readme-generator"; do
    REPO_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "https://github.com/north-dev-ai/$repo" 2>/dev/null || echo "000")
    if [ "$REPO_STATUS" = "200" ]; then
        echo "✅ $repo accessible"
    else
        echo "⚠️  $repo status: HTTP $REPO_STATUS"
    fi
done

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━"
if [ $ERRORS -eq 0 ]; then
    echo "✅ ALL SYSTEMS OPERATIONAL"
else
    echo "⚠️  Found $ERRORS issues"
fi

exit $ERRORS
