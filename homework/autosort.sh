#!/bin/bash


# В 'crontab' нужно указать комманду
# 0 2 * * * /полный/путь/к/file_sorter.sh auto /путь/к/директории
# Такое обозение подразумевает запуск каждую ночь в 2:00

TARGET_DIR="${1:-$PWD}"

IMAGES_DIR="$TARGET_DIR/Images"
DOCS_DIR="$TARGET_DIR/Documents"
LOG_FILE="$TARGET_DIR/sort_files.log"


mkdir -p "$IMAGES_DIR"
mkdir -p "$DOCS_DIR"

move_file() {
    local file="$1"
    local dest="$2"
    if mv "$file" "$dest"; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') Moved: $file -> $dest" >> "$LOG_FILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') Failed to move: $file" >> "$LOG_FILE"
    fi
}

for ext in jpg png gif; do
    for file in "$TARGET_DIR"/*."$ext"; do
        [ -e "$file" ] && move_file "$file" "$IMAGES_DIR"
    done
done

for ext in txt pdf docx; do
    for file in "$TARGET_DIR"/*."$ext"; do
        [ -e "$file" ] && move_file "$file" "$DOCS_DIR"
    done
done


