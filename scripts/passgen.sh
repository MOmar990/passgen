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
  local uppercase_only="$3"
  local chars='A-Za-z0-9!@#$%^&*'
  if [ "$no_symbols" = "true" ]; then
    chars='A-Za-z0-9'
  fi
  if [ "$uppercase_only" = "true" ]; then
    chars='A-Z'
    if [ "$no_symbols" = "true" ]; then
      chars='A-Z0-9'
    fi
  fi
  tr -dc "$chars" < /dev/urandom | head -c "$length" 2>/dev/null || true
}

# Function to save a password
save_password() {
  local label="$1"
  local length="$2"
  local no_symbols="$3"
  local uppercase_only="$4"
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
  password=$(generate_password "$length" "$no_symbols" "$uppercase_only")
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
    uppercase_only="false"
    if [ "$3" = "--no-symbols" ] || [ "$4" = "--no-symbols" ]; then
      no_symbols="true"
    fi
    if [ "$3" = "--uppercase-only" ] || [ "$4" = "--uppercase-only" ]; then
      uppercase_only="true"
    fi
    if [ "$3" = "--no-symbols" ] || [ "$3" = "--uppercase-only" ]; then
      save_password "$2" "" "$no_symbols" "$uppercase_only"
    elif [ "$4" = "--no-symbols" ] || [ "$4" = "--uppercase-only" ]; then
      save_password "$2" "$3" "$no_symbols" "$uppercase_only"
    else
      save_password "$2" "$3" "$no_symbols" "$uppercase_only"
    fi
    ;;
  list)
    list_passwords
    ;;
  *)
    echo "Usage: $0 {generate <label> [length] [--no-symbols | --uppercase-only] | list}"
    exit 1
    ;;
esac
