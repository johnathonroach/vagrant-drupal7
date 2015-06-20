# THIS NEEDS A LOT OF WORK. DO NOT RUN AS PROVISION, RUN EACH COMMAND AFTER VM IS CREATED....
cd /home/vagrant

#location of vagratndrupal7
VagrantDir="/var/www/sites/default/vagrantdrupal7"

sudo apt-get -y update

#echo "******** add repo for for php 5.5"
#sudo apt-get -y install python-software-properties
#sudo add-apt-repository -y ppa:ondrej/php5

#sudo apt-get -y update

echo "******** install mysql - we'll set our root password in some vars first"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "******** install apache and php with modules required for drupal 7"
sudo apt-get -y install apache2 php5 php-pear php5-common php5-gd libapache2-mod-php5 mysql-server php5-mysql
sudo apt-get -y install php-pear

echo "******** install vim"
sudo apt-get -y install vim

echo "******** intall git"
sudo sudo apt-get -y install git-core

echo "******** install CURL"
sudo apt-get -y install libcurl3 php5-curl
sudo apt-get -y install curl

echo "******** install composer"
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "******** install drush"
#composer global require drush/drush:dev-master
sudo pear channel-discover pear.drush.org
sudo pear install drush/drush
echo "******** the pear download leaves some items out so we need to grab this packages and copy to the drush lib"
sudo wget http://download.pear.php.net/package/Console_Table-1.1.3.tgz
sudo tar zxvf Console_Table-1.1.3.tgz -C /usr/share/php/drush/lib

echo "******** install Drush REPL with drush-psysh"
cd /home/vagrant
sudo mkdir .drush
sudo chmod 777 .drush
cd .drush
sudo git clone https://github.com/grota/drush-psysh.git
cd drush-psysh
sudo composer install

echo "******** set some rewrite stuff for apache"
sudo a2enmod rewrite

echo "******** upload our custom sites available v-hosts file which includes some things for drupal to run. 'AllowOverride All' in particular."
sudo rm /etc/apache2/sites-enabled/000-default.conf
sudo cp $VagrantDir/dev /etc/apache2/sites-available/dev.conf
sudo ln -sn /etc/apache2/sites-available/dev.conf /etc/apache2/sites-enabled/dev.conf

sudo cp $VagrantDir/htaccess /var/www/.htaccess

sudo service apache2 restart

echo "******** install drupal site"
cd /var/www

drush site-install standard --db-url=mysql://root:root@localhost/drupal_dev --site-name=Drupal7Dev --account-name=admin --account-pass=admin --yes

echo "******** set some permissions for drupal"
chmod g+x sites/ sites/default/
sudo chown -R root:www-data sites/default/files


if [ ! -f $VagrantDir/export.sql ]
then
    echo "******** No sql dump file found! Keep default installation..."

    #themes
    drush en -y bootstrap
    
    #adminimal theme - this creates an infinite loop for some reason. I usually do this manualy and exit the loop with ctrl+c
    #drush en -y adminimal_theme

    #install favorite modules for initial site
    drush en -y views
    drush en -y module_filter
    drush en -y jquery_update
    drush en -y ckeditor
    drush en -y imce
    drush en -y imce_mkdir
    drush en -y fontyourface
    #there is an issue with fontawesome. it will download the module bu has trouble installing the library files
    #need to maybe run a git command for the fontaweseom library
    drush en -y fontawesome
    drush en -y google_fonts_api
    drush en -y libraries
    drush en -y login_destination
    drush en -y pathauto
    drush en -y special_menu_items
    drush en -y fontyourface_wysiwyg
    drush en -y adminimal_admin_menu

    #just download
    drush dl entity
    drush dl entityreference
    drush dl entityreference_prepopulate
    drush dl entity_token

    #others
    #drush dl og
    #drush dl og_homepage
    #drush dl og_menu
    #drush dl og_menu_default_links
    #drush dl og_access
    #drush dl og_context
    #drush dl og_extras
    #drush dl og_field_access
    #drush dl og_register
    #drush dl og_ui


else
  echo "******** sql dump file found! replacing default data with dump data..."
  mysql -uroot -proot -e "DROP DATABASE drupal_dev;"
  mysql -uroot -proot -e "CREATE DATABASE drupal_dev;"
  mysql -uroot -proot drupal_dev < $VagrantDir/export.sql
fi

drush upwd --password="admin" admin

echo "******** restart apache one more time"
sudo service apache2 restart
: <<'END' 
#block comment for testing
END
echo '******** All Done!'