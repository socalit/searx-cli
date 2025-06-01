#!/bin/bash

set -e

REPO_URL="https://github.com/socalit/searx-cli"
INSTALL_PATH="/usr/local/bin/searx"
TMP_DIR="/tmp/searx-cli"
PY_SCRIPT="searx.py"

echo "Installing searx-cli from GitHub: $REPO_URL"

# Ensure root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (try 'sudo ./install-searx-cli.sh')"
  exit 1
fi

# Install pip modules
echo "Installing dependencies: requests, beautifulsoup4"
python3 -m pip install --quiet requests beautifulsoup4

# Clone repo
echo "Cloning searx-cli..."
rm -rf "$TMP_DIR"
git clone "$REPO_URL" "$TMP_DIR"

# Add shebang if missing
if ! head -n 1 "$TMP_DIR/$PY_SCRIPT" | grep -q "#!/usr/bin/env python3"; then
  echo "Adding shebang..."
  sed -i '1s/^/#!\\/usr\\/bin\\/env python3\\n/' "$TMP_DIR/$PY_SCRIPT"
fi

# Install to /usr/local/bin
cp "$TMP_DIR/$PY_SCRIPT" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo "Installed searx CLI to: $INSTALL_PATH"
echo ""
echo "Test it with:"
echo "   searx "ruckus vs unifi" --engine https://your-searx-instance.net"