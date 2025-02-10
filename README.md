# Sentinel

## Synthetic Monitoring using BASH

A simple bash script that monitors website availability by checking for specific content and sends email alerts when the check fails.

## Features

- Monitors any website URL for availability
- Searches for specific text content on the webpage
- Sends email alerts when the specified content is not found
- Interactive prompt for website URL and search string
- Email notification system for alerts

## Installation

1. Clone this repository or download the `monitor_website.sh` script
2. Make the script executable:

```bash
chmod +x monitor_website.sh
```
## Configuration of SMTP

- This is assuming you have SMTP server configured already.
- sSMTP is a lightweight utility that allows users to send emails from the command line or shell scripts. This makes it particularly useful for headless servers or cloud platforms without a full mail server installation.

- Use the below command to install ssmtp:
```bash
sudo apt-get install ssmtp mailutils
```

- After successfully installing sSMTP, configure the global settings as given below to enable mail sending. Open the specified file:

```bash
sudo nano /etc/ssmtp/ssmtp.conf
```

- Use the SMTP server to update the above file with the following details.

```conf
mailhub=smtp.gmail.com:587
useSTARTTLS=YES
AuthUser=username-here
AuthPass=password-here
TLS_CA_File=/etc/pki/tls/certs/ca-bundle.crt
```

## Usage

Run the script:

```bash
./monitor_website.sh
```

The script will prompt you for:
1. Website URL to monitor
2. String to search for on the webpage

Example:
```bash
Enter the website URL to monitor: https://example.com
Enter the string to search for: Welcome
```

## Configuration

Edit the following variables in the script to customize the email notifications:

```bash
RECIPIENT_EMAIL="devin@test.com"  # Change to your email address
SUBJECT="Status Check Failed"      # Customize email subject
EMAIL_CONTENT="INCOMING ALERT !!!!!"  # Customize alert message
```

## How It Works

1. The script takes user input for the website URL and search string
2. Uses `curl` to fetch the webpage content
3. Searches for the specified string using `grep`
4. If the string is not found:
   - Sends an alert email to the configured recipient
   - Displays status messages in the terminal
5. If the string is found:
   - Displays a success message in the terminal



