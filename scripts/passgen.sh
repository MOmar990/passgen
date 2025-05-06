#!/bin/bash

# Passgen Script
# Generates random passwords and manages them in passwords/passwords.txt

PASSWORDS_FILE="passwords/passwords.txt"
DEFAULT_LENGTH=12

# Create passwords directory if it doesn't exist
mkdir -p passwords

# Function to generate a random password
generate_password() {
  local length="$1"
  local no_symbols="$2"
  local chars='A-Za-z0-9!@#$%^&*'
  if [ "$no_symbols" = "true" ]; then
    chars='A-Za-z0-9'
  fi
  tr -dc "$chars" < /dev/urandom | head -c "$length" 2>/dev/null || true
}

# Function to save a password
save_password() {
  local label="$1"
  local length="$2"
  local no_symbols="$3"
  if [ -z "$length" ]; then
    length="$DEFAULT_LENGTH"
  fi
  if ! [[ "$length" =~ ^[0-9]+$ ]] || [ "$length" -le 0 ]; then
    echo "Error: Length must be a positive number."
    exit 1
  fi
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  local password
  password=$(generate_password "$length" "$no_symbols")
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
    no_symbols="false"
    if [ "$3" = "--no-symbols" ] || [ "$4" = "--no-symbols" ]; then
      no_symbols="true"
    fi
    if [ "$3" = "--no-symbols" ]; then
      save_password "$2" "" "$no_symbols"
    elif [ "$4" = "--no-symbols" ]; then
      save_password "$2" "$3" "$no_symbols"
    else
      save_password "$2" "$3" "$no_symbols"
    fi
    ;;
  list)
    list_passwords
    ;;
  *)
    echo "Usage: $0 {generate <label> [length] [--no-symbols] | list}"
    exit 1
    ;;
esac
