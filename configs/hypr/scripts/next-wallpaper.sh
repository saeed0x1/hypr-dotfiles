#!/usr/bin/env bash
set -euo pipefail

wallpaper_dir="$HOME/Pictures/wallpapers"

report_error() {
    printf '%s\n' "$1" >&2
    noctalia msg notification-show "Wallpaper" "$1" >/dev/null 2>&1 || true
}

if [[ ! -d "$wallpaper_dir" ]]; then
    report_error "Folder missing: $wallpaper_dir"
    exit 1
fi

mapfile -d '' -t wallpapers < <(
    find "$wallpaper_dir" -maxdepth 1 -type f \
        \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) \
        -print0 | sort -z
)

if (( ${#wallpapers[@]} == 0 )); then
    report_error "No PNG, JPEG, or WebP wallpapers in $wallpaper_dir"
    exit 1
fi

if ! current_wallpaper="$(noctalia msg wallpaper-get)"; then
    report_error "Noctalia is not available to read the current wallpaper"
    exit 1
fi

current_wallpaper="$(realpath -m -- "$current_wallpaper")"
next_index=0
for index in "${!wallpapers[@]}"; do
    if [[ "$(realpath -m -- "${wallpapers[index]}")" == "$current_wallpaper" ]]; then
        next_index=$(( (index + 1) % ${#wallpapers[@]} ))
        break
    fi
done

noctalia msg wallpaper-set "${wallpapers[next_index]}"
