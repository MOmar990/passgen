#!/bin/bash

# Passgen Script
# Generates random passwords and manages them in passwords/passwords.txt

PASSWORDS_FILE="passwords/passwords.txt"
DEFAULT_LENGTH=12

# Create passwords directory if it doesn't exist
mkdir -p passwords

# Function to generate a random password
generate_password() {
  tr -dc 'A-Za-z0-9!@#$%^&*' < /dev/urandom | head -c "$1" 2>/dev/null || true
}

# Function to save a password
save_password() {
  local label="$1"
  local length="$2"
  if [ -z "$length" ]; then
    length="$DEFAULT_LENGTH"
  fi
  if ! [[ "$length" =~ ^[0-9]+$ ]] || [ "$length" -le 0 ]; then
    echo "Error: Length must be a positive number."
    exit 1
  fi
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  password=$(generate_password "$length")
  echo "$timestamp | $label | $password" >> "$PASSWORDS_FILE"
  echo "Generated and saved password for $label: $password"
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
    save_password "$2" "$3"
    ;;
  list)
    list_passwords
    ;;
  *)
    echo "Usage: $0 {generate <label> [length] | list}"
    exit 1
    ;;
esac
