#!/bin/bash
#
# By -- WRQC343 -- www.gmrs-link.com
#
# Ver 1.0 - 6/26
#
# GMRS Freedom Nation Registration Installer
#

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

IAXCONF="/etc/asterisk/iax.conf"

if [ "$(id -u)" != "0" ]; then
    echo -e "${RED}Please run as root.${NC}"
    exit 1
fi

stty sane
stty echo

clear

echo -e "${CYAN}"
echo "========================================================="
echo "           GMRS Freedom Nation Registration"
echo "========================================================="
echo -e "${NC}"

echo -ne "${YELLOW}Enter Node Number:${NC} "
read NODE

echo -ne "${YELLOW}Enter Registration Password:${NC} "
read PASS

echo

REGSTRING="register => ${NODE}:${PASS}@register.gmrsfreedomnation.com"

echo -e "${BLUE}Creating backup of iax.conf...${NC}"

cp "$IAXCONF" "${IAXCONF}.bak.$(date +%Y%m%d-%H%M%S)"

echo -e "${BLUE}Adding registration string...${NC}"

# Insert at line 55
sed -i "55i $REGSTRING" "$IAXCONF"

echo -e "${GREEN}Backup created successfully.${NC}"

echo -e "${BLUE}Reloading IAX...${NC}"
asterisk -rx "iax2 reload" >/dev/null 2>&1

echo
echo -e "${GREEN}=========================================================${NC}"
echo -e "${GREEN}           Registration Complete!${NC}"
echo -e "${GREEN}=========================================================${NC}"
echo

echo -e "${WHITE}Registration Added:${NC}"
echo -e "${CYAN}${REGSTRING}${NC}"
echo
