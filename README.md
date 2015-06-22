# vagrant-drupal7
A Vagrant Drupal dev environment setup that I think is rather swell.

##REQUIREMENTS
Virtual Box
Mac or Linux Machine. I am working on a Windows release but I am trying to figure out if I should do a PowerShell, CYGWIN or something else.

Clone in your sites/default directory of your existing Drupal site from your repo or a fresh copt from Drupal.org.

##WHAT ABOUT MY DATABASE FOR AN EXISTING SITE?
Well for now, after the site is setup, ssh into the vm and import your data from a dump file.

> mysql -uroot -proot drupal_dev < your_dump_file.sql

I am working on an automaitc solution. Will have that out soon.

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
I tried to be cute and allow for either a fresh installation or the ability to spin up an existing site. This has given me some fits so things are still in development for this feature. To set up an existing project, dump your data from your live or staging environment into a dump file called "export.sql". Place the file in the same directory as your Vagrantfile. If the file is present, the provision bash script will attempt to import the data into the default database "dupal_dev". This needs some work and may not import correctly. If it fails, you can ssh into the Vagrant box after the VM is set up and install it manually through mysql.

##Did I MIss Anything?
This setup is designed to work out-of-the box but it is possible that you will get errors when you try my code. For this I am sorry and I feel your pain. Development is hard and we forget things. If you have issues or suggestions for my setup, kindly tell me about it. I'll do my best to make the solution the best it can be.
