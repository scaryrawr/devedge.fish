# devedge.fish

A vibe coded [Fish shell](https://fishshell.com/) plugin for launching Microsoft Edge with profile and flavor selection on macOS with/without debugging enabled.

## Reason

Makes it easier to launch edge for use with [chrome devtools mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp/). You can launch an edge flavor with `--debug` to enable remote debugging that the mcp can connect to. Add the MCP server to your user mcp:

```jsonc
"chrome-devtools": {
  "command": "npx",
  "args": [
    "chrome-devtools-mcp@latest",
    // Make sure the port here matches what you specified, 9222 is default
    "--browser-url=http://127.0.0.1:9222"
  ]
}
```

I heavily recommend having multiple browsers installed (either multiple edge flavors, or edge + something else). Your default browser can be used for debugging, but it's a lot nicer to let the MCP server leverage a different browser (on macOS, you have to quit out of the browser to launch it in debug mode).

## Installation

### Using [Fisher](https://github.com/jorgebucaran/fisher) (recommended)

```fish
fisher install scaryrawr/devedge.fish
```

## Dependencies

This plugin requires the following tools to be installed:

| Dependency                | Purpose                               | Install                                                                                                                                  |
| ------------------------- | ------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| [jq](https://jqlang.org/) | JSON parsing for profile data         | `brew install jq`                                                                                                                        |
| Microsoft Edge            | The browser itself                    | [Download](https://www.microsoft.com/edge)                                                                                               |
| Microsoft Edge Insiders   | Insider builds for additional flavors | [Download](https://www.microsoft.com/en-us/edge/download/insider?cc=1&msockid=22c470265808696d344366595984681f&cs=309244556&form=MA13FJ) |

## Usage

### Basic Usage

```fish
# Launch Microsoft Edge (stable)
edge

# Open a URL
edge https://github.com
```

### Selecting a Flavor

```fish
# Launch Edge Canary
edge --flavor 'Microsoft Edge Canary'

# Launch Edge Stable
edge
```

### Selecting a Profile

```fish
# Launch with a specific profile (by email)
edge --profile user@example.com

# Combine flavor and profile
edge --flavor 'Microsoft Edge Canary' --profile work@company.com
```

### Remote Debugging

```fish
# Enable remote debugging on default port (9222)
edge --debug

# Enable remote debugging on a custom port
edge --debug 9229
```

### Combining Options

```fish
edge --flavor 'Microsoft Edge Canary' --profile dev@example.com --debug
```

## Tab Completions

The plugin provides intelligent tab completions:

- `--flavor` — completes with installed Edge flavors
- `--profile` — completes with profile emails (filtered by selected flavor)
- `--debug` — enables remote debugging

## Platform Support

Currently, this plugin only supports **macOS**.

## License

MIT
