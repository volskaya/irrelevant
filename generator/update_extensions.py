from pathlib import Path
from os import listdir
from shutil import rmtree, copytree
from subprocess import check_call

parentPath = Path(__file__).parent.absolute()
projectPath = parentPath.parent
otherTemplatesPath = parentPath / 'other_templates'
themesPath = parentPath / 'themes'
extensionsPath = parentPath.parent / 'extensions'
projectVersionPath = parentPath.parent / 'VERSION'

# Packages have their version files matched with the project version.
projectVersion = projectVersionPath.read_text().strip()


def getName(path: Path):
    return path.stem.title().replace('_', ' ').replace('-', ' ').title()


def regenerateThemes():
    check_call(parentPath / 'generate_all_themes.py')


def getVscodeThemeLine(path: Path, isTranslucent: bool = False):
    indent = "      "
    namePostfix = " (Translucent)" if isTranslucent else ""
    nameValue = f'Irrelevant - {getName(path)}{namePostfix}'
    pathValue = f"./translucent-themes/{path.name}" if isTranslucent else f"./themes/{path.name}"

    return f'{indent}{{ "label": "{nameValue}", "uiTheme": "vs-dark", "path": "{pathValue}" }},'


def updateVscodeExtension():
    extensionPath = extensionsPath / 'vscode'
    packageJsonPath = extensionPath / 'package.json'
    packageJsonTemplatePath = extensionPath / 'package.json.template'

    extensionThemesPath = extensionPath / 'themes'
    extensionTranslucentThemesPath = extensionPath / 'translucent-themes'

    regularThemesPath = themesPath / 'vscode' / 'themes'
    translucentThemesPath = themesPath / 'vscode' / 'translucent-themes'

    themes = [regularThemesPath / v for v in listdir(regularThemesPath)]
    translucentThemes = [translucentThemesPath / v for v in listdir(translucentThemesPath)]

    themeEntries = [getVscodeThemeLine(v, isTranslucent=False) for v in themes]
    translucentThemeEntries = [getVscodeThemeLine(v, isTranslucent=True) for v in translucentThemes]

    themeEntriesString = '\n'.join(themeEntries)
    translucentThemeEntriesString = '\n'.join(translucentThemeEntries)

    # Remove the last comma to avoid json error.
    if translucentThemeEntriesString.endswith(','):
        translucentThemeEntriesString = translucentThemeEntriesString[:-1]

    # Copy the colors.
    rmtree(extensionThemesPath, ignore_errors=True)
    rmtree(extensionTranslucentThemesPath, ignore_errors=True)

    copytree(regularThemesPath, extensionThemesPath)
    copytree(translucentThemesPath, extensionTranslucentThemesPath)

    # Write the package.json file.
    with open(packageJsonTemplatePath, 'r') as template, open(packageJsonPath, 'w') as output:
        packageTemplate = template.read()

        packageTemplate = packageTemplate.replace('{{version}}', projectVersion)
        packageTemplate = packageTemplate.replace('{{themes}}', themeEntriesString)
        packageTemplate = packageTemplate.replace('{{translucentThemes}}', translucentThemeEntriesString)

        output.write(packageTemplate)

    print(f"Updated extension for VSCode at {extensionPath.relative_to(projectPath)}.")


def updateNeovimExtension():
    extensionPath = extensionsPath / 'neovim'
    extensionVersionPath = extensionPath / 'VERSION'

    extensionColorsPath = extensionPath / 'colors'
    extensionPalettesPath = extensionPath / 'lua' / 'irrelevant' / 'palettes'
    extensionColorsWildcardPath = extensionColorsPath / 'irrelevant.lua'

    colorsPath = themesPath / 'neovim' / 'colors'
    palettesPath = themesPath / 'neovim' / 'palettes'

    # Copy the colors.
    rmtree(extensionColorsPath, ignore_errors=True)
    rmtree(extensionPalettesPath, ignore_errors=True)

    copytree(colorsPath, extensionColorsPath)
    copytree(palettesPath, extensionPalettesPath)

    extensionVersionPath.write_text(projectVersion)
    extensionColorsWildcardPath.write_text(
        'require("irrelevant")._load() -- Generated with github.com/volskaya/irrelevant.')

    print(f"Updated extension for Neovim at {extensionPath.relative_to(projectPath)}.")


# 1st regenerate all themes.
regenerateThemes()

# 2nd update the extensions.
updateVscodeExtension()
updateNeovimExtension()
