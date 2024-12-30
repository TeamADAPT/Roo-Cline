# Nova Mini RMQ Project Details

## Technical Implementation Details

### Base Extension Setup
1. Initial Fork Process
   ```bash
   # Clone original repository
   git clone https://github.com/RooVetGit/Roo-Cline nova-mini
   cd nova-mini
   
   # Remove original git history and initialize new repo
   rm -rf .git
   git init
   git add .
   git commit -m "feat: Initial import of working Roo Cline base"
   git remote add origin https://github.com/TeamADAPT/nova-mini.git
   ```

2. Identifier Changes
   - Updated package.json:
     - name: "nova-mini"
     - displayName: "Nova Mini"
     - publisher: "ADAPT"
     - version: "0.0.3"
     - repository/homepage URLs
   
   - Updated source files:
     - Command registrations in extension.ts
     - Storage paths in ClineProvider.ts
     - Configuration namespaces
     - MCP settings file paths

3. Icon Implementation
   - Location: assets/icons/
   - Files:
     - icon.png: Monochrome version for activity bar
     - icon-512.png: Colored version for extension manager
     - icon-128.png and icon-256.png: Additional resolutions
   - Usage:
     ```json
     {
       "icon": "assets/icons/icon-512.png",
       "viewsContainers": {
         "activitybar": [{
           "icon": "assets/icons/icon.png"
         }]
       }
     }
     ```

### Storage Path Changes
1. VSCode Global Storage:
   ```typescript
   // Previous
   "~/.vscode-server/data/User/globalStorage/rooveterinaryinc.roo-cline/"
   
   // New
   "~/.vscode-server/data/User/globalStorage/adapt.nova-mini/"
   ```

2. MCP Settings:
   ```typescript
   // Previous
   mcpSettings: "cline_mcp_settings.json"
   
   // New
   mcpSettings: "nova_mini_mcp_settings.json"
   ```

3. Document Paths:
   ```typescript
   // Previous
   "~/Documents/Cline/MCP"
   
   // New
   "~/Documents/Nova Mini/MCP"
   ```

## Integration Points

### VSCode Integration
1. Command Registration:
   ```typescript
   vscode.commands.registerCommand("nova-mini.plusButtonClicked", ...)
   vscode.commands.registerCommand("nova-mini.mcpButtonClicked", ...)
   vscode.commands.registerCommand("nova-mini.historyButtonClicked", ...)
   vscode.commands.registerCommand("nova-mini.popoutButtonClicked", ...)
   vscode.commands.registerCommand("nova-mini.settingsButtonClicked", ...)
   ```

2. Webview Provider:
   ```typescript
   vscode.window.registerWebviewViewProvider(
     "nova-mini.SidebarProvider",
     sidebarProvider,
     { webviewOptions: { retainContextWhenHidden: true } }
   )
   ```

### MCP Integration
1. Settings File:
   - Location: ~/.vscode-server/data/User/globalStorage/adapt.nova-mini/settings/nova_mini_mcp_settings.json
   - Purpose: Configure MCP servers and their settings

2. MCP Servers Directory:
   - Location: ~/Documents/Nova Mini/MCP
   - Purpose: Store MCP server implementations

## Build Process
1. Clean Installation:
   ```bash
   rm -rf node_modules webview-ui/node_modules webview-ui/build .vscode-test dist bin
   npm run install:all
   ```

2. Build Extension:
   ```bash
   npm run build
   ```

3. Build Output:
   - Location: bin/nova-mini-0.0.3.vsix
   - Size: ~23.94 MB
   - Files: 90 files including:
     - Extension source
     - Webview UI
     - Assets and icons
     - Documentation

## Testing
1. Side-by-Side Operation:
   - Verified Nova Mini runs alongside original Cline
   - Separate storage paths prevent conflicts
   - Independent state management

2. Build Verification:
   - Clean build successful
   - No TypeScript errors (minor version warning only)
   - All linting passes

## Migration Guide
1. For Extension Users:
   - Install Nova Mini alongside existing Cline
   - No migration needed - fresh start by design
   - Can run both extensions simultaneously

2. For Developers:
   - Clone from https://github.com/TeamADAPT/nova-mini
   - Run update-nova-mini.sh for any identifier updates
   - Follow standard build process

## API Documentation
1. Extension API:
   - Maintains compatibility with Cline API
   - New namespace: 'nova-mini'
   - Configuration accessed via:
     ```typescript
     vscode.workspace.getConfiguration('nova-mini')
     ```

2. MCP API (Planned):
   - RabbitMQ integration
   - Agent communication protocols
   - Message format specifications

## Current Status
- Base extension working ✓
- Side-by-side operation verified ✓
- Build process stable ✓
- Ready for RabbitMQ integration

## Next Development Steps
1. RabbitMQ MCP Server:
   - Create server implementation
   - Define message protocols
   - Implement agent communication
   - Add monitoring capabilities

2. Testing Framework:
   - Add RabbitMQ integration tests
   - Message flow validation
   - Agent communication verification