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

Once that is done, modify your user shell to the new shell, logout, and log back in

##Configuring

Most of the Shell can be configured via 2 files.  /etc/arshrc for global configuration, and $HOME/.arshrc.  Environment variables can be configured there, as well as global variables and other configuration.  An example arshrc configuration file would look as follows

```ruby
    $ps1="(arsh) \e[01;32m<% ENV['USER'] %>@<% `hostname`.chomp %>\e[01;34m <% Dir.pwd %> $\e[00m "
    alias ls=ls --color
    ENV['PATH'] = "/usr/local/bin:/usr/bin:/bin:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.5.3"
    ENV['HIST_COUNT'] = "1000"
    rvm use 1.9.3
```

The arshrc files are pure ruby, but multiple line evaluation is not currently possible.
