# URL for WhatsApp Web
$waURL = "https://web.whatsapp.com/"

# --- LAUNCH COMET BROWSER ---
# 1. Replace the placeholder with the exact path you found for Comet
$cometPath = "C:\Users\s\AppData\Local\Perplexity\Comet\Application\comet.exe"

Start-Process -FilePath $cometPath -ArgumentList $waURL

# Pause to ensure the first window is open
Start-Sleep -Seconds 1

# --- LAUNCH ZEN BROWSER ---
# 2. Replace the placeholder with the exact path you found for Zen
$zenPath = "C:\Program Files\Zen Browser\Zen.exe"

Start-Process -FilePath $zenPath -ArgumentList $waURL