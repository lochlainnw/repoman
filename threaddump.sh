#!/bin/sh

#Author: Lochlainn Wilkinson

#Make sure you have set JAVA_HOME

#Create thread dumps a specified number of times (i.e. LOOP) and INTERVAL.

#Thread dumps will be collected in the file "jcmd_threaddump.out", in the directory "/scripts/threaddumps/"

#   Usage:

#          ./threaddumps.sh [-t] [-p] [-g] [-v]

#

#   Example:

#   App PID is "5752" and you would like Garbage Collection dumps,  run this utility as following:

#

#   "/scripts/threaddump.sh -g"

################################################################################################

 

if [ $# -eq 0 ];

then

                echo "##########################################################################################"

                echo "No options were specified. Usage threaddumps.sh:  [-t] [-p] [-g] [-v]"

                echo "[-h] gives this help"

                echo "-t for Threaddump, -p for HeapDump, -g for Garbage Collection, -v VM.system_properties"

                echo "##########################################################################################"

 

    exit 0

 

else

while getopts ":tpghv" opt; do

TIME=`date +%b-%d-%y`

# Number of times to collect data. Means total number of thread dumps.

LOOP=10

 

location=/scripts/threaddumps/

 

# Interval in seconds between data points.

INTERVAL=10

 

# Where to generate the threddump & top output files.

WHERE_TO_GENERATE_OUTPUT_FILES="/scripts/threaddumps/"

 

# Find the app PID

APP_PID=$(ps aux | grep -i app | grep -i java | awk  -F '[ ]*' '{print $2}')

 

# Setting Java Home, by giving the path where your JDK is kept

JAVA_HOME=/java

 

#getopts script

 

case $opt in

        t)

echo "############################## Thread Dump selected ##############################"

echo "cleaning up the threaddumps logs directory"

rm -f $(location)

echo "Writing jcmd data log files to Directory:  $WHERE_TO_GENERATE_OUTPUT_FILES"

 

for ((i=1; i <= $LOOP; i++))

  do

    $JAVA_HOME/bin/jcmd $APP_PID  Thread.print >> $WHERE_TO_GENERATE_OUTPUT_FILES/jcmd_threaddump.out

    _now=$(date)

    echo "${_now}" >> $WHERE_TO_GENERATE_OUTPUT_FILES/top_highcpu.out

 

#If you see error like "top: -p argument missing", it means you don't have any java program running, i.e. the pgrep has no output.

    top -b -n 1 -H -p $APP_PID >> $WHERE_TO_GENERATE_OUTPUT_FILES/top_highcpu.out

    echo "Collected 'top' output and Thread Dump #" $i

    if [ $i -lt $LOOP ]; then

        echo "Sleeping for $INTERVAL seconds."

        sleep $INTERVAL

    fi

done

echo "Zipping up all of the files into one ............."

tar cvfzP $(location)threadumps$TIME.tar.gz $(location)*

        ;;

        p)

echo "############################## Heap Dump selected ##############################"

echo "cleaning up the threaddumps logs directory"

rm -f $(location)*

echo "Writing jcmd data log files to Directory:  $WHERE_TO_GENERATE_OUTPUT_FILES"

 

for ((i=1; i <= $LOOP; i++))

  do

    $JAVA_HOME/bin/jcmd $APP_PID  GC.heap_dump $WHERE_TO_GENERATE_OUTPUT_FILES/jcmd_GC.heap_dump.out

    _now=$(date)

    echo "${_now}" >> $WHERE_TO_GENERATE_OUTPUT_FILES/top_highcpu.out

 

#If you see error like "top: -p argument missing", it means you don't have any java program running, i.e. the pgrep has no output.

   top -b -n 1 -H -p $APP_PID >> $WHERE_TO_GENERATE_OUTPUT_FILES/top_highcpu.out

    echo "Collected 'top' output and Thread Dump #" $i

    if [ $i -lt $LOOP ]; then

        echo "Sleeping for $INTERVAL seconds."

        sleep $INTERVAL

    fi

done

echo "Zipping up all of the files into one ............."

tar cvfzP $(location)threadumps$TIME.tar.gz $(location)*

        ;;

        g)

echo "############################## Garbage Collection selected ##############################"

echo "cleaning up the threaddumps logs directory"

rm -f $(location)*

echo "Writing jcmd data log files to Directory:  $WHERE_TO_GENERATE_OUTPUT_FILES"

 

for ((i=1; i <= $LOOP; i++))

  do

    $JAVA_HOME/bin/jcmd $APP_PID  GC.run >> $WHERE_TO_GENERATE_OUTPUT_FILES/jcmd_GC.run.out

    _now=$(date)

    echo "${_now}" >> $WHERE_TO_GENERATE_OUTPUT_FILES/top_highcpu.out

 

#If you see error like "top: -p argument missing", it means you don't have any java program running, i.e. the pgrep has no output.

    top -b -n 1 -H -p $APP_PID >> $WHERE_TO_GENERATE_OUTPUT_FILES/top_highcpu.out

    echo "Collected 'top' output and Thread Dump #" $i

    if [ $i -lt $LOOP ]; then

        echo "Sleeping for $INTERVAL seconds."

        sleep $INTERVAL

    fi

done

echo "Zipping up all of the files into one ............."

tar cvfzP $(location)threadumps$TIME.tar.gz $(location)*

        ;;

        h)

echo "############################## HELP selected #############################################"

echo "No options were specified. Usage threaddumps.sh:  [-t] [-p] [-g] [-v]"

echo "-h gives this help"

echo "-t for Threaddump, -p for HeapDump, -g for Garbage Collection, -v VM.system_properties"

echo "##########################################################################################"

        ;;

        v)

echo "############################## VM.system_properties selected ##############################"

echo "cleaning up the threaddumps logs directory"

rm -f $(location)*

echo "Writing jcmd data log files to Directory:  $WHERE_TO_GENERATE_OUTPUT_FILES"

 

for ((i=1; i <= $LOOP; i++))

  do

    $JAVA_HOME/bin/jcmd $APP_PID  VM.system_properties >> $WHERE_TO_GENERATE_OUTPUT_FILES/jcmd_VM.system_properties.out

    _now=$(date)

    echo "${_now}" >> $WHERE_TO_GENERATE_OUTPUT_FILES/top_highcpu.out

 

#If you see error like "top: -p argument missing", it means you don't have any java program running, i.e. the pgrep has no output.

    top -b -n 1 -H -p $APP_PID >> $WHERE_TO_GENERATE_OUTPUT_FILES/top_highcpu.out

   echo "Collected 'top' output and Thread Dump #" $i

    if [ $i -lt $LOOP ]; then

        echo "Sleeping for $INTERVAL seconds."

        sleep $INTERVAL

    fi

done

echo "Zipping up all of the files into one ............."

tar cvfzP $(location)threadumps$TIME.tar.gz $(location)*

 

exit 1

                ;;

 

          *)

echo "############################## - Wrong option selected ##############################"

                exit 1

                ;;

        esac

done

 

fi
