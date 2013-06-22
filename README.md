Dotfiles
========

Yes, yes, this is yet another personal dotfiles repository.

Submodules
----------

My ranger configuration files are their own submodule. Thus, when cloning this project, you must also run

```bash
git submodule init
git submodule update
```

to get all of the files.

Encryption
----------

Some parts of the repository contain personal information, and are encrypted automatically on remote repositories using `git-crypt` (see the `.gitattributes` file for the specific files). One would require a copy of the repository's crypt key in order to decrypt them when cloning.
