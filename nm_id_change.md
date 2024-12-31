# Nova Mini Installation Changes

Last Updated: 12/29/2024, 03:14:03 PM (MST)

## Script Information

- Script Name: update-nova-mini.sh
- Location: Must be run from the extension root directory (/data/ax/DevOps/Roo-Cline)
- Purpose: Updates extension identifiers and icons for Nova Mini

## Package.json Changes

### Basic Extension Info
```json
{
  "name": "nova-mini",
  "displayName": "Nova Mini",
  "publisher": "ADAPT",
  "version": "0.0.3",
  "icon": "assets/icons/icon-512.png"  // Extension icon (colored, high-res version)
}
```

### Repository URLs
```json
{
  "repository": {
    "type": "git",
    "url": "https://github.com/ADAPT/nova-mini"
  },
  "homepage": "https://github.com/ADAPT/nova-mini"
}
```

### Command IDs
All command prefixes have been changed from `roo-cline` to `nova-mini`:
```json
"commands": [
  {"command": "nova-mini.plusButtonClicked"},
  {"command": "nova-mini.mcpButtonClicked"},
  {"command": "nova-mini.historyButtonClicked"},
  {"command": "nova-mini.popoutButtonClicked"},
  {"command": "nova-mini.settingsButtonClicked"},
  {"command": "nova-mini.openInNewTab"}
]
```

### View Container/Provider IDs
```json
"viewsContainers": {
  "activitybar": [{
    "id": "nova-mini-ActivityBar",
    "title": "Nova Mini",
    "icon": "assets/icons/icon.png"  // Activity bar icon (monochrome version)
  }]
},
"views": {
  "nova-mini-ActivityBar": [{
    "id": "nova-mini.SidebarProvider",
    "name": ""
  }]
}
```

### Configuration Namespace
```json
"configuration": {
  "title": "NovaMini",
  "properties": {
    "nova-mini.allowedCommands": {
      // ... configuration properties
    }
  }
}
```

## Source File Changes

1. ClineProvider.ts:
   - Updated sideBarId from "roo-cline.SidebarProvider" to "nova-mini.SidebarProvider"
   - Updated tabPanelId from "roo-cline.TabPanelProvider" to "nova-mini.TabPanelProvider"
   - Updated configuration namespace from 'roo-cline' to 'nova-mini'
   - Updated MCP settings filename from 'cline_mcp_settings.json' to 'nova_mini_mcp_settings.json'
   - Updated HTML title from "Cline" to "Nova Mini"
   - Updated MCP directory path from "Documents/Cline/MCP" to "Documents/Nova Mini/MCP"

2. extension.ts:
   - Updated all command registrations from "roo-cline." to "nova-mini."
   - Updated configuration namespace from 'roo-cline' to 'nova-mini'
   - Updated output channel name from "Cline" to "Nova Mini"
   - Updated panel icon to use icon-512.png instead of rocket.png
   - Updated panel title from "Cline" to "Nova Mini"
   - Updated extension activation/deactivation messages

## Storage Location Changes

The extension's data (history, settings, etc.) will be stored in VSCode's global storage:

1. Linux:
   ```
   ~/.vscode-server/data/User/globalStorage/adapt.nova-mini/
   ```

2. macOS:
   ```
   ~/Library/Application Support/Code/User/globalStorage/adapt.nova-mini/
   ```

3. Windows:
   ```
   %APPDATA%\Code\User\globalStorage\adapt.nova-mini   ```

Note: This is different from the original Roo Cline storage location (rooveterinaryinc.roo-cline). History and settings will start fresh in the new location.

## Icon Changes

The following icons have been updated from /data/ax/DevOps/assets-nova-mini:
- icon.png (monochrome version for activity bar)
- icon-512.png (colored version for extension manager)
- icon-128.png and icon-256.png (additional resolutions)

Location: assets/icons/

### Icon Usage in VSCode

Two different icons are used:

1. Extension Icon (icon-512.png):
   ```json
   {
     "icon": "assets/icons/icon-512.png"  // Root level of package.json
   }
   ```
   - Uses the colored, high-resolution version
   - Appears when viewing/managing extensions
   - Should be visually appealing with color

2. Activity Bar Icon (icon.png):
   ```json
   "viewsContainers": {
     "activitybar": [{
       "icon": "assets/icons/icon.png"  // Inside viewsContainers section
     }]
   }
   ```
   - Uses the monochrome version
   - Appears in VSCode's left sidebar
   - Should match VSCode's monochrome icon style

### Icon Requirements

1. Extension Icon (icon-512.png):
   - Should be the colored version
   - Used in extension manager/marketplace
   - Minimum size 512x512 pixels
   - PNG format with transparency support
   - Should look good on both light and dark themes

2. Activity Bar Icon (icon.png):
   - Should be monochrome
   - Will be displayed at around 24x24 pixels
   - Should match VSCode's icon style
   - PNG format with transparency

## Build Instructions

1. First Time Setup:
   - Navigate to extension root: `cd /data/ax/DevOps/Roo-Cline`
   - Make script executable: `chmod +x update-nova-mini.sh`
   - Run script: `./update-nova-mini.sh`
   - Install dependencies: `npm run install:all`
   - Build extension: `npm run build`

2. Subsequent Updates:
   - Run script: `./update-nova-mini.sh`
   - Build extension: `npm run build`
   - Note: `npm run install:all` is only needed on first run or when dependencies change

## Notes

1. Icon References:
   - Extension icon uses colored icon-512.png
   - Activity bar uses monochrome icon.png
   - Command icons use VSCode codicons (, , etc.)

2. Data Migration:
   - History and settings will start fresh in the new storage location
   - If needed, data can be manually copied from the old location to the new one
   - Old data location: `globalStorage/rooveterinaryinc.roo-cline/`
   - New data location: `globalStorage/adapt.nova-mini/`
