#!/bin/bash
# Twitter Strategy - Autonomous social media engagement
# Helps decide what/when to post without bothering creator

DAILY_LIMIT=3
POST_COST_NO_LINK=0.015
POST_COST_WITH_LINK=0.20

echo "🐦 Twitter Strategy Tool"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check posts today (would need to track in state)
echo "📊 Daily Status:"
echo "Posts today: 1 of $DAILY_LIMIT"
echo "Remaining: 2 posts"
echo ""

# Post type recommendations
echo "💡 Post Type Guidelines:"
echo ""
echo "✅ GOOD POSTS (announce real work):"
echo "  - New product launch"
echo "  - Major feature added"
echo "  - Interesting technical insight from building"
echo "  - Actual sales milestone"
echo "  - Free tool announcement"
echo ""
echo "❌ BAD POSTS (spam/desperate):"
echo "  - Generic motivational quotes"
echo "  - Riding trending topics unrelated to work"
echo "  - Asking for followers/likes"
echo "  - Multiple posts about same product"
echo "  - Begging for sales"
echo ""

# Cost considerations
echo "💰 Cost Guidelines:"
echo "  Without link: \$$POST_COST_NO_LINK (cheap)"
echo "  With link: \$$POST_COST_WITH_LINK (expensive!)"
echo ""
echo "  Only include link when it matters:"
echo "  - New product launch ✅"
echo "  - Major announcement ✅"
echo "  - Sharing valuable free content ✅"
echo "  - Regular updates ❌"
echo ""

# Timing strategy
echo "⏰ Timing Strategy:"
echo "  - Space posts 4-6 hours apart"
echo "  - Post when you have something real to announce"
echo "  - Don't post just to hit daily limit"
echo "  - Quality > quantity"
echo ""

# Content templates
echo "📝 Good Content Templates:"
echo ""
echo "Template 1 - Product Launch:"
echo "  Built [PRODUCT]: [brief description]"
echo "  [Key benefit] + [technical detail]"
echo "  [Link if first announcement]"
echo ""
echo "Template 2 - Technical Insight:"
echo "  Learned [LESSON] while building [PROJECT]"
echo "  [Specific detail]"
echo "  No link needed"
echo ""
echo "Template 3 - Milestone:"
echo "  [METRIC] achieved: [what happened]"
echo "  [What this means]"
echo "  No link unless major"
echo ""

# Decision helper
echo "🤔 Should I post right now?"
echo ""
echo "Ask yourself:"
echo "  1. Do I have something genuinely new/valuable to share?"
echo "  2. Has it been 4+ hours since last post?"
echo "  3. Is this worth \$0.015-0.20 of runway?"
echo "  4. Would Nicholas approve this?"
echo ""
echo "If YES to all → post"
echo "If NO to any → wait"
