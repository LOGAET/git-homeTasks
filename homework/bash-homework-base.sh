#!/bin/bash

# Задание 1: Функционал Bash
echo "=== Задание 1: Функционал Bash ==="

# 1.1 Список файлов с типами
echo "Список файлов:"
for item in *; do
    if [ -d "$item" ]; then
        echo "  [DIR]  $item"
    elif [ -f "$item" ]; then
        echo "  [FILE] $item"
    fi
done

# 1.2 Проверка файла
echo ""
echo "Введите имя файла для проверки:"
read filename
if [ -e "$filename" ]; then
    echo "Файл '$filename' существует"
else
    echo "Файл '$filename' не найден"
fi

# 1.3 Права доступа
echo ""
echo "Файлы и права доступа:"
for item in *; do
    if [ -e "$item" ]; then
        ls -ld "$item" | awk '{print $1, $9}'
    fi
done

# Задание 2: Переменная PATH
echo ""
echo "=== Задание 2: Переменная PATH ==="
echo "Текущий PATH:"
echo "$PATH"

echo ""
echo "Введите директорию для добавления в PATH:"
read new_dir
export PATH="$PATH:$new_dir"
echo "Новый PATH:"
echo "$PATH"

echo ""
echo "Для постоянного изменения PATH добавьте в ~/.bashrc:"
echo "export PATH=\"\$PATH:$new_dir\""
echo "Затем выполните: source ~/.bashrc"

# Задание 3: Управляющие конструкции
echo ""
echo "=== Задание 3: Управляющие конструкции ==="
echo "Введите число:"
read number

if [ "$number" -gt 0 ]; then
    echo "Число положительное"
    echo "Считаем от 1 до $number:"
    counter=1
    while [ $counter -le "$number" ]; do
        echo -n "$counter "
        counter=$((counter + 1))
    done
    echo ""
elif [ "$number" -lt 0 ]; then
    echo "Число отрицательное"
else
    echo "Число равно нулю"
fi

# Задание 4: Работа с функциями
echo ""
echo "=== Задание 4: Работа с функциями ==="

greet() {
    echo "Hello, $1"
}

sum_numbers() {
    result=$(($1 + $2))
    echo $result
}

echo "Введите имя:"
read name
greet "$name"

echo "Введите первое число:"
read num1
echo "Введите второе число:"
read num2
result=$(sum_numbers "$num1" "$num2")
echo "Сумма: $result"

# Задание 5: Управление процессами
echo ""
echo "=== Задание 5: Управление процессами ==="
echo "Запускаем три sleep в фоне:"

sleep 10 &
echo "sleep 10 запущен (PID: $!)"

sleep 15 &
echo "sleep 15 запущен (PID: $!)"

sleep 20 &
echo "sleep 20 запущен (PID: $!)"

echo ""
echo "Список задач:"
jobs

echo ""
echo "Команды для управления:"
echo "jobs - показать задачи"
echo "fg %1 - вывести задачу 1 на передний план"
echo "bg %1 - возобновить задачу 1 в фоне"

# Задание 6: Ввод/вывод и перенаправление
echo ""
echo "=== Задание 6: Ввод/вывод и перенаправление ==="

# Создаем файл
cat > input.txt << EOF
Строка 1
Строка 2
Строка 3
EOF

echo "Файл input.txt создан"

# Подсчет строк
wc -l < input.txt > output.txt
echo "Количество строк записано в output.txt"
cat output.txt

# Перенаправление ошибок
ls несуществующий_файл 2> error.log
echo "Ошибка записана в error.log"
cat error.log

# Задание 7: Использование alias
echo ""
echo "=== Задание 7: Использование alias ==="

alias ll='ls -la'
echo "Создан alias: ll='ls -la'"

echo ""
echo "Для постоянного alias добавьте в ~/.bashrc:"
echo "alias ll='ls -la'"
echo "Затем: source ~/.bashrc"

echo ""
echo "Автодополнение работает по Tab"
echo "Пример: cd /us[Tab] -> cd /usr/"

echo ""
echo "=== Все задания выполнены ==="