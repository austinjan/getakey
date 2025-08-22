package cmd

import (
	"runtime"

	"github.com/pterm/pterm"
	"github.com/spf13/cobra"
)

// versionCmd represents the version command
var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Show version information",
	Long:  `Display version information for GetAKey including build details.`,
	Run: func(cmd *cobra.Command, args []string) {
		showVersionInfo()
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
}

func showVersionInfo() {
	// Create a simple, elegant version display
	pterm.Printf("\n")
	pterm.DefaultHeader.WithTextStyle(pterm.NewStyle(pterm.FgCyan)).Println("🔑 GetAKey Version")
	pterm.Println()

	// Create version information table
	versionData := pterm.TableData{
		{"Property", "Value"},
		{"Version", Version},
		{"Build Date", BuildDate},
		{"Git Commit", GitCommit},
		{"Go Version", runtime.Version()},
		{"Platform", runtime.GOOS + "/" + runtime.GOARCH},
	}

	pterm.DefaultTable.WithHasHeader().WithHeaderRowSeparator("-").WithData(versionData).Render()

	pterm.Println()

	// Show some additional styling
	if Version == "dev" {
		pterm.Warning.Println("This is a development build")
	} else {
		pterm.Success.Printf("GetAKey version %s\n", Version)
	}
}
