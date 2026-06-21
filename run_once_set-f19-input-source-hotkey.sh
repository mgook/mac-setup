#!/bin/bash
set -e
PLIST="$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"

if [ ! -f "$PLIST" ]; then
  cat > "$PLIST" <<'PLISTEOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict/>
</plist>
PLISTEOF
fi

/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys dict" "$PLIST" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:61" "$PLIST" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61 dict" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:enabled bool true" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value dict" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value:type string standard" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value:parameters array" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value:parameters:0 integer 65535" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value:parameters:1 integer 80" "$PLIST"
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value:parameters:2 integer 8388608" "$PLIST"

killall cfprefsd 2>/dev/null || true
echo "F19 -> 입력 소스 전환 단축키 설정 완료 (재로그인 후 적용됨)"
