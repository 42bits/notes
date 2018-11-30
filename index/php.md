### 安装php
```
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data --with-zlib --enable-mbstring --with-openssl --enable-ftp --with-gd  --with-mysqli=mysqlnd  --with-pdo-mysql=mysqlnd --enable-pdo --with-mysql-sock --enable-sockets --with-gettext --enable-bcmath --enable-xml --with-bz2 --enable-zip --enable-shmop --with-iconv --enable-mbregex --enable-pcntl --enable-sysvmsg --enable-sysvsem --enable-sysvshm --with-freetype-dir --with-jpeg-dir --with-png-dir --disable-fileinfo --with-mhash --enable-pcntl --enable-inline-optimization --enable-exif --disable-rpath --with-curl
```

### 出现问题
```
configure: error: libxml2 not found. Please check your libxml2 installation.

sudo apt-get install libxml2-dev

configure: error: Cannot find OpenSSL's <evp.h>

sudo apt-get install libssl-dev

configure: error: Please reinstall the BZip2 distribution

sudo apt-get install libbz2-dev

configure: error: cURL version 7.10.5 or later is required to compile php with cURL support

sudo apt-get install libcurl4-gnutls-dev

configure: error: jpeglib.h not found.

sudo apt-get install libjpeg9-dev

configure: error: png.h not found.

sudo apt-get install libpng-dev

configure: error: freetype-config not found.

sudo apt-get install  libfreetype6-dev
```

### 安装 composer
```
curl -sS https://getcomposer.org/installer | php
mv composer /usr/local/bin/composer
```
全局安装
> composer global require 'friendsofphp/php-cs-fixer'

> (然后将$HOME/.composer/vendor/bin 加入path)
