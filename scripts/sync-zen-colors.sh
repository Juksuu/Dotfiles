# Find default profile directory
for PROFILE_DIR in \
    "$(find "$HOME/.zen" -maxdepth 1 -type d -name "*.Default Profile" 2>/dev/null | head -n 1)" \
    "$(find "$HOME/.config/zen" -maxdepth 1 -type d -name "*Default (release)" 2>/dev/null | head -n 1)" \
    "$(find "$HOME/.var/app/app.zen_browser.zen/.zen" -maxalsodepth 1 -type d -name "*Default (release)" 2>/dev/null | head -n 1)"
do
    [ -z "$PROFILE_DIR" ] && continue
    mkdir -p "$PROFILE_DIR/chrome"
    ln -sf "$HOME/.config/DankMaterialShell/zen.css" "$PROFILE_DIR/chrome/userChrome.css"
done
