#!/bin/sh

#title           :psloop.sh
#description     :Runs ps in a interval loop to collect process metrics (Rsize, Vsize, mem, time, cpu usage...)
#author          :fsgeorgee
#date            :20170918
#version         :0.1
#usage           :bash psloop.sh PID DELAY

PID=${1}
if [ "${PID}" = "" ]
then
  echo "Usage: psloop <pid> [<delay>]"
  echo "  -  pid   :  the process id, i.e. the PID of the session"
  echo "  -  delay :  the delay between two ps snapshots in seconds (default: 15)"
  echo ""
  echo "The generated output file is ps.<pid>.<delay>.loop.out."
  echo "This file contains the date & time of the snapshot and the ps statistics at this very moment."
  echo "You don't need the rights to execute the psloop utility on the process."
  echo ""
  exit 1
fi


DELAY=${2}
if [ "${DELAY}" = "" ]
then
  DELAY=15
fi

FILE=./ps.${PID}.${DELAY}.loop.out

ps -p ${PID} > /dev/null
ALIVE=$?
if  [ "${ALIVE}" = "0" ]
then
  echo "# process ..." >> ${FILE}
  if [ -f "/usr/ucb/ps" ] ; then CTITLE=`/usr/ucb/ps -auxwww ${PID}` ;
  else CTITLE=`ps auxwww | grep ${PID} | grep -v grep | grep -v psloop | head -1` ; fi ;
  echo "${CTITLE}" >> ${FILE}
  echo "# ps monitoring ..." >> ${FILE}
  HEADER=`ps -o user -o pid -o ppid -o vsz=VsizeKB -o rss=RsizeKB -o osz=VsizePG -o pmem -o time -o etime -o pcpu -o nlwp -o args -p ${PID} | head -1`
  echo " date              ${HEADER}" >> ${FILE}
fi
while [ "${ALIVE}" = "0" ]
do
  DATE=`date '+%y/%m/%d %H:%M:%S'`
  PSSTAT="$DATE `ps -o user -o pid -o ppid -o vsz=VsizeKB -o rss=RsizeKB -o osz=VsizePG -o pmem -o time -o etime -o pcpu -o nlwp -o args -p ${PID} | tail -1`"
  if [ "`echo $PSSTAT | wc -c | awk '{print $1}'`" -gt "192" ] ; then PSSTAT=${PSSTAT:0:192} ; fi ;
  echo "${PSSTAT}" >> ${FILE}
  sleep ${DELAY}
  ps -p ${PID} > /dev/null
  ALIVE=$?
done


