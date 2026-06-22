#!/bin/bash
#
# By -- WRQC343 -- www.gmrs-link.com
#
# Ver 1.0 - 6/26
#
# GMRS Freedom Nation Registration Installer


IAXCONF="/etc/asterisk/iax.conf"

if [ "$(id -u)" != "0" ]; then
    echo "Please run as root."
    exit 1
fi

stty sane
stty echo

read -p "Enter Node Number: " NODE
read -p "Enter Registration Password: " PASS
echo

REGSTRING="register => ${NODE}:${PASS}@register.gmrsfreedomnation.com"

echo
echo "Registration string:"
echo "$REGSTRING"
echo

# Backup
cp "$IAXCONF" "${IAXCONF}.bak.$(date +%Y%m%d-%H%M%S)"

# Insert at line 55
sed -i "55i $REGSTRING" "$IAXCONF"

echo "Registration added to line 55 of $IAXCONF"
echo "Backup created."

# Reload IAX
asterisk -rx "iax2 reload" 2>/dev/null

echo "Done."
