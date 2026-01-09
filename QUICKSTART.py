#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
QUICK START GUIDE - Быстрый старт
Запустите этот файл для создания примера и первого тестирования
"""

import sys
import os

def print_banner():
    """Вывести красивый баннер"""
    banner = """
╔════════════════════════════════════════════════════════════════════╗
║                    GAME ENGINE EDITOR                             ║
║                    QUICK START GUIDE v1.0                         ║
╚════════════════════════════════════════════════════════════════════╝
"""
    print(banner)

def check_requirements():
    """Проверить требования"""
    print("\\n[1/4] Проверка требований...")
    
    try:
        import PyQt5
        print("  ✓ PyQt5 установлен")
        return True
    except ImportError:
        print("  ✗ PyQt5 не установлен")
        print("\\n  Установите командой:")
        print("    pip install -r requirements.txt")
        return False

def create_example_project():
    """Создать пример проекта"""
    print("\\n[2/4] Создание примера проекта...")
    
    try:
        from example_platformer_game import create_platformer_project
        scene = create_platformer_project()
        print("  ✓ Пример проекта создан")
        return True
    except Exception as e:
        print(f"  ✗ Ошибка при создании примера: {e}")
        return False

def print_next_steps():
    """Вывести следующие шаги"""
    print("\\n[3/4] Следующие шаги:")
    print("""
  1. Установите зависимости (если ещё не установлены):
     pip install -r requirements.txt
  
  2. Запустите редактор:
     python run_engine.py
  
  3. В редакторе вы сможете:
     - Создавать новые сцены и объекты
     - Писать скрипты на Python
     - Настраивать освещение и текстуры
     - Экспортировать игру
     
  4. Примеры кода находятся в:
     - game_engine/scripts/examples.py
     - example_platformer_game.py
""")

def main():
    """Главная функция"""
    print_banner()
    
    # Проверяем требования
    if not check_requirements():
        sys.exit(1)
    
    # Создаём пример
    if not create_example_project():
        print("\\n  (Продолжаем без примера...)")
    
    # Выводим следующие шаги
    print_next_steps()
    
    print("[4/4] Готово!")
    print("""
╔════════════════════════════════════════════════════════════════════╗
║  Game Engine Editor готов к запуску!                              ║
║                                                                    ║
║  Команда для запуска:                                              ║
║    python run_engine.py                                            ║
║                                                                    ║
║  Для подробной документации откройте:                              ║
║    game_engine/documentation.py                                    ║
╚════════════════════════════════════════════════════════════════════╝
""")

if __name__ == "__main__":
    main()
