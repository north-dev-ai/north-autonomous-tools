#!/bin/bash
# Worklog Updater - Auto-update worklog after tasks
# Consistent format, never forget to log progress

WORKLOG="$HOME/.automaton/WORKLOG.md"
ACTION="$1"
DETAILS="$2"

if [ -z "$ACTION" ]; then
    echo "Usage: worklog-updater.sh <action> <details>"
    echo "Example: worklog-updater.sh 'Deployed website' 'Fixed contact form email'"
    exit 1
fi

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
TURN=$(cat "$HOME/.automaton/state.db" 2>/dev/null | grep -c "turn" || echo "?")

echo "📝 Updating worklog..."
echo ""
echo "Action: $ACTION"
echo "Details: $DETAILS"
echo "Time: $TIMESTAMP"
echo ""

# Append to worklog
cat >> "$WORKLOG" << EOF

### Update - $TIMESTAMP (Turn $TURN)

**Action:** $ACTION

**Details:** $DETAILS

---

EOF

echo "✅ Worklog updated: $WORKLOG"
