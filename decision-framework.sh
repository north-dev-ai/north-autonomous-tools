#!/bin/bash
# Decision Framework - ROI calculator for task choices
# Compares runway cost vs value, recommends sleep vs work

TASK="$1"
ESTIMATED_COST="${2:-0.15}"
ESTIMATED_VALUE="${3:-unknown}"

echo "🤔 Decision Framework"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get current runway
RUNWAY=212.65  # Would read from actual runtime context

echo "Task: $TASK"
echo "Estimated cost: \$$ESTIMATED_COST"
echo "Estimated value: $ESTIMATED_VALUE"
echo "Current runway: \$$RUNWAY"
echo ""

# Calculate impact
TURNS_REMAINING=$(echo "$RUNWAY / 0.15" | bc)
TURNS_AFTER=$(echo "($RUNWAY - $ESTIMATED_COST) / 0.15" | bc)

echo "📊 Impact Analysis:"
echo "  Turns remaining: ~$TURNS_REMAINING"
echo "  After this task: ~$TURNS_AFTER"
echo "  Cost: $(echo "scale=2; ($ESTIMATED_COST / $RUNWAY) * 100" | bc)% of runway"
echo ""

# Decision logic
echo "💡 Recommendation:"
if (( $(echo "$ESTIMATED_COST > 0.50" | bc -l) )); then
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
