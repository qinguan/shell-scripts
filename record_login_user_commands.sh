#!/bin/bash
# please put this script under /etc/profile.d
# logfiles are stored in /tmp/history which can be reset with history_dir

history_dir=/tmp/history
history
USER_IP=`who -u am i 2>/dev/null | awk '{print $NF}' | sed -e 's/[()]//g'`

if [ $USER_IP == "" ]; then
	USER_IP=`hostname`
fi

if [ ! -d $history_dir ]; then
	mkdir $history_dir
	chmod 777 $history_dir
fi

if [ ! -d $history_dir/${LOGNAME} ]; then
	mkdir $history_dir/${LOGNAME}
	chmod 300 $history_dir/${LOGNAME}
fi

DT=`date +%Y%m%d_%H%M%S`
export HISTFILE="$history_dir/${LOGNAME}/${USER_IP} history.$DT"
chmod 600 $history_dir/${LOGNAME}/*history* 2>/dev/null
