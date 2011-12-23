##Introduction

Arsh is the Advanced Ruby Shell, and intends to be a pure ruby implementation of the Linux shell.  Currently, the shell is capable of running ordinary Linux commands as well as arbitrary Ruby code.  Tab complete functionality works as well.

##Installation

```bash
gem install arsh
```

If you use RVM, you will need to run the following script to reconfigure it for RVM, otherwise the shell will only work when spawned by a Bash shell.

```bash
arsh_configure_for_rvm
```

Most flavors of linux will require you to edit /etc/shells to add the new shell before it can be used.

Once that is done, modify your user shell to the new shell, logout, and log back in.
