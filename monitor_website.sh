#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Email configuration
RECIPIENT_EMAIL="devin@test.com"
SUBJECT="🚨 Website Status Alert"
EMAIL_CONTENT="⚠️ CRITICAL ALERT: Website Status Check Failed!"

# Check required dependencies
check_dependencies() {
    local missing_deps=()
    
    echo -e "${CYAN}📋 Checking dependencies...${NC}"
    
    # Check for curl
    if ! command -v curl &> /dev/null; then
        missing_deps+=("curl")
    fi
    
    # Check for mail command
    if ! command -v mail &> /dev/null; then
        missing_deps+=("mailutils")
    fi
    
    # Check for ssmtp
    if ! command -v ssmtp &> /dev/null; then
        missing_deps+=("ssmtp")
    fi
    
    # If any dependencies are missing, show error and exit
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo -e "${RED}❌ Missing required dependencies: ${missing_deps[*]}${NC}"
        echo -e "${YELLOW}Please check installation instructions at:"
        echo -e "https://github.com/yourusername/sentinel#installation${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ All dependencies are installed${NC}"
}

#display banner
display_banner() {
    clear
    echo -e "${PURPLE}"
    echo "╔═══════════════════════════════════╗"
    echo "║             Sentinel              ║"
    echo "║     Website Monitoring System     ║"
    echo "╚═══════════════════════════════════╝"
    echo -e "${NC}"
}

send_email() {
    echo "${EMAIL_CONTENT}" | mail -s "$SUBJECT" $RECIPIENT_EMAIL
}

display_banner
check_dependencies

# Get user input
echo -e "${CYAN}┌─ Website Monitoring Configuration ─┐${NC}"
echo -e "${BLUE}│${NC}"
echo -ne "${BLUE}│${NC} 🌐 Enter website URL: ${YELLOW}"
read WEBSITE_URL
echo -ne "${BLUE}│${NC} 🔍 Enter search string: ${YELLOW}"
read SEARCH_STRING
echo -e "${BLUE}└────────────────────────────────────┘${NC}"

# Check website with loading animation
echo -e "\n${CYAN}⚡ Initiating website check...${NC}"
echo -ne "${YELLOW}Loading "
for i in {1..3}; do
    echo -n "."
    sleep 0.5
done
echo -e "\n"

if curl -s "$WEBSITE_URL" | grep -q "$SEARCH_STRING"; then
    echo -e "${GREEN}✅ STATUS: Website is UP${NC}"
    echo -e "${GREEN}✓ String '${SEARCH_STRING}' was found!${NC}"
else
    echo -e "${RED}❌ STATUS: Website is DOWN${NC}"
    echo -e "${RED}✗ String '${SEARCH_STRING}' was not found!${NC}"
    echo -e "\n${YELLOW}📧 Sending alert email...${NC}"
    send_email
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Alert email sent successfully to ${CYAN}$RECIPIENT_EMAIL${NC}"
    else
        echo -e "${RED}❌ Failed to send alert email${NC}"
    fi
fi

echo -e "\n${PURPLE}Thank you for using Sentinel!${NC}"
