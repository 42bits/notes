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

### laravel 定时任务
```
contab -e

* * * * * php 项目的路径/artisan schedule:run >> /dev/null 2>&1

* 就是代表 （分 时 日 月 周）

App\Console\Kernel类的schedule方法中定义所有调度任务

protected function schedule(Schedule $schedule)
    {

           $schedule->call(function () {
                Log::info('任务调度');
           })->everyMinute();
                 //Log::useFiles(storage_path('logs/emailtrigger'.date('Ymd').'.log'));
          //   Log::info('emailtrigger log: '.'log');

    }

->cron('* * * * *');    在自定义Cron调度上运行任务
->everyMinute();    每分钟运行一次任务
->everyFiveMinutes();   每五分钟运行一次任务
->everyTenMinutes();    每十分钟运行一次任务
->everyThirtyMinutes(); 每三十分钟运行一次任务
->hourly(); 每小时运行一次任务
->daily();  每天凌晨零点运行任务
->dailyAt('13:00'); 每天13:00运行任务
->twiceDaily(1, 13);    每天1:00 & 13:00运行任务
->weekly(); 每周运行一次任务
->monthly();    每月运行一次任务
->monthlyOn(4, '15:00');    每月4号15:00运行一次任务
->quarterly();  每个季度运行一次
->yearly(); 每年运行一次
->timezone('America/New_York'); 设置时区
->cron('* * * * *');    在自定义Cron调度上运行任务
->everyMinute();    每分钟运行一次任务
->everyFiveMinutes();   每五分钟运行一次任务
->everyTenMinutes();    每十分钟运行一次任务
->everyThirtyMinutes(); 每三十分钟运行一次任务
->hourly(); 每小时运行一次任务
->daily();  每天凌晨零点运行任务
->dailyAt('13:00'); 每天13:00运行任务
->twiceDaily(1, 13);    每天1:00 & 13:00运行任务
->weekly(); 每周运行一次任务
->monthly();    每月运行一次任务
->monthlyOn(4, '15:00');    每月4号15:00运行一次任务
->quarterly();  每个季度运行一次
->yearly(); 每年运行一次
->timezone('America/New_York'); 设置时区

```
