#!/usr/bin/env bash
# vim:fileencoding=UTF-8

# FileName: clean_log.sh
# Created: 1月4, 2017
# Author(s): Xu Guojun 
# 保留10天内的访问日志

src_dir=/data/nginx/logs/

del_file=*.`date -d "10 days ago" +%Y%m%d`*
rm -rf $src_dir/$del_file

