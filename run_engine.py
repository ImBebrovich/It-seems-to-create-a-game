#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
GAME ENGINE EDITOR - MAIN LAUNCHER
Точка входа в приложение
"""

import sys
import os

# Убедимся, что мы находимся в правильной директории
if __name__ == "__main__":
    # Определяем базовую директорию
    if getattr(sys, 'frozen', False):
        # Если запущено из exe (PyInstaller)
        base_dir = sys._MEIPASS
    else:
        # Если запущено из Python скрипта
        base_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Путь к папке game_engine
    game_engine_dir = os.path.join(base_dir, "game_engine")
    
    # Если папка game_engine находится в одном уровне выше
    if not os.path.exists(game_engine_dir):
        game_engine_dir = os.path.join(os.path.dirname(base_dir), "game_engine")
    
    # Если всё ещё не найдена, ищем main.py
    if not os.path.exists(os.path.join(game_engine_dir, "main.py")):
        print(f"Ошибка: не найдена папка game_engine")
        print(f"Ищу в: {game_engine_dir}")
        print(f"Base dir: {base_dir}")
        sys.exit(1)
    
    sys.path.insert(0, base_dir)
    
    # Импортируем основное приложение
    from game_engine.main import main
    main()
