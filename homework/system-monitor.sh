#!/bin/bash


echo "=== Мониторинг системы ==="
echo ""

echo "--- Загрузка процессора ---"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "Использование CPU: $cpu_usage%"

echo ""
echo "--- Использование памяти ---"
memory_info=$(free -m | grep Mem)
total_mem=$(echo $memory_info | awk '{print $2}')
used_mem=$(echo $memory_info | awk '{print $3}')
memory_percent=$((used_mem * 100 / total_mem))

echo "Всего памяти: ${total_mem}MB"
echo "Использовано: ${used_mem}MB"
echo "Процент использования: ${memory_percent}%"

# Проверка порога
if [ $memory_percent -gt 80 ]; then
    echo ""
    echo "!!! ВНИМАНИЕ: Использование памяти превышает 80% !!!"
    echo ""
    echo "Топ-5 процессов по использованию памяти:"
    ps aux --sort=-%mem | head -6
fi


echo ""
echo "--- Дисковое пространство ---"
df -h | grep -E '^/dev/'

echo ""
echo "--- Топ-5 процессов по CPU ---"
ps aux --sort=-%cpu | head -6

