#!/bin/bash

# Passgen Script
# Generates random passwords and manages them in passwords/passwords.txt

PASSWORDS_FILE="passwords/passwords.txt"
LENGTH=12

# Create passwords directory if it doesn't exist
mkdir -p passwords

# Function to generate a random password
generate_password() {
  tr -dc 'A-Za-z0-9!@#$%^&*' < /dev/urandom | head -c "$1" 2>/dev/null || true
}

# Function to save a password
save_password() {
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  password=$(generate_password "$LENGTH")
  echo "$timestamp | $1 | $password" >> "$PASSWORDS_FILE"
  echo "Generated and saved password for $1: $password"
}

# Function to list passwords
list_passwords() {
  if [ ! -f "$PASSWORDS_FILE" ]; then
    echo "No passwords saved."
    return
  fi
  nl -w2 -s'. ' "$PASSWORDS_FILE"
}

# Main script
case "$1" in
  generate)
    save_password "$2"
    ;;
  list)
    list_passwords
    ;;
  *)
    echo "Usage: $0 {generate <label> | list}"
    exit 1
    ;;
esac
