#!/usr/bin/env bash
# vim:fileencoding=UTF-8

# FileName: upgrade_nginx_online.sh
# Created:  1月4日, 2017
# Author(s): Xu Guojun 

:<<!
该脚本用于安装升级到tengine2.2.0版本，支持lua.
脚本当前目录包含以下安装文件:
-rw-r--r--. 1 root root   64851 1月   4 20:11 echo-nginx-module.tar.gz
-rw-r--r--. 1 root root  253698 1月   4 11:32 jemalloc-3.4.0.tar.bz2
-rw-r--r--. 1 root root  847615 1月   4 14:17 LuaJIT-2.0.4.tar.gz
-rw-r--r--. 1 root root  597217 1月   4 15:19 lua-nginx-module-v0.10.6.tar.gz
-rw-r--r--. 1 root root   66455 1月   4 14:28 ngx_devel_kit-v0.3.0.tar.gz
-rw-r--r--. 1 root root 2160648 1月   4 11:32 tengine-2.2.0.tar.gz
!

cp /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/nginx.old

:<<!
install LuaJIT
!
tar zxf LuaJIT-2.0.4.tar.gz
cd LuaJIT-2.0.4
make PREFIX=/usr/local/LuaJIT
make install PREFIX=/usr/local/LuaJIT

export LUAJIT_LIB=/usr/local/LuaJIT/lib
export LUAJIT_INC=/usr/local/LuaJIT/include/luajit-2.0

cd ..
tar -zxvf ngx_devel_kit-v0.3.0.tar.gz
tar -zxvf lua-nginx-module-v0.10.6.tar.gz 

tar -jxvf jemalloc-3.4.0.tar.bz2
tar -zxvf echo-nginx-module.tar.gz

tar -zxvf tengine-2.2.0.tar.gz
cd tengine-2.2.0

./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_sysguard_module --with-http_stub_status_module --with-http_ssl_module --with-jemalloc=../jemalloc-3.4.0 --add-module=../echo-nginx-module --with-ld-opt="-Wl,-rpath,/usr/local/LuaJIT/lib" --add-module=../ngx_devel_kit-0.3.0 --add-module=../lua-nginx-module-0.10.6 && make && make install

/usr/local/nginx/sbin/nginx -t 
kill -USR2 `cat /data/nginx/nginx.pid`
kill -QUIT `cat /data/nginx/nginx.pid.oldbin`

/usr/local/nginx/sbin/nginx 
ps aux | grep ngin[x]

:<<!
清理安装文件.
!
rm -rf ../LuaJIT-2.0.4
rm -rf ../ngx_devel_kit-0.3.0
rm -rf ../lua-nginx-module-0.10.6
rm -rf ../jemalloc-3.4.0
rm -rf ../echo-nginx-module
rm -rf ../tengine-2.2.0
