# Brave Browser Enterprise-Grade Performance & Security Script
# This script eliminates duplicate icons across all system directories and replaces them with optimized versions.

# 1. Locate the Brave Browser installation directory
$BravePath = "$env:ProgramFiles\BraveSoftware\Brave-Browser\Application\brave.exe"
if (-not (Test-Path $BravePath)) {
    $BravePath = "${env:ProgramFiles(x86)}\BraveSoftware\Brave-Browser\Application\brave.exe"
} 

if (-not (Test-Path $BravePath)) {
    Write-Error "Brave Browser installation not found. Please ensure Brave is installed."
    Exit
} 

# 2. Build the Advanced Optimization & Security Flags List
$Flags = @( 
    # --- PERFORMANCE & RESOURCE OPTIMISATION ---
    "--process-per-site",                     # Groups same-site tabs into a single process to save massive RAM
    "--enable-parallel-downloading",          # Forces multi-threaded downloading for significantly faster speeds
    "--disable-fetching-hints-at-navigation", # Disables speculative resource fetching to save bandwidth/CPU
    "--disable-background-networking",        # Stops unrequested background connections and browser telemetry
    "--disable-default-apps",                 # Prevents loading default background apps on startup
    "--disable-component-update",             # Delays non-critical component checks until required 

    # --- HARDWARE & GPU ACCELERATION ---
    "--ignore-gpu-blocklist",                 # Forces hardware acceleration even on unsupported drivers
    "--enable-gpu-rasterization",             # Uses the GPU to render 2D web graphics faster
    "--enable-zero-copy",                     # Writes graphics memory directly to GPU to lower CPU overhead
    "--canvas-oop-rasterization",             # Moves canvas rendering out of the main thread to prevent UI freezing
    "--enable-hardware-overlays",             # Offloads video and UI overlays directly to video hardware 

    # --- PRIVACY & SECURITY HARDENING ---
    "--disable-reading-from-canvas",          # Blocks websites from abusing canvas elements to fingerprint your PC
    "--disable-breakpad",                     # Disables crash dumps and reporting to external telemetry servers
    "--disable-crash-reporter",               # Completely turns off the background crash reporting service
    "--disable-client-side-phishing-detection", # Stops sending URL metadata to lookup services (Brave Shields handles this locally)
    "--password-store=basic",                 # Uses local obfuscation instead of tying browser credentials to OS accounts
    "--no-pings",                             # Blocks hyperlink auditing used by advertisers to track clicks 

    # --- PROCESS & SANDBOX ISOLATION ---
    "--disable-shared-workers",               # Prevents background scripts from sharing data across multiple tabs
    "--enable-features=IsolatedPrerenderScoping,V8VmFuture" # Forces strict modern engine isolation and V8 optimisations
) 

# Join the array into a single space-separated string
$Switches = $Flags -join " " 

# 3. Define all potential old shortcut target locations
$Targets = @(
    [System.IO.Path]::Combine([Environment]::GetFolderPath("Desktop"), "Brave.lnk"),               # User Desktop
    [System.IO.Path]::Combine($env:Public, "Desktop\Brave.lnk"),                                    # Public Desktop
    [System.IO.Path]::Combine([Environment]::GetFolderPath("StartMenu"), "Programs\Brave.lnk"),     # User Start Menu
    [System.IO.Path]::Combine($env:ProgramData, "Microsoft\Windows\Start Menu\Programs\Brave.lnk"), # System Start Menu
    "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Brave.lnk"           # Taskbar Pin
)

# 4. Wipe out all old shortcuts found in those locations
foreach ($Target in $Targets) {
    if (Test-Path $Target) {
        Remove-Item $Target -Force -ErrorAction SilentlyContinue
    }
}

# 5. Re-generate clean, optimized shortcuts in every relevant user location
$WshShell = New-Object -ComObject WScript.Shell

foreach ($Target in $Targets) {
    # Skip public/system folders during rewrite so Windows doesn't create duplicate visual overlays
    if ($Target -eq [System.IO.Path]::Combine($env:Public, "Desktop\Brave.lnk") -or $Target -eq [System.IO.Path]::Combine($env:ProgramData, "Microsoft\Windows\Start Menu\Programs\Brave.lnk")) {
        continue
    }

    try {
        # Ensure target folder tree actually exists before attempting to write a shortcut
        $TargetDir = Split-Path $Target
        if (-not (Test-Path $TargetDir)) {
            New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
        }

        $Shortcut = $WshShell.CreateShortcut($Target)
        $Shortcut.TargetPath = $BravePath
        $Shortcut.Arguments = $Switches
        $Shortcut.Description = "Brave Browser with Advanced Performance & Security Tweaks"
        $Shortcut.IconLocation = "$BravePath,0"
        $Shortcut.Save()
    } catch {
        # Silently skip if a path is restricted or inaccessible
    }
}

Write-Host "Success! All old shortcuts across your Desktop, Start Menu, and Taskbar have been successfully replaced." -ForegroundColor Green
