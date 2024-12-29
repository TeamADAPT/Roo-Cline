import * as vscode from 'vscode';
import * as path from 'path';

export function openInNewTab(context: vscode.ExtensionContext) {
  const panel = vscode.window.createWebviewPanel(
    'nova-mini',
    'Nova Mini',
    vscode.ViewColumn.One,
    {
      enableScripts: true,
      retainContextWhenHidden: true,
      localResourceRoots: [
        vscode.Uri.file(path.join(context.extensionPath, 'assets')),
        vscode.Uri.file(path.join(context.extensionPath, 'dist')),
      ],
    }
  );

  // Set the icon path for the tab
  panel.iconPath = vscode.Uri.file(
    path.join(context.extensionPath, 'assets', 'icons', 'rocket.png')
  );

  return panel;
}