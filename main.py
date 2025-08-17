import json
import subprocess
import sys
from pathlib import Path

def load_json(filename):
    with open(filename, "r", encoding="utf-8") as f:
        return json.load(f)

def run_script(script, theme_json):
    ext = Path(script).suffix.lower()
    if ext == ".py":
        subprocess.run([sys.executable, script, theme_json])
    elif ext == ".ps1":
        subprocess.run([
            "powershell.exe",
            "-ExecutionPolicy", "Bypass",
            "-File", script,
            theme_json
        ])
    else:
        print(f"[!] Unknown script type: {script}")

def main():
    if len(sys.argv) < 2:
        print("[!] Please provide a theme name as the first argument")
        sys.exit(1)

    active_theme = sys.argv[1]

    config = load_json("config.json")
    themes = load_json("themes.json")

    if active_theme not in themes:
        print(f"[!] Theme '{active_theme}' not found in themes.json")
        sys.exit(1)

    theme = themes[active_theme]
    theme_json = json.dumps(theme)

    for script in config["scripts"]:
        print(f"[+] Running {script}")
        run_script(script, theme_json)

if __name__ == "__main__":
    main()
