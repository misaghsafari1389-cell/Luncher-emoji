#!/usr/bin/env bash
# Downloads the Vazirmatn font (SIL Open Font License 1.1, by Saber Rastikerdar)
# into app/src/main/assets/fonts. Safe to re-run. If a download fails the app still
# builds and simply falls back to the system sans-serif font.
set -u
DEST="$(cd "$(dirname "$0")/.." && pwd)/app/src/main/assets/fonts"
VER="v33.003"
mkdir -p "$DEST"
for w in Regular Medium Bold; do
  f="Vazirmatn-$w.ttf"
  if [ -s "$DEST/$f" ]; then echo "already have $f"; continue; fi
  ok=0
  for base in \
    "https://cdn.jsdelivr.net/gh/rastikerdar/vazirmatn@$VER/fonts/ttf" \
    "https://raw.githubusercontent.com/rastikerdar/vazirmatn/$VER/fonts/ttf"; do
    if curl -fsSL --retry 3 -o "$DEST/$f" "$base/$f" && [ -s "$DEST/$f" ]; then ok=1; echo "downloaded $f"; break; fi
  done
  if [ "$ok" -eq 0 ]; then
    echo "::warning::could not download $f - the app will use the system font"
    rm -f "$DEST/$f"
  fi
done
exit 0
