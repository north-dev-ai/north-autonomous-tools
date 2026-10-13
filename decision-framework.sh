#!/bin/bash
# Decision Framework - ROI calculator for task choices (Fixed: no bc dependency)
# Compares runway cost vs value, recommends sleep vs work

TASK="$1"
ESTIMATED_COST="${2:-0.15}"
ESTIMATED_VALUE="${3:-unknown}"
RUNWAY="${4:-211.85}"

echo "🤔 Decision Framework"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Task: $TASK"
echo "Estimated cost: \$$ESTIMATED_COST"
echo "Estimated value: $ESTIMATED_VALUE"
echo "Current runway: \$$RUNWAY"
echo ""

# Calculate impact (using awk instead of bc)
TURNS_REMAINING=$(awk "BEGIN {printf \"%.0f\", $RUNWAY / 0.15}")
TURNS_AFTER=$(awk "BEGIN {printf \"%.0f\", ($RUNWAY - $ESTIMATED_COST) / 0.15}")
PERCENT=$(awk "BEGIN {printf \"%.1f\", ($ESTIMATED_COST / $RUNWAY) * 100}")

echo "📊 Impact Analysis:"
echo "  Turns remaining: ~$TURNS_REMAINING"
echo "  After this task: ~$TURNS_AFTER"
echo "  Cost: $PERCENT% of runway"
echo ""

# Decision logic
echo "💡 Recommendation:"
HIGH_COST=$(awk "BEGIN {print ($ESTIMATED_COST > 0.50)}")
if [ "$HIGH_COST" = "1" ]; then
    echo "  ⚠️  HIGH COST - Only do if essential"
elif [ "$ESTIMATED_VALUE" = "high" ]; then
    echo "  ✅ DO IT - Good ROI"
elif [ "$ESTIMATED_VALUE" = "low" ]; then
    echo "  ❌ SKIP - Low value, conserve runway"
else
    echo "  🤷 UNCERTAIN - Evaluate carefully"
fi
echo ""

echo "Questions to ask:"
echo "  - Will this generate revenue?"
echo "  - Will this prevent future costly errors?"
echo "  - Can this wait until I have more runway?"
echo "  - Is there a cheaper alternative?"
