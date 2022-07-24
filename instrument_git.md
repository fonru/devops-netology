1. commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545 "Update CHANGELOG.md"
***
2. tag: v0.12.23
***
3. 2 коммита с хешами: 56cd7859e05c36c06b56d013b55a252d0bb7e158, 9ea88f22fc6269854151c571162c5bcf958bee2b
***
4.  33ff1c03bb (tag: v0.12.24) v0.12.24
    b14b74c493 [Website] vmc provider links
    3f235065b9 Update CHANGELOG.md
    6ae64e247b registry: Fix panic when server is unreachable
    5c619ca1ba website: Remove links to the getting started guide's old location
    06275647e2 Update CHANGELOG.md
    d5f9411f51 command: Fix bug when using terraform login on Windows
    4b6d06cc5d Update CHANGELOG.md
    dd01a35078 Update CHANGELOG.md
    225466bc3e Cleanup after v0.12.23 release
***
5. commit 8c928e83589d90a031f811fae52a81be7153e82f
   Author: Martin Atkins <mart@degeneration.co.uk>
   Date:   Thu Apr 2 18:04:39 2020 -0700
***
6. Также включил коммит где функция была создана (+)
    78b1220558
    52dbf94834
    41ab0aef7a
    66ebff90cd
    8364383c35 (+)
***
7.  Author: Martin Atkins <mart@degeneration.co.uk>
    Date:   Wed May 3 16:25:41 2017 -0700
функция потом была удалена


****COMMANDS
1. git log aefea -n 1
***
2. git log -n 1 85024d3
***
3. git rev-parse b8d720^@
***
4. git log --oneline v0.12.23...v0.12.24
***
5. нашел файл где функция описана git grep 'func providerSource(,а затем git log -L :providerSource:provider_source.go и по логам нашел, в каком коммите была впервые создана функция
***
6. также сперва грепнул, где описана функция, а затем git log  -L :'func globalPluginDirs(':plugins.go
***
7. сперва нашел коммит git log -SsynchronizedWriters а затем самый старый коммит проверил git show 5ac311e2a91e381e2f52234668b49ba670aa0fe5

