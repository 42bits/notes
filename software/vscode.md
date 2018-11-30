### vscode
 插件安装
 ```
Chinese (Simplified) Language Pack for Visual Studio Code
vscode-elm-jump
vscode-icons
Material Theme
Bracket Pair Colorizer（括号标识）
Indenticator（突出当前的缩进深度）
Path Autocomplete（路径智能补全）
Markdown Support for Visual Studio Code
sftp
go
python
PHP CS Fixer for Visual Studio Code
PHP DocBlocker（添加注释）
PHP Intelephense（代码智能提示）
 ```

 setting.json
```
{
    "files.exclude": {
        "**/.git": false,
        "**/.gitlab": true,
        "**/.vscode": true,
        "**/*.pyc": true,
    },
    "workbench.editor.enablePreview": false,
    "workbench.statusBar.feedback.visible": false,
    "editor.renderIndentGuides": true,
    "editor.tabSize": 4,
    "editor.renderWhitespace": "boundary",
    "editor.formatOnSave": true,
    "editor.formatOnPaste": true,
    "editor.formatOnSaveTimeout": 1000,
    "editor.fontSize": 16,
    "editor.cursorWidth": 2,
    "editor.cursorBlinking": "smooth",
    "editor.renderLineHighlight": "all",
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 1000,
    "files.trimTrailingWhitespace": true,
    "editor.multiCursorModifier": "ctrlCmd",
    "workbench.iconTheme": "eq-material-theme-icons",
    "workbench.colorTheme": "Material Theme",
    "python.pythonPath": "/usr/bin/python2.7",
    "python.linting.pylintEnabled": false,
    "python.linting.flake8Enabled": true,
    "python.linting.yapfEnabled": true,
    "python.formatting.provider": "yapf",
    "python.autoComplete.addBrackets": true,
    "php.executablePath": "/usr/local/php/bin/php",
    "php.suggest.basic": false,
    "php.validate.executablePath": "/usr/local/php/bin/php",
    "php-cs-fixer.executablePath": "/home/congxi/.composer/vendor/bin/php-cs-fixer",
    "php-cs-fixer.onsave": true,
    "php-cs-fixer.rules": "@Symfony,@PSR2,@PSR1",
    "php-cs-fixer.config": ".php_cs;.php_cs.dist",
    "php-cs-fixer.allowRisky": false,
    "php-cs-fixer.pathMode": "override",
    "php-cs-fixer.exclude": [],
    "php-cs-fixer.autoFixByBracket": true,
    "php-cs-fixer.autoFixBySemicolon": false,
    "php-cs-fixer.formatHtml": false,
    "php-cs-fixer.documentFormattingProvider": true,
   "go.buildOnSave": true,
    "go.lintOnSave": true,
    "go.vetOnSave": true,
    "go.buildFlags": [],
    "go.lintFlags": [],
    "go.vetFlags": [],
    "go.useCodeSnippetsOnFunctionSuggest": false,
    "go.formatOnSave": true,
    "go.formatTool": "goreturns",
    "go.goroot": "/home/congxi/os/go-1.11",
    "go.gopath": "/home/congxi/work/zzz-work/go"
}
```
安装go插件失败
```
正常操作
ctrl+shifp+p
go：install/update tools
选择安装

异常操作

cd $GOPATH/src/github.com/golang/
git clone https://github.com/golang/tools.git tools

把tools目录下的所有文件拷贝到$GOPATH/src/golang.org/x/tools下，如果没有自行创建

查看正常操作下安装失败的包（比如go-outline）
go install github.com/ramya-rao-a/go-outline

```