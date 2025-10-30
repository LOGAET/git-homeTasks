#!/bin/bash

echo "=== Менеджер резервного копирования ==="

echo "Введите путь к директории для резервного копирования:"
read source_dir

if [ ! -d "$source_dir" ]; then
    echo "Ошибка: директория не существует"
    return
fi

backup_dir="$HOME/backups"
date_stamp=$(date +%Y%m%d_%H%M%S)
current_backup="$backup_dir/backup_$date_stamp"
log_file="$backup_dir/backup.log"

mkdir -p "$backup_dir"
mkdir -p "$current_backup"

echo "$(date): Начало резервного копирования из $source_dir" >> "$log_file"

count=0
for file in "$source_dir"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        cp "$file" "$current_backup/${filename%.*}_$date_stamp.${filename##*.}"
        count=$((count + 1))
        echo "$(date): Скопирован $filename" >> "$log_file"
    fi
done

echo "$(date): Резервное копирование завершено. Файлов: $count" >> "$log_file"
echo ""
echo "Резервное копирование завершено успешно!"
echo "Скопировано файлов: $count"
echo "Директория бэкапа: $current_backup"
echo "Лог файл: $log_file"
