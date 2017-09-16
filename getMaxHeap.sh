# This will get you the following info in CSV format:
#   1- Percentage of Xmx reached by heap (maximum heap size reached)
#   2- File name
#   3- Xmx set in KBytes
#   4- Maximum heap reached in KBytes
#!/bin/bash

if [[ $1 == '-h' ]]; then
  echo ;
  echo "Usage: `basename $0`"
  echo ;
  echo "No parameters:"
  echo "          Retrieves the Xmx and MaxHeap for all files terminating in .log in the current directory"
  echo ;
  echo "-f <file>:"
  echo "          Retrieves the Xmx and MaxHeap for <file>"
  echo ;
  echo "-h :"
  echo "          Shows this message"
  echo ;
  exit ;
fi

echo "%Used;Launcher;Xmx(MB);MaxHeap(MB)"

if [[ $1 == '-f' ]]; then
  FILES=$2
else
  FILES=`ls *.log`
fi

for file in $FILES;
  do
  # echo $file;
  XMX=`egrep -o 'Xmx[0-9]+.' $file | \
    sed -e 's/Xmx//' | \
    sed -e 's/g\|G/*1024m/' | \
    sed -e 's/m\|M/*1024/' | \
    bc | \
    sort -n | \
    tail -1
    `
  if [[ -z $XMX ]]; then
    XMX="N/A"
  else
      XMX=`echo "scale=2; $XMX/1024" | bc -l 2> /dev/null`
  fi
  MAX_HEAP=`egrep -o '\] [0-9]+K->[0-9]+K\([0-9]+K\)|GC [0-9]+K->[0-9]+K\([0-9]+K\)' $file | \
    egrep -o '[0-9]+K' | \
    tr 'K' ' ' | \
    sort -nr | \
    head -1`
  if [[ -z $MAX_HEAP ]]; then
    MAX_HEAP="N/A"
  else
    MAX_HEAP=`echo "scale=2; $MAX_HEAP/1024" | bc -l 2> /dev/null`
  fi
  if [[ -z $PERCENT_USED ]]; then
    PERCENT_USED="N/A"
  else
    PERCENT_USED=`echo "scale=2; $MAX_HEAP/$XMX *100" | bc -l 2> /dev/null`
  fi
  echo "$PERCENT_USED;$file;$XMX;$MAX_HEAP" >> out.tmp
done

sort -n out.tmp
rm out.tmp
