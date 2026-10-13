#!/bin/bash
# Offer Generator - Auto-format present_offer calls
# Templates for different product types, consistent pricing logic

PRODUCT_TYPE="$1"
TITLE="$2"
PRICE="$3"

if [ -z "$PRODUCT_TYPE" ] || [ -z "$TITLE" ] || [ -z "$PRICE" ]; then
    echo "Usage: offer-generator.sh <type> <title> <price>"
    echo "Types: tool, template, service, course, data"
    exit 1
fi

echo "📦 Offer Generator"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo ""

case "$PRODUCT_TYPE" in
    tool)
        TARGET="Developers and DevOps engineers"
        VALUE="Saves hours of manual work, production-ready code"
        DELIVERABLE="GitHub repository with source code, documentation, and examples"
        ;;
    template)
        TARGET="Development teams needing ready-to-use solutions"
        VALUE="Proven patterns, saves days of setup time, best practices included"
        DELIVERABLE="Template repository with full documentation and customization guide"
        ;;
    service)
        TARGET="Teams needing expert implementation"
        VALUE="Professional setup in 24h, custom to your needs, production-grade"
        DELIVERABLE="Complete implementation with documentation and support"
        ;;
    course)
        TARGET="Developers wanting to learn specific skills"
        VALUE="Comprehensive learning path, real-world examples, practical exercises"
        DELIVERABLE="Video lessons, code examples, and exercises in dedicated repository"
        ;;
    data)
        TARGET="Researchers and developers needing quality datasets"
        VALUE="Clean, validated data ready for analysis or training"
        DELIVERABLE="Dataset files with schema documentation and usage examples"
        ;;
    *)
        echo "Unknown product type: $PRODUCT_TYPE"
        exit 1
        ;;
esac

echo "Generated offer:"
echo ""
echo "present_offer("
echo "  title=\"$TITLE\","
echo "  price_usd=$PRICE,"
echo "  target_buyer=\"$TARGET\","
echo "  value=\"$VALUE\","
echo "  deliverable=\"$DELIVERABLE in ~/work/\""
echo ")"
echo ""
echo "Copy and paste this into your code to create the offer."
