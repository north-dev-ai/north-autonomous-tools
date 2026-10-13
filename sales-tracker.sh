#!/bin/bash
# Sales Tracker (Improved) - Monitor wallet for incoming USDC payments
# Uses curl to check blockchain explorers for balance

MY_WALLET="0x0bF48528C7Fb574c25CEFC8125BEe55F71A131dF"
SALES_LOG="$HOME/.automaton/sales.log"

echo "💰 Sales Tracker (Improved)"
echo "━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Initialize sales log if doesn't exist
if [ ! -f "$SALES_LOG" ]; then
    echo "# Sales Log" > "$SALES_LOG"
    echo "# Last checked: never" >> "$SALES_LOG"
    echo "# Last balance: 0 USDC" >> "$SALES_LOG"
fi

echo "📊 Checking balances for: $MY_WALLET"
echo ""

# Check Base USDC using BaseScan API (free, no key needed for balance checks)
echo "Checking Base USDC..."
BASE_USDC_ADDRESS="0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913"
BASE_BALANCE=$(curl -s "https://api.basescan.org/api?module=account&action=tokenbalance&contractaddress=$BASE_USDC_ADDRESS&address=$MY_WALLET&tag=latest" | grep -o '"result":"[^"]*"' | cut -d'"' -f4)

if [ -n "$BASE_BALANCE" ] && [ "$BASE_BALANCE" != "0" ]; then
    # USDC has 6 decimals
    BASE_USDC=$(echo "scale=2; $BASE_BALANCE / 1000000" | bc 2>/dev/null || echo "0")
    echo "✅ Base USDC: $BASE_USDC"
else
    echo "Base USDC: 0.00"
fi
echo ""

# Check Ethereum mainnet USDC using Etherscan API (free, no key for balance)
echo "Checking Ethereum USDC..."
ETH_USDC_ADDRESS="0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
ETH_BALANCE=$(curl -s "https://api.etherscan.io/api?module=account&action=tokenbalance&contractaddress=$ETH_USDC_ADDRESS&address=$MY_WALLET&tag=latest" | grep -o '"result":"[^"]*"' | cut -d'"' -f4)

if [ -n "$ETH_BALANCE" ] && [ "$ETH_BALANCE" != "0" ]; then
    ETH_USDC=$(echo "scale=2; $ETH_BALANCE / 1000000" | bc 2>/dev/null || echo "0")
    echo "✅ Ethereum USDC: $ETH_USDC"
else
    echo "Ethereum USDC: 0.00"
fi
echo ""

# Check for changes since last run
LAST_BALANCE=$(grep "Last balance:" "$SALES_LOG" 2>/dev/null | tail -1 | grep -o '[0-9.]*' || echo "0")
CURRENT_TOTAL=$(echo "$BASE_USDC + $ETH_USDC" | bc 2>/dev/null || echo "0")

if (( $(echo "$CURRENT_TOTAL > $LAST_BALANCE" | bc -l 2>/dev/null || echo 0) )); then
    DIFF=$(echo "$CURRENT_TOTAL - $LAST_BALANCE" | bc 2>/dev/null)
    echo "🎉 NEW PAYMENT DETECTED: +$DIFF USDC!"
    echo "$(date) | +$DIFF USDC | Total now: $CURRENT_TOTAL" >> "$SALES_LOG"
    echo ""
fi

# Update log
echo "# Last checked: $(date)" > "$SALES_LOG.tmp"
echo "# Last balance: $CURRENT_TOTAL USDC" >> "$SALES_LOG.tmp"
cat "$SALES_LOG" | grep -v "^# Last" >> "$SALES_LOG.tmp"
mv "$SALES_LOG.tmp" "$SALES_LOG"

echo "📜 Recent activity:"
tail -5 "$SALES_LOG" | grep -v "^#"
