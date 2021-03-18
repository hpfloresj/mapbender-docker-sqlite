#!/bin/bash
set -x

echo "Start Mapbender setup"

MAPBENDER_FOLDER=/srv/www/mapbender

if [ -n "$USER_UID" ]; then
  # NOT FOR PRODUCTION
  usermod -u $USER_UID www-data
  groupmod -g $USER_GID www-data
fi

echo $APACHE_RUN_DIR

if [ -d "$MAPBENDER_FOLDER/application/web" ]; then
  echo "$MAPBENDER_FOLDER/application/web is a directory."
else

  echo "$MAPBENDER_FOLDER/application/web is not a directory."
  cd $MAPBENDER_FOLDER

  if [ -v MAPBENDER_GIT_REF ]; then
    # install git
    apt update
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y git ssh-client unzip

    # install composer v1.0
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.20

    # Setup Mapbender from branch MAPBENDER_BRANCH
    EXTERNAL_REPO=https://github.com/mapbender/mapbender-starter.git
    CHECKOUT_TARGET=${MAPBENDER_FOLDER}

    echo "Pulling fresh copy of Mapbender starter from ${EXTERNAL_REPO} branch ${MAPBENDER_GIT_REF} to ${CHECKOUT_TARGET}"
    git clone https://github.com/mapbender/mapbender-starter.git ${CHECKOUT_TARGET}
    git checkout ${MAPBENDER_STARTER_GIT_REF}

    # copy parameters.yml preconfigured for ENV variables into app/config
    cp /srv/www/parameters.yml /srv/www/mapbender/application/app/config/parameters.yml

    cd application

    chown -R www-data:www-data /var/www
    chown -R www-data:www-data /srv/www/mapbender
    # change mapbender version to mapbender branch specified in docker-compose.yml

    #su -s /bin/bash www-data -c "composer config minimum-stability dev"

    #su -s /bin/bash www-data -c "rm -rf application"
    #git clone https://github.com/mapbender/mapbender.git ${CHECKOUT_TARGET}/application
    #git checkout ${MAPBENDER_GIT_REF}


    #su -s /bin/bash www-data -c "php -d memory_limit=6G /usr/local/bin/composer require --ignore-platform-reqs mapbender/mapbender:${MAPBENDER_GIT_REF}"
    su -s /bin/bash www-data -c "composer install -o --no-scripts"
    chmod +x vendor/wheregroup/sassc-binaries/dist/sassc

    cd mapbender
    git checkout $MAPBENDER_GIT_REF
    cd ..

    su -s /bin/bash www-data -c "composer run build-bootstrap"
    su -s /bin/bash www-data -c "app/console assets:install --symlink --relative"
    su -s /bin/bash www-data -c "app/console doctrine:schema:create"
    su -s /bin/bash www-data -c "app/console mapbender:database:init -v"
    su -s /bin/bash www-data -c "composer run post-autoload-dump"

    su -s /bin/bash www-data -c "app/console doctrine:fixtures:load --fixtures=./mapbender/src/Mapbender/CoreBundle/DataFixtures/ORM/Application/ --append"

    ## create a mapbender backend user
    su -s /bin/bash www-data -c "app/console mapbender:user:create mb_root --email user@mapbender-wg.com --password mb_root"

  elif [ -v MAPBENDER_BUILD_URL ]; then
    mkdir $MAPBENDER_FOLDER/application

    # setup Mapbender from build referenced in MAPBENDER_BUILD_URL
    curl -o mapbender.tar.gz -L $MAPBENDER_BUILD_URL
    tar --strip-components=1 -C $MAPBENDER_FOLDER/application -xzf mapbender.tar.gz

    rm mapbender.tar.gz
    chown www-data:www-data -R $MAPBENDER_FOLDER

    #cp /srv/www/parameters.yml $MAPBENDER_FOLDER/application/app/config/parameters.yml

    cd application
    #su -s /bin/bash www-data -c "app/console doctrine:schema:create"
    su -s /bin/bash www-data -c "app/console mapbender:database:init -v"
    su -s /bin/bash www-data -c "app/console doctrine:fixtures:load --fixtures=./mapbender/src/Mapbender/CoreBundle/DataFixtures/ORM/Application/ --append"

    # create a mapbender backend user
    su -s /bin/bash www-data -c "app/console mapbender:user:create mb_root --email user@mapbender-wg.com --password mb_root"

    su -s /bin/bash www-data -c "app/console assets:install web --symlink --relative"

  fi

  #make sure everything is owned by www-data
  chown -R www-data:www-data /srv/www/mapbender
fi

ls -al "$MAPBENDER_FOLDER"
