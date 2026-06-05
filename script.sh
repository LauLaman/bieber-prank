#!/usr/bin/env bash

set -e

IMAGES=(
  "https://your-domain.com/images/1.jpg"
  "https://your-domain.com/images/2.jpg"
  "https://your-domain.com/images/3.jpg"
)

IMAGE=${IMAGES[$RANDOM % ${#IMAGES[@]}]}

case "$(uname -s)" in
    Darwin*)
        TMPFILE="/tmp/prank-wallpaper.jpg"

        curl -fsSL "$IMAGE" -o "$TMPFILE"

        osascript <<EOF
tell application "System Events"
    tell every desktop
        set picture to "$TMPFILE"
    end tell
end tell
EOF
        ;;

    Linux*)
        TMPFILE="/tmp/prank-wallpaper.jpg"

        curl -fsSL "$IMAGE" -o "$TMPFILE"

        if command -v gsettings >/dev/null 2>&1; then
            gsettings set org.gnome.desktop.background picture-uri "file://$TMPFILE"
        elif command -v xfconf-query >/dev/null 2>&1; then
            xfconf-query \
              -c xfce4-desktop \
              -p /backdrop/screen0/monitor0/image-path \
              -s "$TMPFILE"
        else
            echo "Unsupported Linux desktop environment."
        fi
        ;;

    MINGW*|MSYS*|CYGWIN*)
        TMPFILE="$TEMP\\prank-wallpaper.jpg"

        powershell -NoProfile -Command "
            Invoke-WebRequest '$IMAGE' -OutFile '$TMPFILE'
            Add-Type @'
using System.Runtime.InteropServices;
public class Wallpaper {
  [DllImport(\"user32.dll\", SetLastError=true)]
  public static extern bool SystemParametersInfo(
      int uAction, int uParam, string lpvParam, int fuWinIni);
}
'@
            [Wallpaper]::SystemParametersInfo(20,0,'$TMPFILE',3)
        "
        ;;

    *)
        echo "Unsupported OS"
        exit 1
        ;;
esac

echo "Wallpaper changed!"