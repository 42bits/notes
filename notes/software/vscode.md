### vscode
 插件安装
 ```
Chinese (Simplified) Language Pack for Visual Studio Code
Git Blame
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
python for vscode
lua
vscode-lua
PHP CS Fixer for Visual Studio Code
PHP DocBlocker（添加注释）
PHP Intelephense（代码智能提示）
PlantUML
remote-ssh
yaml
vscode-icons
kubernetes
docker
 ```

 setting.json
> python 需要安装flake8 检查代码规范和语法错误 pip install flake8

> yapf 格式化工具  pip install yapf


```
{
    "files.exclude": {
        "**/.git": false,
        "**/.gitlab": true,
        "**/.vscode": true,
        "**/*.pyc": true,
    },
    "local": "zh-cn",
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 1000,
    "files.trimTrailingWhitespace": true,
    "workbench.editor.enablePreview": false,
    "workbench.statusBar.feedback.visible": false,
    "workbench.iconTheme": "vscode-icons",
    "workbench.colorTheme": "Visual Studio Dark",
    "workbench.colorCustomizations": {},
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
    "editor.multiCursorModifier": "ctrlCmd",
    "editor.suggestSelection": "first",
    "editor.fontLigatures": null,
    "python.pythonPath": "/usr/local/bin/python3.7",
    "python.linting.pylintEnabled": false,
    "python.linting.flake8Enabled": true,
    "python.linting.yapfEnabled": true,
    "python.linting.flake8Args": [
        "--max-line-length=248"
    ],
    "python.analysis.disabled": [
        "unresolved-import"
    ],
    "python.formatting.provider": "yapf",
    "python.autoComplete.addBrackets": true,
    "python.jediEnabled": false,
    "php.executablePath": "/usr/bin/php",
    "php.suggest.basic": false,
    "php.validate.executablePath": "/usr/bin/php",
    "php-cs-fixer.executablePath": "${extensionPath}/php-cs-fixer.phar",
    "php-cs-fixer.onsave": true,
    "php-cs-fixer.rules": "@PSR2,@PSR1", //@Symfony,
    "php-cs-fixer.config": ".php_cs;.php_cs.dist",
    "php-cs-fixer.allowRisky": false,
    "php-cs-fixer.pathMode": "override",
    "php-cs-fixer.exclude": [],
    "php-cs-fixer.autoFixByBracket": true,
    "php-cs-fixer.autoFixBySemicolon": false,
    "php-cs-fixer.formatHtml": false,
    "php-cs-fixer.documentFormattingProvider": true,
    "php-cs-fixer.lastDownload": 1588908652347,
    "go.buildOnSave": true,
    "go.lintOnSave": true,
    "go.vetOnSave": true,
    "go.buildFlags": [],
    "go.lintFlags": [],
    "go.vetFlags": [],
    "go.inferGopath": false,
    "go.docsTool": "gogetdoc",
    "go.gocodePackageLookupMode": "go",
    "go.gotoSymbol.includeImports": true,
    "go.autocompleteUnimportedPackages": true,
    "go.useCodeSnippetsOnFunctionSuggest": false,
    "go.useCodeSnippetsOnFunctionSuggestWithoutType": true,
    "go.formatOnSave": true,
    "go.formatTool": "goimports",
    "go.goroot": "/usr/local/go", //你的Goroot
    "go.gopath": "/Users/congxi/Work/go",
    "go.useLanguageServer": true,
    "go.languageServerExperimentalFeatures": {}, //你的Gopath
    "telemetry.enableTelemetry": false,
    "telemetry.enableCrashReporter": false,
    "window.zoomLevel": 0,
    "remote.SSH.configFile": "/Users/congxi/.ssh/config",
    "git.ignoreLegacyWarning": true,
    "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
    "vs-kubernetes": {
        "vs-kubernetes.helm-path": "/Users/congxi/.vs-kubernetes/tools/helm/darwin-amd64/helm"
    },
    "files.associations": {

    },
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
