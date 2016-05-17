.emacs.d
========

My personal emac config, its base on  [purcell/emacs.d](https://github.com/purcell/emacs.d). if you prefer to original 
README.md please visit [README-purcell.md](./README-purcell.md)


## Package

### magit

shortcuts:
+ M-F12 magit-status

### go

firstly , you should install go,  [official tutorial](http://golang.org/doc/install), and config your develop envrionment, [other official doc](http://golang.org/doc/code.html).

dependencies go package:

+ install goimports
+ install godef
+ install oracle
+ install gocode

$ go get golang.org/x/tools/cmd/oracle
$ go get golang.org/x/tools/cmd/goimports
$ go get -u -v github.com/nsf/gocode

#### reference
+ [http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/](http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/)
+ [http://dominik.honnef.co/posts/2013/03/writing_go_in_emacs/](http://dominik.honnef.co/posts/2013/03/writing_go_in_emacs/)

## Changelogs

+ remove some unuse packages.
+ add golang programming language support(go-mode).
+ full-screen when start up.
+ custom font and theme.

## About fonts

> monaco and Noto dans s chinese should be installed.
