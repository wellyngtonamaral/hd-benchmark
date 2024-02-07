#!/bin/bash

########################################################################################################
# CAUTION: This script can cause irreparable damage to the file system if you select devices in use. #
########################################################################################################

###############
# DESCRIPTION #
###############
# I created this script to perform the IOPS benchmark of my spinning disks.
# It runs directly against the physical device and tests the performance of the disk directly abstracting the OS and file system aspects.
# Using this it is possible to find out the speed of the disk and also the performance of the disk/disk controller interface.
# In the end it is possible to summarize all results in a single CSV file and compare multiple disks.
# You can use the hd-benchmark-throughput.sh to test the file system and/or a disk array.

#########
# TO-DO #
#########
# Create inline parameters.
# Create an estimated runtime message. To define the estimated (it is exactly actually) time you should multiply # of devices * # of tests * # of block-size * runtime you define for each test.
#	So:
#		DEVICE=( /dev/sda /dev/sdb /dev/sdd /dev/sde /dev/sdf ) -> 5
#		TEST=( randread randwrite randrw read write readwrite ) -> 6
#		SIZE=( 4k 16k 256k 1m) -> 4
#		RT=300 -> 300
#	Then: 5*6*4*300 = 360000s or /60 = 600MI or /60/60 = 10H
# Define automatically the devices available
# Check if the device is mounted or not to avoid accidentally data lost 

###########
# CREDITS #
###########

#This script is a collection of other projects such as:
# https://docs.oracle.com/en-us/iaas/Content/Block/References/samplefiocommandslinux.htm
# https://github.com/amarao/fio_minimal_csv_header
# https://linuxconfig.org/bash-script-yes-no-prompt-example

#############
# VARIABLES #
#############

# Which test do you want to perform
TEST=( randread randwrite randrw read write readwrite )

# Which block size do you want to use
SIZE=( 4k 16k 256k 1m)

# How long each test will run
RT=300

# Headers to the CSV output file, it follows the FIO --minimal specification
HEADER="device;operation;block_size;terse_version;fio_version;jobname;groupid;error;READ_kb;READ_bandwidth;READ_IOPS;READ_runtime;READ_Slat_min;READ_Slat_max;READ_Slat_mean;READ_Slat_dev;READ_Clat_max;READ_Clat_min;READ_Clat_mean;READ_Clat_dev;READ_clat_pct01;READ_clat_pct02;READ_clat_pct03;READ_clat_pct04;READ_clat_pct05;READ_clat_pct06;READ_clat_pct07;READ_clat_pct08;READ_clat_pct09;READ_clat_pct10;READ_clat_pct11;READ_clat_pct12;READ_clat_pct13;READ_clat_pct14;READ_clat_pct15;READ_clat_pct16;READ_clat_pct17;READ_clat_pct18;READ_clat_pct19;READ_clat_pct20;READ_tlat_min;READ_lat_max;READ_lat_mean;READ_lat_dev;READ_bw_min;READ_bw_max;READ_bw_agg_pct;READ_bw_mean;READ_bw_dev;WRITE_kb;WRITE_bandwidth;WRITE_IOPS;WRITE_runtime;WRITE_Slat_min;WRITE_Slat_max;WRITE_Slat_mean;WRITE_Slat_dev;WRITE_Clat_max;WRITE_Clat_min;WRITE_Clat_mean;WRITE_Clat_dev;WRITE_clat_pct01;WRITE_clat_pct02;WRITE_clat_pct03;WRITE_clat_pct04;WRITE_clat_pct05;WRITE_clat_pct06;WRITE_clat_pct07;WRITE_clat_pct08;WRITE_clat_pct09;WRITE_clat_pct10;WRITE_clat_pct11;WRITE_clat_pct12;WRITE_clat_pct13;WRITE_clat_pct14;WRITE_clat_pct15;WRITE_clat_pct16;WRITE_clat_pct17;WRITE_clat_pct18;WRITE_clat_pct19;WRITE_clat_pct20;WRITE_tlat_min;WRITE_lat_max;WRITE_lat_mean;WRITE_lat_dev;WRITE_bw_min;WRITE_bw_max;WRITE_bw_agg_pct;WRITE_bw_mean;WRITE_bw_dev;CPU_user;CPU_sys;CPU_csw;CPU_mjf;PU_minf;iodepth_1;iodepth_2;iodepth_4;iodepth_8;iodepth_16;iodepth_32;iodepth_64;lat_2us;lat_4us;lat_10us;lat_20us;lat_50us;lat_100us;lat_250us;lat_500us;lat_750us;lat_1000us;lat_2ms;lat_4ms;lat_10ms;lat_20ms;lat_50ms;lat_100ms;lat_250ms;lat_500ms;lat_750ms;lat_1000ms;lat_2000ms;lat_over_2000ms;disk_name;disk_read_iops;disk_write_iops;disk_read_merges;disk_write_merges;disk_read_ticks;write_ticks;disk_queue_time;disk_utilization"

# Define which devices will be tested
# Do not run FIO tests with a write workload (readwrite, randrw, write, trimwrite) directly against a device that is in use.
DEVICE=( /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf )

# Check if you are aware of the risks
echo "This script can cause irreparable damage to the file system if you select devices in use."
echo "The selected devices are: "${DEVICE[*]}

while true; do

read -p "Do you want to proceed? (y/n) " yn

case $yn in 
	[yY] ) 

		rm -fr /root/out/*
		
		for D in "${DEVICE[@]}"
		do
			for T in "${TEST[@]}"
			do
				for S in "${SIZE[@]}"
				do
						O=`echo $D | sed 's/\/dev\///g'`
						OUT="/root/out/$O-$T-$S"
						touch $OUT
						sudo fio --filename=$D --direct=1 --rw=$T --bs=$S --ioengine=libaio --iodepth=1 --numjobs=1 --time_based --group_reporting --name=readlatency-test-job --runtime=$RT --output=$OUT --output-format=terse --minimal
						echo -e "$HEADER\n$O;$T;$S;$(cat $OUT)" > $OUT
				done
			done
		done
	
		break;;
	[nN] ) echo exiting...;
		exit;;
	* ) echo invalid response;;
esac

done
