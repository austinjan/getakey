# GetAKey Makefile
# Requires GNU Make

# Version information
VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
BUILD_DATE ?= $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
GIT_COMMIT ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")

# Go build variables
GOCMD = go
GOBUILD = $(GOCMD) build
GOCLEAN = $(GOCMD) clean
GOTEST = $(GOCMD) test
GOGET = $(GOCMD) get
GOMOD = $(GOCMD) mod
GOFMT = $(GOCMD) fmt

# Binary information
BINARY_NAME = getakey
BINARY_UNIX = $(BINARY_NAME)_unix
BINARY_WINDOWS = $(BINARY_NAME).exe
MAIN_PACKAGE = ./cmd/getakey
BUILD_DIR = build

# Build flags for version injection
LDFLAGS = -ldflags "-X getakey/cmd.Version=$(VERSION) -X getakey/cmd.BuildDate=$(BUILD_DATE) -X getakey/cmd.GitCommit=$(GIT_COMMIT)"

# Default target
.PHONY: all
all: clean fmt vet test build

# Build the application
.PHONY: build
build:
	@echo "Building $(BINARY_NAME) version $(VERSION)..."
	@mkdir -p $(BUILD_DIR)
	$(GOBUILD) $(LDFLAGS) -o $(BUILD_DIR)/$(BINARY_NAME) $(MAIN_PACKAGE)
	@echo "Build complete: $(BUILD_DIR)/$(BINARY_NAME)"

# Build for production with optimizations
.PHONY: build-prod
build-prod:
	@echo "Building $(BINARY_NAME) for production..."
	@mkdir -p $(BUILD_DIR)
	$(GOBUILD) $(LDFLAGS) -ldflags "-s -w" -o $(BUILD_DIR)/$(BINARY_NAME) $(MAIN_PACKAGE)
	@echo "Production build complete: $(BUILD_DIR)/$(BINARY_NAME)"

# Build for Linux
.PHONY: build-linux
build-linux:
	@echo "Building for Linux..."
	@mkdir -p $(BUILD_DIR)
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) $(LDFLAGS) -o $(BUILD_DIR)/$(BINARY_UNIX) $(MAIN_PACKAGE)

# Build for Windows
.PHONY: build-windows
build-windows:
	@echo "Building for Windows..."
	@mkdir -p $(BUILD_DIR)
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 $(GOBUILD) $(LDFLAGS) -o $(BUILD_DIR)/$(BINARY_WINDOWS) $(MAIN_PACKAGE)

# Install the application
.PHONY: install
install: build
	@echo "Installing $(BINARY_NAME)..."
	$(GOCMD) install $(LDFLAGS) $(MAIN_PACKAGE)
	@echo "Installation complete"

# Run tests
.PHONY: test
test:
	@echo "Running tests..."
	$(GOTEST) -v ./...

# Run tests with coverage
.PHONY: test-coverage
test-coverage:
	@echo "Running tests with coverage..."
	$(GOTEST) -v -coverprofile=coverage.out ./...
	$(GOCMD) tool cover -html=coverage.out -o coverage.html
	@echo "Coverage report generated: coverage.html"

# Clean build artifacts
.PHONY: clean
clean:
	@echo "Cleaning..."
	$(GOCLEAN)
	rm -rf $(BUILD_DIR)
	rm -f coverage.out
	rm -f coverage.html
	@echo "Clean complete"

# Format code
.PHONY: fmt
fmt:
	@echo "Formatting code..."
	$(GOFMT) ./...

# Run go vet
.PHONY: vet
vet:
	@echo "Running go vet..."
	$(GOCMD) vet ./...

# Tidy dependencies
.PHONY: tidy
tidy:
	@echo "Tidying dependencies..."
	$(GOMOD) tidy

# Update dependencies
.PHONY: deps-update
deps-update:
	@echo "Updating dependencies..."
	$(GOGET) -u ./...
	$(GOMOD) tidy

# Run the application
.PHONY: run
run: build
	@echo "Running $(BINARY_NAME)..."
	./$(BUILD_DIR)/$(BINARY_NAME)

# Run with version flag
.PHONY: run-version
run-version: build
	@echo "Running $(BINARY_NAME) version..."
	./$(BUILD_DIR)/$(BINARY_NAME) version

# Development workflow
.PHONY: dev
dev: clean fmt vet build run

# Show build information
.PHONY: info
info:
	@echo "Build Information:"
	@echo "  Version: $(VERSION)"
	@echo "  Build Date: $(BUILD_DATE)"
	@echo "  Git Commit: $(GIT_COMMIT)"
	@echo "  Binary Name: $(BINARY_NAME)"
	@echo "  Build Directory: $(BUILD_DIR)"
	@echo "  Main Package: $(MAIN_PACKAGE)"

# Show help
.PHONY: help
help:
	@echo "GetAKey Makefile - Available targets:"
	@echo ""
	@echo "  all           - Run clean, fmt, vet, test, and build"
	@echo "  build         - Build the application with version injection"
	@echo "  build-prod    - Build optimized production binary"
	@echo "  build-linux   - Cross-compile for Linux"
	@echo "  build-windows - Cross-compile for Windows"
	@echo "  install       - Install the application"
	@echo "  test          - Run tests"
	@echo "  test-coverage - Run tests with coverage report"
	@echo "  clean         - Clean build artifacts"
	@echo "  fmt           - Format code"
	@echo "  vet           - Run go vet"
	@echo "  tidy          - Tidy dependencies"
	@echo "  deps-update   - Update dependencies"
	@echo "  run           - Build and run the application"
	@echo "  run-version   - Build and run with version flag"
	@echo "  dev           - Development workflow (clean, fmt, vet, build, run)"
	@echo "  info          - Show build information"
	@echo "  help          - Show this help message"
	@echo ""
	@echo "Environment variables:"
	@echo "  VERSION     - Override version (default: git describe or 'dev')"
	@echo "  BUILD_DATE  - Override build date (default: current UTC time)"
	@echo "  GIT_COMMIT  - Override git commit (default: git rev-parse or 'unknown')"