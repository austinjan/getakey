package cmd

import (
	"os"

	"github.com/pterm/pterm"
	"github.com/spf13/cobra"
)

var (
	// Version will be set by build flags
	Version = "dev"
	// BuildDate will be set by build flags
	BuildDate = "unknown"
	// GitCommit will be set by build flags
	GitCommit = "unknown"
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "getakey",
	Short: "A key management and retrieval tool",
	Long: `GetAKey is a CLI tool for key management and retrieval operations.
It provides a simple and intuitive interface for working with keys.`,
	Run: func(cmd *cobra.Command, args []string) {
		showBanner()
		showHelp()
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	// Here you will define your flags and configuration settings.
	// Cobra supports persistent flags, which, if defined here,
	// will be global for your application.

	// rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.getakey.yaml)")

	// Cobra also supports local flags, which will only run
	// when this action is called directly.
	rootCmd.Flags().BoolP("version", "v", false, "Show version information")
}

func showBanner() {
	// Simple banner
	pterm.Printf("\n")
	pterm.DefaultBasicText.WithStyle(pterm.NewStyle(pterm.FgCyan, pterm.Bold)).Println("🔑 GetAKey")
	pterm.DefaultBasicText.WithStyle(pterm.NewStyle(pterm.FgGray)).Println("A powerful key management and retrieval tool")
	pterm.Println()
}

func showHelp() {
	// Show styled help information
	pterm.DefaultSection.Println("Available Commands")

	// Create a table for commands
	tableData := pterm.TableData{
		{"Command", "Description"},
		{"help", "Show help information"},
		{"version", "Show version information"},
	}

	pterm.DefaultTable.WithHasHeader().WithData(tableData).Render()

	pterm.Println()
	pterm.DefaultBasicText.WithStyle(pterm.NewStyle(pterm.FgGray)).Println("Use 'getakey <command> --help' for more information about a command.")
}
