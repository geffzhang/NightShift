#!/bin/bash
# Night Shift for Linux
# Turn off monitors and keep your machine awake for overnight AI agent sessions.

echo ""
echo "  _   _ _       _     _     ____  _     _  __ _   "
echo " | \ | (_) __ _| |__ | |_  / ___|| |__ (_)/ _| |_ "
echo " |  \| | |/ _\` | '_ \| __| \___ \| '_ \| | |_| __|"
echo " | |\  | | (_| | | | | |_   ___) | | | | |  _| |_ "
echo " |_| \_|_|\__, |_| |_|\__| |____/|_| |_|_|_|  \__|"
echo "          |___/                                     "
echo ""

# Detect display server
DISPLAY_SERVER="unknown"
if [ -n "$WAYLAND_DISPLAY" ]; then
    DISPLAY_SERVER="wayland"
elif [ -n "$DISPLAY" ]; then
    DISPLAY_SERVER="x11"
fi

# Keep system awake in the background
INHIBIT_PID=""
if command -v systemd-inhibit &>/dev/null; then
    systemd-inhibit --what=idle --who="Night Shift" --why="Keeping system awake for AI agents" sleep infinity &
    INHIBIT_PID=$!
elif command -v xdg-screensaver &>/dev/null; then
    # Create a dummy window ID for xdg-screensaver
    xdg-screensaver suspend "$(xdotool getactivewindow 2>/dev/null || echo 0)" &
    INHIBIT_PID=$!
else
    echo "  Warning: Could not find systemd-inhibit or xdg-screensaver."
    echo "  System may still go to sleep."
fi

# Turn off monitors
sleep 1
if [ "$DISPLAY_SERVER" = "wayland" ]; then
    if command -v wlopm &>/dev/null; then
        for output in $(wlopm | awk '{print $1}'); do
            wlopm --off "$output"
        done
    elif command -v swaymsg &>/dev/null; then
        swaymsg "output * dpms off"
    elif command -v gnome-screensaver-command &>/dev/null; then
        gnome-screensaver-command -a
    else
        echo "  Warning: Could not detect a supported Wayland method to turn off monitors."
        echo "  Supported: wlopm, swaymsg, gnome-screensaver-command"
        echo "  System will still stay awake."
    fi
elif [ "$DISPLAY_SERVER" = "x11" ]; then
    xset dpms force off
else
    echo "  Warning: No display server detected. System will stay awake but"
    echo "  could not turn off monitors."
fi

echo "  Monitors OFF  |  System AWAKE"
echo "  Move mouse or press a key to wake monitors."
echo ""
echo "  Press Enter in this window to quit and restore"
echo "  normal power settings."
echo ""

read -r

# Restore normal settings
if [ -n "$INHIBIT_PID" ]; then
    kill $INHIBIT_PID 2>/dev/null
fi

# Restore monitors if on Wayland
if [ "$DISPLAY_SERVER" = "wayland" ]; then
    if command -v wlopm &>/dev/null; then
        for output in $(wlopm | awk '{print $1}'); do
            wlopm --on "$output"
        done
    elif command -v swaymsg &>/dev/null; then
        swaymsg "output * dpms on"
    fi
fi

echo "  Night Shift disabled. Normal power settings restored."
