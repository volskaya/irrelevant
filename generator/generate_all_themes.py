#!/usr/bin/python3

import subprocess
from pathlib import Path
from subprocess import check_call
from shutil import rmtree

parentPath = Path(__file__).parent
generatorPath = parentPath / 'generate_theme.py'
themesPath = parentPath / 'themes'

rmtree(themesPath, ignore_errors=True)  # Delete any old generated files.

themes = [
    {'name': 'vaatu', 'accent': '#f148fb', 'number': '#FFFF33', 'bool': '#FFFF33', 'danger': '#ff1652'},
    {'name': 'sakura', 'accent': '#FB76C1', 'number': '#B3FA75',
        'bool': '#B3FA75', 'danger': '#75FA9D'},
    {'name': 'volskaya', 'accent': '#B2FA52', 'number': '#FF1652', 'bool': '#FF1652', 'bracket': '#525252'},
    {'name': 'yulon', 'accent': '#00FF98', 'number': '#946BFB', 'bool': '#946BFB', 'bracket': '#525252'},
    {'name': 'lore', 'accent': '#e2cc9e', 'number': '#a39a89', 'bracket': '#a39a89'},
    {'name': 'po', 'accent': '#FFFF0A', 'number': '#f9545e', 'bracket': '#f9545e'},
    {'name': 'mirai', 'accent': '#FF1652', 'number': '#FCF707', 'bool': "#FCF707", 'bracket': '#525252'},
    {'name': 'jinx', 'accent': '#F4009E', 'number': '#5CC0E6', 'bracket': '#5CC0E6'},
    {'name': 'powder', 'accent': '#EDB1FF', 'number': '#BFF5FF', 'bracket': '#BFF5FF'},
    {'name': 'tiktok', 'accent': '#25F4EE', 'number': '#FE2C55', 'bool': '#FE2C55', 'danger': '#FE2C55'},
    {'name': 'krone', 'accent': '#946BFB', 'number': '#FAEF6B', 'bool': '#FAEF6B', 'danger': '#ff1652'},
]


for theme in themes:
    args = [f"--{key}={value}" for key, value in theme.items()]
    print(f'Calling {generatorPath.name} with "{" ".join(args)}"')
    try:
        check_call([str(generatorPath), *args])
    except subprocess.CalledProcessError:
        break
    print('\n')
