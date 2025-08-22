# GetAKey

A minimal Go CLI application. to manage API keys securely.

## Current Status

This is a basic CLI framework implementation ready for feature development. The foundation includes:

- **Modern CLI Framework**: Built with Cobra for professional command structure
- **Beautiful Output**: PTerm integration for elegant, colorful terminal interface
- **Build System**: Comprehensive Makefile with version injection and cross-compilation
- **Cross-Platform**: Builds for Windows, macOS, and Linux

## Installation

### From Source
```bash
git clone https://github.com/yourusername/getakey.git
cd getakey
make build
```

The binary will be created in the `build/` directory.

## Usage

### Basic Commands

```bash
# Show help and banner
./build/getakey

# Show version information
./build/getakey version

# Show help
./build/getakey --help
```

## Development

### Build Commands

```bash
# Build the application
make build

# Build for production (optimized)
make build-prod

# Cross-compile for Linux
make build-linux

# Cross-compile for Windows  
make build-windows

# Clean build artifacts
make clean

# Run formatting and vetting
make fmt && make vet

# Run the application
make run

# Run with version command
make run-version

# Show build information
make info

# Show all available targets
make help
```

### Project Structure

```
├── build/              # Build output directory
├── cmd/
│   ├── getakey/       # Main entry point
│   ├── root.go        # Root command with Cobra
│   └── version.go     # Version command
├── Makefile           # Build system with version injection
├── go.mod             # Go module with dependencies
└── README.md
```

## Dependencies

- **Cobra**: Modern CLI framework for Go
- **PTerm**: Beautiful terminal output library
- **Go 1.24.4**: Programming language version

## Future Development

This CLI framework is ready for implementing key management features such as:
- Secure storage of API keys
- Encrypted local storage  
- Key retrieval and management
- Usage tracking
- Cross-platform configuration

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Make sure to run `make fmt && make vet` before committing.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.