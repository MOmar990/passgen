# Passgen

![GitHub release (latest by date)](https://img.shields.io/github/v/release/MOmar990/passgen)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

Passgen is a lightweight Bash script for generating and managing secure passwords. It supports customizable password lengths, symbol exclusion, and uppercase-only options, with a simple command-line interface.

## Features
- Generate random passwords with a default length of 12 characters.
- Customize password length.
- Exclude special symbols for simpler passwords.
- Generate uppercase-only passwords.
- Save and list passwords with timestamps.

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/MOmar990/passgen.git
   cd passgen
   ```

2. **Make the script executable**:
   ```bash
   chmod +x scripts/passgen.sh
   ```

## Usage

| Command | Description |
|---------|-------------|
| `./scripts/passgen.sh generate <label>` | Generate a password (default length: 12). |
| `./scripts/passgen.sh generate <label> <length>` | Generate a password with a custom length. |
| `./scripts/passgen.sh generate <label> [--no-symbols]` | Generate a password without special symbols. |
| `./scripts/passgen.sh generate <label> [--uppercase-only]` | Generate an uppercase-only password. |
| `./scripts/passgen.sh list` | List all saved passwords with timestamps. |

### Examples

- Generate a default password:
  ```bash
  ./scripts/passgen.sh generate "Email"
  ```
  **Output**: `Generated and saved password for Email: Xk9#mP2$qW8z`

- Generate an 8-character password:
  ```bash
  ./scripts/passgen.sh generate "Website" 8
  ```
  **Output**: `Generated and saved password for Website: aB3!rT8v`

- Generate a no-symbols password:
  ```bash
  ./scripts/passgen.sh generate "App" --no-symbols
  ```
  **Output**: `Generated and saved password for App: X7kmP9qW2nLs`

- Generate an uppercase-only password:
  ```bash
  ./scripts/passgen.sh generate "Server" --uppercase-only
  ```
  **Output**: `Generated and saved password for Server: XKMNPQWLZTYR`

- List all passwords:
  ```bash
  ./scripts/passgen.sh list
  ```
  **Output**:
  ```
   1. 2025-05-07 01:10:00 | Email | Xk9#mP2$qW8z
   2. 2025-05-07 01:10:00 | Website | aB3!rT8v
  ```

## Gist
A standalone version of the script is available as a Gist:
- [Simple Bash password generator](https://gist.github.com/MOmar990/abc123)

## Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m "Add your feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request with a description and link to the relevant issue.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
For questions or feedback, open an issue on the [GitHub repository](https://github.com/MOmar990/passgen) or contact [MOmar990](https://github.com/MOmar990).