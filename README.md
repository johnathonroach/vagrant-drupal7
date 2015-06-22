# vagrant-drupal7
A Vagrant Drupal dev environment setup that I think is rather swell.

##REQUIREMENTS
- Virtual Box
- Vagrant
- Mac or Linux Machine.
- I am working on a Windows release but I am trying to figure out if I should do a PowerShell, CYGWIN or something else.

Clone in your sites/default directory of your existing Drupal site from your repo or a fresh copt from Drupal.org.

##Some details about my setup:

- OS: Ubuntu 14.04.1 LTS
- PHP: 5.5.9-1ubuntu4.5 (cli)
- MySQL: 5.5.41-0ubuntu0.14.04.1
- Drush: 6.2.0
- Drush REPL with drush-psysh
- I'm using NFS for my Mac. This works for *nix and Mac OS systems. Windows users should use SMB (See Docs)

##MySQL credentials
> mysql -uroot -proot

##REPL and the REPL command
https://github.com/grota/drush-psysh
> drush repl

##New vs Existing Project
For now, after the default site is setup, ssh into the vm and import your data from a dump file.

> mysql -uroot -proot drupal_dev < your_dump_file.sql

I am working on an automaitc solution. Will have that out soon.

##Did I MIss Anything?
This setup is designed to work out-of-the box but it is possible that you will get errors when you try my code. For this I am sorry and I feel your pain. Development is hard and we forget things. If you have issues or suggestions for my setup, kindly tell me about it. I'll do my best to make the solution the best it can be.
