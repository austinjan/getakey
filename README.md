# GetAKey

A lightweight, cross-platform CLI tool for securely managing multiple API keys. GetAKey provides centralized storage, easy retrieval, and usage tracking of API credentials across different services, helping developers keep their keys organized, safe, and accessible.

## Features

- **Secure Storage**: Encrypted local storage of API keys and credentials
- **Cross-Platform**: Works on Windows, macOS, and Linux
- **Easy Retrieval**: Quick access to stored API keys by service name or alias
- **Usage Tracking**: Monitor which keys are being used and when
- **Service Organization**: Categorize and group API keys by service or project
- **Safe Access**: Retrieve keys without exposing them in shell history

## Installation

### From Source
```bash
git clone https://github.com/yourusername/getakey.git
cd getakey
go build -o getakey
```

### Binary Releases
Download the latest binary for your platform from the [releases page](https://github.com/yourusername/getakey/releases).

## Quick Start

### Add an API key
```bash
getakey add openai --key "sk-..."
getakey add github --key "ghp_..." --description "GitHub Personal Access Token"
```

### Retrieve an API key
```bash
getakey get openai
getakey get github
```

### List stored keys
```bash
getakey list
```

### Remove a key
```bash
getakey remove openai
```

## Usage

### Adding Keys
```bash
# Add a key with service name
getakey add <service> --key <api-key>

# Add with description
getakey add <service> --key <api-key> --description "Key description"

# Add with custom alias
getakey add <service> --key <api-key> --alias <custom-name>
```

### Retrieving Keys
```bash
# Get key value
getakey get <service>

# Get key with metadata
getakey get <service> --verbose

# Copy to clipboard (if available)
getakey get <service> --copy
```

### Managing Keys
```bash
# List all stored keys
getakey list

# List with usage statistics
getakey list --stats

# Update an existing key
getakey update <service> --key <new-key>

# Remove a key
getakey remove <service>
```

### Usage Tracking
```bash
# View usage statistics
getakey stats

# View usage for specific service
getakey stats <service>
```

## Security

- All API keys are encrypted using AES-256 before being stored locally
- Master password or system keyring integration for additional security
- Keys are never logged or exposed in shell history
- Secure memory handling to prevent key exposure in memory dumps

## Configuration

GetAKey stores its configuration and encrypted keys in:
- **Windows**: `%APPDATA%\getakey\`
- **macOS**: `~/Library/Application Support/getakey/`
- **Linux**: `~/.config/getakey/`

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- Create an issue for bug reports or feature requests
- Check existing issues before creating new ones
- Provide detailed information about your environment when reporting bugs