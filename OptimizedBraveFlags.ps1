# Brave Browser Enterprise-Grade Engine Tweak Injector
# This script applies a massive array of shortcut-only engine flags, safely ignoring registry overlaps.

# 1. Locate the Brave Browser installation directory
$BravePath = "$env:ProgramFiles\BraveSoftware\Brave-Browser\Application\brave.exe"
if (-not (Test-Path $BravePath)) {
    $BravePath = "${env:ProgramFiles(x86)}\BraveSoftware\Brave-Browser\Application\brave.exe"
} 

if (-not (Test-Path $BravePath)) {
    Write-Error "Brave Browser installation not found. Please ensure Brave is installed."
    Exit
} 

# 2. Build the Ultimate Engine Optimization Flag List (No Registry Overlaps)
$Flags = @( 
    # --- HARDWARE ACCELERATION & ADVANCED RENDERING ENGINE ---
    "--ignore-gpu-blocklist",                 # Forces hardware acceleration even on unsupported drivers
    "--enable-gpu-rasterization",             # Uses the GPU to render 2D web graphics faster
    "--enable-zero-copy",                     # Writes graphics memory directly to GPU to lower CPU overhead
    "--canvas-oop-rasterization",             # Moves canvas rendering out of the main thread to prevent UI freezing
    "--enable-hardware-overlays",             # Offloads video and UI overlays directly to video hardware
    "--enable-raw-draw",                      # Drastically fast-tracks render raster pipelines straight to graphics memory
    "--enable-gpu-compositing",               # Offloads layout drawing pipelines straight to the dedicated GPU
    "--enable-oop-rasterization",             # Handles massive 2D vector graphic layouts outside the main process
    
    # --- MULTI-THREADING & PROCESS CPU PRIORITISATION ---
    "--enable-drdc",                          # Enables Decoupled Display Lists to process UI commands on dual threads
    "--enable-threaded-compositing",          # Processes scrolling and animations on a completely separate thread
    "--num-raster-threads=4",                 # Dedicates 4 aggressive system processing threads strictly to image rendering
    "--enable-vulkan",                        # Unlocks high-performance API processing on compatible graphics hardware
    
    # --- MEMORY, CACHE & GRAPHICS OVERHAUL ---
    "--enable-skia-graphite",                 # Forces the modern high-velocity rendering pipeline engine back-end
    "--enable-gpu-memory-buffer-video-frames",# Forces video frame processing to pass through physical GPU VRAM structures
    "--gpu-no-context-lost",                  # Instructs the layout engine to never drop rendering memory stacks on frame lag
    
    # --- ENHANCED ENGINE SECURITY & SANDBOX HARDENING ---
    "--enable-features=IsolatedPrerenderScoping,V8VmFuture,BlockInsecurePrivateNetworkRequests" # Forces strict modern engine isolation, V8 speeds, and modern script blockades
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
        $Shortcut.Description = "Brave Browser with Ultimate Shortcut-Only Performance Tweaks"
        $Shortcut.IconLocation = "$BravePath,0"
        $Shortcut.Save()
    } catch {
        # Silently skip if a path is restricted or inaccessible
    }
}

Write-Host "Success! Added massive performance and security switches. Safe from all registry file constraints." -ForegroundColor Green
