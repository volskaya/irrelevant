#!/usr/bin/python3

from pathlib import Path
from os import listdir
from uuid import uuid4
from argparse import ArgumentParser

parser = ArgumentParser(description='Generate themes for our templates.')

parser.add_argument('--name', '-n', required=True, type=str, help='Name of the generated theme.')
parser.add_argument('--accent', required=True, type=str, help='Accent color.')
parser.add_argument('--strings', required=False, type=str, help='The color of strings.')
parser.add_argument('--bool', required=False, type=str, help='The color of booleans.')
parser.add_argument('--number', required=True, type=str, help='The color of numbers.')
parser.add_argument('--bracket', required=False, type=str, help='The color of brackets.')
parser.add_argument('--danger', required=False, type=str, help='THe color of danger elements like errors.')

args = parser.parse_args()
outputName = args.name
parentPath = Path(__file__).parent.absolute()
templatesPath = parentPath / 'templates'
themesPath = parentPath / 'themes'

grays = {
    "irrelevant": "#757575",

    "background": "#1c1c1c",
    "backgroundTranslucent": "#1c1c1c80",  # For VSCode.
    "backgroundTerminal": "#181818",
    "foreground": "#ffffff",
    "surface": "#212121",
    "surfaceBorder": "#00000010",
    "modal": "#292929",
    "modalFocus": "#404040",
    "borderDark": "#080808",  # Good contrast against bg for completion and info tooltips.
    "borderLight": "#757575",
    "inactiveForeground": "#757575",
    "activeForeground": "#979797",
    "highlight": "#292929",
    "divider": "#343434",  # INFO: Maybe 292929.
    "hint": "#6b6b6b",
    "selected": "#6b6b6b",  # Highlighted file names, paths, punctuation.
    "comment": "#757575",
    "punctuation": "#757575",
    'lineHighlight': '#292929',
    'indentGuide': '#292929',

    "gray0": "#444444",
    "gray1": "#666666",
    "gray2": "#757575",
    "gray3": "#878787",
    "gray4": "#979797",
    "gray5": "#A6A6A6",
    "gray6": "#DDDDDD",

    "gray00": "#ffffff",
    "gray01": "#ffffff",
    "gray02": "#ffffff",
    "gray03": "#000000",
    "gray04": "#000000",
    "gray05": "#000000",
    "gray06": "#000000",
}

colors = {
    **grays,

    "accent": args.accent,
    "number": args.number,
    "bracket": args.bracket or "#525252",

    "onAccent": "#000000",

    "danger": args.danger or args.number,
    "warning": "#525252",
    "success": "#b2fa52",

    "strings": args.strings or args.accent,
    "bool": args.bool or grays['irrelevant'],

}


theme = {
    **colors,

    'family': 'irrelevant',
    'name': outputName,
    'author': 'Roland Volskaya',
    'uuid': str(uuid4()),

    # Convenience keys for LSP theming.
    'stringColor': colors['strings'],
    'booleanColor': colors['bool'],
    'objectColor': colors['accent'],
    'irrelevantObjectColor': colors['irrelevant'],
    'numberColor': colors['number'],
    'variableColor': colors['foreground'],
    'argumentColor': colors['foreground'],
    'operatorColor': colors['irrelevant'],
    'methodColor': colors['foreground'],
    'languageConstantColor': colors['irrelevant'],

    'whitespaceColor': colors['divider'],
    'matchingBracketColor': colors['number'],

    'argumentStyle': 'italic',
    'languageConstantStyle': 'normal',

    # For some backwards compatibility.
    "red": colors['irrelevant'],
    "orange": colors['irrelevant'],
    "yellow": colors['accent'],
    "green": colors['foreground'],
    "blue": colors['accent'],
    "purple": colors['number'],
}

# Generate themes.
templates = [v for v in listdir(templatesPath) if (templatesPath / v).is_file()]

if not themesPath.exists():
    themesPath.mkdir()

for templateName in templates:
    templatePath = templatesPath / templateName
    outputPath = None

    # The output theme path is derived off the template name,
    # where nvim_colors become themes/nvim/colors.lua.
    templateNameDotSplit = templateName.split('.')
    templateExtension = templateNameDotSplit[-1]

    templateNameSplits = templateName.removesuffix(f'.{templateExtension}').split(".")
    templatePrefix = ""
    templateNameWithoutExtension = templateNameSplits[0]

    # If there are more strings in the splits, assume the 1st extra split is a prefix.
    if len(templateNameSplits) > 1:
        templatePrefix = templateNameSplits[-1]

    templateNamePaths = templateNameWithoutExtension.split("_")

    outputPath = Path(themesPath, *templateNamePaths, f"{templatePrefix}{outputName}.{templateExtension}")
    outputPath.parent.mkdir(parents=True, exist_ok=True)

    if not outputPath.parent.exists():
        outputPath.parent.mkdir()

    with open(templatePath, 'r') as template, open(outputPath, 'w') as output:
        missingKeys = set()
        i = 0

        for line in template:
            i += 1

            # Replace placeholders in the line with corresponding values
            # from the theme dictionary if found and not empty.
            start, end = line.find('{{'), line.find('}}')
            outputLine = line

            if start >= 0 and end >= 0:
                key = line[start + 2:end]
                try:
                    themeValue = theme[key]
                    if themeValue:
                        outputLine = line.replace('{{%s}}' % key, themeValue)
                except KeyError:
                    if key not in missingKeys:
                        missingKeys.add(key)
                        print(f" ! Missing key \"{key}\" in {outputPath.relative_to(themesPath.parent)}")

            output.write(outputLine)

        print(f'Generated {i} lines - "{outputPath.relative_to(themesPath.parent)}"')
