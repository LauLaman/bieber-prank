# Bieber Prank

A cross-platform script that changes your victim's wallpaper to a random Justin Bieber photo.

## Usage

```bash
curl -fsSL https://raw.githubusercontent.com/LauLaman/bieber-prank/main/script.sh | bash
```

or shurt URL version:
```bash
curl -fsSL https://shorturl.at/zHf0N | bash
```

## Supported Platforms

- **macOS** — uses `osascript` to set the desktop wallpaper
- **Linux** — supports GNOME (`gsettings`) and XFCE (`xfconf-query`)
- **Windows** — uses PowerShell and the Windows API via MINGW/MSYS/Cygwin
