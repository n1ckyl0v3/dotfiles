function Write-Start {
	param ($msg)
	Write-Host (">> "+$msg) -ForegroundColor Green
}

function Write-Done {
	Write-Host "DONE" -ForegroundColor BLUE; Write-Host
}

#-----------------------------------------------------
Start-Process -Wait powershell -verb runas -ArgumentList "Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0"

Write-Start -msg "Installing Scoop..."
if(Get-Command scoop -errorAction SilentlyContinue)
{
	Write-Warning "Scoop already installed"
} else {
	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	$env:SCOOP='D:\Downloads\Scoop'
	$env:SCOOP_GLOBAL='D:\Downloads\GlobalScoopApps'
	[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')
	irm get.scoop.sh | iex
}
Write-Done

#---------------------------------------------------
Write-Start -msg "Initializing Scoop..."
	scoop install git
	scoop bucket add extras
	scoop bucket add nerd-fonts
	scoop bucket add java
	scoop update
Write-Done

Write-Start -msg "Installing Scoop's packages"
	scoop install ripgrep zig cmake make which mingw llvm clangd unzip extras/winrar curl 
	scoop install vscode nvm openjdk python postman neovim dotnet-sdk
	scoop install extras/terminal-icons
	scoop install nerd-fonts/JetBrainsMono-NF docker
	#Start-Process -Wait powershell -verb runas -ArgumentList "scoop install nerd-fonts/JetBrains-Mono docker"
Write-Done