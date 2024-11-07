# Hardcoded folder path for projects
$folderPath = "C:\Users\Godwin\Desktop\ReactProjects"

# Load necessary .NET assembly for GUI popup
Add-Type -AssemblyName Microsoft.VisualBasic

# Show an input box to get the app name from the user
$appName = [Microsoft.VisualBasic.Interaction]::InputBox("Enter the name for your new React app:", "React App Name", "")

# Check if the user provided an app name
if ([string]::IsNullOrWhiteSpace($appName)) {
    Write-Host "App name cannot be empty. Exiting script." -ForegroundColor Red
    Pause
    exit
}

# Combine hardcoded folder path and app name
$fullPath = Join-Path -Path $folderPath -ChildPath $appName

# Run the create-react-app command with the full path
Write-Host "Creating React app named '$appName' in '$folderPath'..."
npx create-react-app $fullPath

# Check if the app creation was successful
if ($LASTEXITCODE -eq 0) {
    Write-Host "React app '$appName' created successfully in '$folderPath'." -ForegroundColor Green
    Pause

    # Change to the new app directory
    Set-Location -Path $fullPath

    # Install additional dependencies
    Write-Host "Installing additional dependencies..."
    npm install react-router-dom axios

    if ($LASTEXITCODE -eq 0) {
        Write-Host "All dependencies installed successfully." -ForegroundColor Green
        Write-Host "Your React app '$appName' is ready!" -ForegroundColor Green
    } else {
        Write-Host "Failed to install additional dependencies. Please check for errors above." -ForegroundColor Red
        Pause
    }

    # Check if Visual Studio Code is installed and open the project folder
    if (Get-Command code -ErrorAction SilentlyContinue) {
        Write-Host "Opening project in Visual Studio Code..."
        Start-Process code $fullPath
    } else {
        Write-Host "Visual Studio Code is not installed or 'code' command is not available in PATH." -ForegroundColor Yellow
        Pause
    }
} else {
    Write-Host "Failed to create React app. Please check for errors above." -ForegroundColor Red
    Pause
}
