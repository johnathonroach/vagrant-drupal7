# vagrant-drupal7
A Vagrant Drupal dev environment setup that I think is rather swell.

REQUIREMENTS
Virtual Box
Mac or Linux Machine. I am working on a Windows release but I am trying to figure out if I should do a PowerShell, CYGWIN or something else.

Clone in your sites/default directory of your existing Drupal site from your repo or a fresh copt from Drupal.org.

WHAT ABOUT MY DATABASE?
Well for now, dump you database into a files named "export.sql" and place into the VagrantDrupal7 folder. The setup will look for this file when setting up you dev environment.
