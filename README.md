# dot-config-and-utilities
This repository is a collection of dot configuration files and bash utilities.

## bash
Bash related files.

**- _bashrc**

This is a basic bash configuration file.  
This file must be renamed to `.bashrc` and placed on `$HOME` folder.

## zsh
Zsh related files.

**- _zshrc**

This is a basic zsh configuration file.  
This file must be renamed to `.zshrc` and placed on `$HOME` folder.

**- aliases**

This file collect a series of aliases in addition to those present in the built-in zsh plugins.  
Must be placed on `$HOME/.oh-my-zsh/custom`.

## misc

**- _sass-lint.yml**

This is a configuration file for sass linter.  
This file must be renamed to `.sass-lint.yml` and placed on root directory of project that use sass.

## bin
Utility scripts.

**- todayfiles.sh**

This is a bash script which list all files modified today in a given directory if provided as arguments
(otherwise current directory), recursively.

**- seeyouspacecowboy.sh**

Print a quote from Cowboy Bebop on terminal, colored.

**- fortune.sh**

Print a funny fortune quote, with cowsay and lolcat.

## vim
Vim configuration & related stuffs

**- _vimrc**

This is main vim configuration settings.  
This file must be renamed to `.vimrc` and placed on `$HOME` directory.

### vim/syntax
This directory contains custom syntax files.  
Custom syntax files are useful when we have a file with a common extension,
such as *txt*, but with a *special format* for some kind of app.  
This directory must be renamed to `.vim/syntax` and placed on `$HOME` directory, with all included files.  
More information:
- https://vim.fandom.com/wiki/Creating_your_own_syntax_files
- https://vim.fandom.com/wiki/Modeline_magic

**- jrnl.vim**

This is a custom syntax file for working with **jrnl** entries.  
More information on jrnl:
- https://jrnl.sh/en/stable/