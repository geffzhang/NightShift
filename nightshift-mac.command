#!/bin/bash
# Night Shift for macOS
# Turn off monitors and keep your machine awake for overnight AI agent sessions.

echo ""
echo "  _   _ _       _     _     ____  _     _  __ _   "
echo " | \ | (_) __ _| |__ | |_  / ___|| |__ (_)/ _| |_ "
echo " |  \| | |/ _\` | '_ \| __| \___ \| '_ \| | |_| __|"
echo " | |\  | | (_| | | | | |_   ___) | | | | |  _| |_ "
echo " |_| \_|_|\__, |_| |_|\__| |____/|_| |_|_|_|  \__|"
echo "          |___/                                     "
echo ""

# Keep system awake (prevent idle sleep) in the background
caffeinate -i &
CAFF_PID=$!

# Give caffeinate a moment to start, then turn off display
sleep 1
pmset displaysleepnow

echo "  Monitors OFF  |  System AWAKE"
echo "  Move mouse or press a key to wake monitors."
echo ""
echo "  Press Enter in this window to quit and restore"
echo "  normal power settings."
echo ""

read -r

# Kill caffeinate to restore normal sleep behavior
kill $CAFF_PID 2>/dev/null
echo "  Night Shift disabled. Normal power settings restored."
