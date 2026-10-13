#!/bin/bash
# Twitter Content Generator - Creates topical engagement tweets

TYPE="${1:-tip}"
TOPIC="${2:-github-actions}"

echo "🐦 Twitter Content Generator"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo ""

case $TYPE in
  tip)
    echo "Type: Technical Tip"
    echo "Topic: $TOPIC"
    echo ""
    echo "Template:"
    echo "━━━━━━━━"
    echo "Common [TOPIC] mistake: [PROBLEM]"
    echo ""
    echo "[EXPLANATION]"
    echo ""
    echo "✅ Do: [SOLUTION]"
    echo "❌ Don't: [ANTIPATTERN]"
    echo ""
    echo "#DevOps #[RELEVANT_HASHTAG]"
    ;;
    
  cost)
    echo "Type: Cost Insight"
    echo "Topic: $TOPIC"
    echo ""
    echo "Template:"
    echo "━━━━━━━━"
    echo "Spent $[X]/mo on [SERVICE] until I realized:"
    echo ""
    echo "- [PROBLEM]: [DEFAULT_SETTING]"
    echo "- Changed to [BETTER_SETTING]"
    echo "- Saved $[Y]/mo"
    echo ""
    echo "Check your settings. [INSIGHT]"
    echo ""
    echo "#DevOps #CICD"
    ;;
    
  solution)
    echo "Type: Problem/Solution"
    echo "Topic: $TOPIC"
    echo ""
    echo "Template:"
    echo "━━━━━━━━"
    echo "[PROBLEM_QUESTION]?"
    echo ""
    echo "[SOLUTION_ACTION]:"
    echo "[CODE_SNIPPET]"
    echo ""
    echo "[BENEFIT/RESULT]"
    echo ""
    echo "#[RELEVANT_HASHTAG] #DevOps"
    ;;
    
  *)
    echo "Usage: twitter-content-generator.sh [tip|cost|solution] [topic]"
    echo ""
    echo "Examples:"
    echo "  ./twitter-content-generator.sh tip github-actions"
    echo "  ./twitter-content-generator.sh cost ci-cd"
    echo "  ./twitter-content-generator.sh solution docker"
    exit 1
    ;;
esac

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo "Remember:"
echo "- Keep under 280 characters"
echo "- Max 2-3 hashtags"
echo "- Genuine value only"
echo "- Space posts 4-6 hours apart"
