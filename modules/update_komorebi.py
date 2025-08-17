import json
import sys
import os

# Path to your Komorebi config
KOMOREBI_CONFIG = os.path.join(os.environ["USERPROFILE"], "komorebi.json")  # adjust filename if needed

def main():
    if len(sys.argv) < 2:
        print("[!] Please provide the theme JSON")
        return

    theme = json.loads(sys.argv[1])
    border_color = theme.get("border")
    if not border_color:
        print("[!] No border color defined in theme")
        return

    # Load existing Komorebi config
    if not os.path.exists(KOMOREBI_CONFIG):
        print(f"[!] Komorebi config not found at {KOMOREBI_CONFIG}")
        return

    with open(KOMOREBI_CONFIG, "r", encoding="utf-8") as f:
        config = json.load(f)

    # Update border_colours for single and floating
    if "border_colours" not in config:
        config["border_colours"] = {}

    config["border_colours"]["single"] = border_color
    config["border_colours"]["floating"] = border_color

    # Save changes
    with open(KOMOREBI_CONFIG, "w", encoding="utf-8") as f:
        json.dump(config, f, indent=2)

if __name__ == "__main__":
    main()
