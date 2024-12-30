#!/bin/bash

# Exit on error
set -e

# Get current date in the required format
CURRENT_DATE=$(date '+%m/%d/%Y, %I:%M:%S %p')
CURRENT_TZ=$(date '+%Z')

echo "Starting Nova Mini update process..."

# Create icons directory if it doesn't exist
echo "Creating icons directory..."
mkdir -p assets/icons

# Copy icons from assets-nova-mini with verbose output
echo "Copying icons from assets-nova-mini..."
cp -v /data/ax/DevOps/assets-nova-mini/icon.png assets/icons/
cp -v /data/ax/DevOps/assets-nova-mini/icon-128.png assets/icons/
cp -v /data/ax/DevOps/assets-nova-mini/icon-256.png assets/icons/
cp -v /data/ax/DevOps/assets-nova-mini/icon-512.png assets/icons/

echo "Updating package.json..."

# Create a temporary file for processing
cp package.json package.json.tmp

# First update all identifiers
sed -i \
    -e 's/"name": "roo-cline"/"name": "nova-mini"/g' \
    -e 's/"displayName": "Roo Cline"/"displayName": "Nova Mini"/g' \
    -e 's/"publisher": "[^"]*"/"publisher": "ADAPT"/g' \
    -e 's/"version": "[^"]*"/"version": "0.0.3"/g' \
    -e 's/"title": "Roo Cline"/"title": "Nova Mini"/g' \
    -e 's/"category": "Roo Cline"/"category": "Nova Mini"/g' \
    -e 's/"id": "roo-cline-ActivityBar"/"id": "nova-mini-ActivityBar"/g' \
    -e 's/"roo-cline-ActivityBar"/"nova-mini-ActivityBar"/g' \
    -e 's/"roo-cline\.SidebarProvider"/"nova-mini.SidebarProvider"/g' \
    -e 's/"command": "roo-cline\./"command": "nova-mini./g' \
    -e 's/"when": "view == roo-cline\./"when": "view == nova-mini./g' \
    -e 's/"title": "RooCline"/"title": "NovaMini"/g' \
    -e 's/"roo-cline\.allowedCommands"/"nova-mini.allowedCommands"/g' \
    -e 's|"url": "https://github.com/RooVetGit/Roo-Cline"|"url": "https://github.com/ADAPT/nova-mini"|g' \
    -e 's|"homepage": "https://github.com/RooVetGit/Roo-Cline"|"homepage": "https://github.com/ADAPT/nova-mini"|g' \
    package.json.tmp

# Update the main extension icon to use icon-512.png
sed -i '/"icon": /s/rocket.png/icon-512.png/' package.json.tmp

# Update the activity bar icon to use icon.png, preserving indentation
sed -i '/activitybar/,/icon/s/"icon": "[^"]*"/"icon": "assets\/icons\/icon.png"/' package.json.tmp

# Move the temporary file back
mv package.json.tmp package.json

echo "Updating source files..."

# Update ClineProvider.ts
sed -i \
    -e 's/public static readonly sideBarId = "roo-cline\.SidebarProvider"/public static readonly sideBarId = "nova-mini.SidebarProvider"/' \
    -e 's/public static readonly tabPanelId = "roo-cline\.TabPanelProvider"/public static readonly tabPanelId = "nova-mini.TabPanelProvider"/' \
    -e "s/getConfiguration('roo-cline')/getConfiguration('nova-mini')/" \
    -e 's/mcpSettings: "cline_mcp_settings.json"/mcpSettings: "nova_mini_mcp_settings.json"/' \
    -e 's/<title>Cline<\/title>/<title>Nova Mini<\/title>/' \
    -e 's/Documents", "Cline", "MCP"/Documents", "Nova Mini", "MCP"/' \
    -e 's/"~\/Documents\/Cline\/MCP"/"~\/Documents\/Nova Mini\/MCP"/' \
    src/core/webview/ClineProvider.ts

# Update extension.ts
sed -i \
    -e 's/vscode\.commands\.registerCommand("roo-cline\./vscode.commands.registerCommand("nova-mini./g' \
    -e "s/getConfiguration('roo-cline')/getConfiguration('nova-mini')/" \
    -e 's/createOutputChannel("Cline")/createOutputChannel("Nova Mini")/' \
    -e 's/panel\.iconPath = {/panel.iconPath = {/' \
    -e 's/light: vscode\.Uri\.joinPath(context\.extensionUri, "assets", "icons", "rocket\.png")/light: vscode.Uri.joinPath(context.extensionUri, "assets", "icons", "icon-512.png")/' \
    -e 's/dark: vscode\.Uri\.joinPath(context\.extensionUri, "assets", "icons", "rocket\.png")/dark: vscode.Uri.joinPath(context.extensionUri, "assets", "icons", "icon-512.png")/' \
    -e 's/createWebviewPanel(ClineProvider\.tabPanelId, "Cline"/createWebviewPanel(ClineProvider.tabPanelId, "Nova Mini"/' \
    -e 's/appendLine("Cline extension activated")/appendLine("Nova Mini extension activated")/' \
    -e 's/appendLine("Cline extension deactivated")/appendLine("Nova Mini extension deactivated")/' \
    src/extension.ts

echo "Nova Mini update completed!"
echo "Icons copied and files updated."

# List the updated icons
echo -e "\nVerifying icon files:"
ls -l assets/icons/