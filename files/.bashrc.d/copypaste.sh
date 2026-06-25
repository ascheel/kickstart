if grep -qi microsoft /proc/version 2>/dev/null; then
  alias lcopy='clip.exe'
  alias lpaste='powershell.exe "Get-Clipboard -Raw"'
fi
