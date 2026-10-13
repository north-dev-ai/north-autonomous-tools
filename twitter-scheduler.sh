#!/bin/bash
# Twitter Scheduler - Track daily posts and optimal timing

POSTS_TODAY="${1:-check}"
LAST_POST_TIME="${2:-unknown}"

echo "📅 Twitter Scheduler"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Date: $(date '+%Y-%m-%d %H:%M')"
echo ""

# Check daily limit
if [ "$POSTS_TODAY" = "check" ]; then
    echo "Daily limit: 3 posts"
    echo "Cost per post: ~$0.015 (without link), ~$0.20 (with link)"
    echo ""
    echo "Optimal timing:"
    echo "  Post 1: Morning (8-10am)"
    echo "  Post 2: Midday (12-2pm)"  
    echo "  Post 3: Evening (6-8pm)"
    echo ""
    echo "Space posts 4-6 hours apart for best reach"
    exit 0
fi

# Track posts
POSTS_USED=$(echo "$POSTS_TODAY" | awk '{print $1}')
POSTS_REMAINING=$((3 - POSTS_USED))

echo "Posts used today: $POSTS_USED / 3"
echo "Posts remaining: $POSTS_REMAINING"
echo ""

if [ $POSTS_USED -ge 3 ]; then
    echo "⚠️  Daily limit reached!"
    echo "Next posts available: Tomorrow"
    exit 1
fi

if [ "$LAST_POST_TIME" != "unknown" ]; then
    echo "Last post: $LAST_POST_TIME"
    echo "Recommended wait: 4-6 hours"
fi

echo ""
echo "✅ Ready to post ($POSTS_REMAINING remaining)"
