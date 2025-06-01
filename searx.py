#!/usr/bin/env python3
"""
CLI SearXNG Search Tool (Robust HTML parser version)
"""

import requests
import argparse
from bs4 import BeautifulSoup

#    DEFAULT_ENGINE is a placeholder.
#    Update this to your own SearXNG instance (e.g. https://searx.example.com)

DEFAULT_ENGINE = "https://your-searx-instance.net"

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
}


def search_searx_html(query, engine, max_results=5, lang="en"):
    try:
        params = {
            "q": query,
            "language": lang,
            "safesearch": 1,
        }
        resp = requests.get(engine + "/search", params=params, headers=HEADERS, timeout=30)
        resp.raise_for_status()

        soup = BeautifulSoup(resp.text, "html.parser")
        results = soup.find_all("article", class_="result")

        if not results:
            print("No results found.")
            return

        print(f"\n# 🔍 SearXNG Results for: {query}\n")
        count = 0
        for result in results:
            title_tag = result.select_one(".result-title a")
            if not title_tag:
                title_tag = result.find("a")

            content_tag = result.select_one(".result-content")
            if not content_tag:
                content_tag = result.find("p")

            if title_tag:
                count += 1
                title = title_tag.text.strip()
                url = title_tag.get("href")
                snippet = content_tag.text.strip() if content_tag else ""
                print(f"{count}. {title}\n   {url}\n   ▸ {snippet}\n")

            if count >= max_results:
                break

    except requests.exceptions.RequestException as e:
        print(f"[ERROR] Failed to reach SearXNG server: {e}")


def main():
    parser = argparse.ArgumentParser(
        description="searx-cli: Search from the terminal using your SearXNG instance.\n"
                    "IMPORTANT: This tool uses a placeholder engine. Edit DEFAULT_ENGINE in the script to match your own SearXNG instance.",
        formatter_class=argparse.RawTextHelpFormatter
    )
    parser.add_argument("query", help="Search term in quotes")
    parser.add_argument("--engine", help=f"SearXNG base URL (default: {DEFAULT_ENGINE})", default=DEFAULT_ENGINE)
    parser.add_argument("-n", type=int, help="Max results", default=5)
    parser.add_argument("--lang", help="Language code (default: en)", default="en")

    args = parser.parse_args()
    search_searx_html(args.query, engine=args.engine, max_results=args.n, lang=args.lang)


if __name__ == "__main__":
    main()
