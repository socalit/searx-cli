![searx-cli](docs/banner.png)

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-support-%23FFDD00?logo=buymeacoffee&logoColor=black)](https://buymeacoffee.com/socal370xs)
[![Linux](https://img.shields.io/badge/Linux-Kali%20%7C%20Debian-yellow?logo=linux)](https://www.kali.org/)
[![CLI](https://img.shields.io/badge/Interface-CLI-blue)](#)
[![Search](https://img.shields.io/badge/Search-Meta_Search_Engine-success)](#)
[![Privacy](https://img.shields.io/badge/Privacy-Focused-purple)](#)
[![License](https://img.shields.io/badge/license-MIT-purple)](/LICENSE)


# searx-cli

![searx-cli demo](https://raw.githubusercontent.com/socalit/searx-cli/main/docs/demo1.png)

A fast, no-API terminal search tool for your own [SearXNG](https://searxng.org) instance. Works on Linux, macOS, and Windows.

**This script scrapes HTML from SearXNG** instead of using the JSON API (which is often rate-limited or disabled).  
** IMPORTANT:** Update the `DEFAULT_ENGINE` in `searx.py` to point to your own instance.

---

## Features

-  Search directly from your terminal
-  Clean, readable output (title, link, snippet)
-  Works on public or private SearXNG instances
-  Lightweight: no browser, no API key
-  Works even when JSON API is blocked (scrapes HTML results)

---

## Quick Start
---

## Install it with:
```
curl -s https://raw.githubusercontent.com/socalit/searx-cli/main/install-searx-cli.sh | sudo bash
```
## Clone + run manually:
```
git clone https://github.com/socalit/searx-cli
cd searx-cli
sudo ./install-searx-cli.sh
```
1. Clone this repo:
```
git clone https://github.com/socalit/searx-cli
cd searx-cli
```
(Optional) Edit searx.py and change this line:
DEFAULT_ENGINE = "https://your-searx-instance.net"

Open the installed file:
```bash
sudo nano /usr/local/bin/searx
```
Find this line:
DEFAULT_ENGINE = "https://your-searx-instance.net"
Replace it with your server:

Run a search:
```
python3 searx.py "open source firewall"
```
Or specify the engine dynamically:
```
python3 searx.py "hotel wifi audit" --engine https://your-searx-instance.net
```
---

## Install System-Wide (Linux/macOS)

```bash
chmod +x install-searx-cli.sh
sudo ./install-searx-cli.sh
```
Then use it from anywhere:

```bash
searx "opnsense vs pfsense"
```
## ⚠️ If You See: `/usr/bin/env: ‘python3\r’: No such file or directory`

Run this to fix line endings:

```bash
sed -i 's/\r$//' searx.py
chmod +x searx.py
```
### ⭐ **Star the GitHub repo**  
### Share it with communities  
### Open issues or request features  

If this project saved you time or solved a problem, consider supporting development:

[![Buy Me a Coffee](https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20coffee&slug=socal370xs&button_colour=FFDD00&font_colour=000000&font_family=Arial&outline_colour=000000&coffee_colour=ffffff)](https://buymeacoffee.com/socal370xs)
