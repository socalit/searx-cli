#!/bin/bash

set -e

REPO_URL="https://github.com/socalit/searx-cli"
INSTALL_PATH="/usr/local/bin/searx"
TMP_DIR="/tmp/searx-cli"
PY_SCRIPT="searx.py"

echo "Installing searx-cli from GitHub: $REPO_URL"

# Ensure root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (try 'sudo ./install-searx-cli.sh')"
  exit 1
fi

# --- Check for Python 3 ---
if ! command -v python3 &> /dev/null; then
  echo "python3 not found. Please install Python 3 first."
  exit 1
fi

# --- Ensure pip is installed ---
if ! python3 -m pip --version &> /dev/null; then
  echo "pip is missing. Attempting to install..."

  if command -v apt &> /dev/null; then
    apt update
    apt install -y python3-pip
  elif command -v brew &> /dev/null; then
    brew install python
  else
    echo "Could not install pip automatically. Install manually and rerun."
    exit 1
  fi
fi

# --- Install dependencies with system override ---
echo "Installing Python dependencies with --break-system-packages"
python3 -m pip install --quiet --break-system-packages requests beautifulsoup4

# --- Clone repo ---
echo "Cloning searx-cli..."
rm -rf "$TMP_DIR"
git clone "$REPO_URL" "$TMP_DIR"

# --- Add shebang if missing ---
if ! head -n 1 "$TMP_DIR/$PY_SCRIPT" | grep -q "#!/usr/bin/env python3"; then
  echo "Adding shebang to $PY_SCRIPT"
  sed -i '1s|^|#!/usr/bin/env python3\n|' "$TMP_DIR/$PY_SCRIPT"
fi

# --- Install CLI to /usr/local/bin ---
cp "$TMP_DIR/$PY_SCRIPT" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo "searx CLI installed to: $INSTALL_PATH"
echo ""
echo "Try it now:"
echo "   searx \"firewall comparison\" --engine https://your-searx-instance.net"
