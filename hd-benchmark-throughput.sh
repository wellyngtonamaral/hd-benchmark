#!/bin/bash

#############
# VARIABLES #
#############

# Define which mount point will be tested
MNT=( /mnt/test/test-dataset )

# Defines which block sizes will be tested
BS=( 4k 16k 64k 256k 1m)

# Defines which file size will be tested
GB=25GB

# Defines which operations will be tested
OP=( randread randwrite randrw read write readwrite )

# Defines how long (in seconds) each test will take
RT=300

# Headers to the CSV output file, it follows the FIO --minimal specification
# DO NOT CHANGE IT!
#HEADER="device;operation;block_BS;terse_version;fio_version;jobname;groupid;error;READ_kb;READ_bandwidth;READ_IOPS;READ_runtime;READ_Slat_min;READ_Slat_max;READ_Slat_mean;READ_Slat_dev;READ_Clat_max;READ_Clat_min;READ_Clat_mean;READ_Clat_dev;READ_clat_pct01;READ_clat_pct02;READ_clat_pct03;READ_clat_pct04;READ_clat_pct05;READ_clat_pct06;READ_clat_pct07;READ_clat_pct08;READ_clat_pct09;READ_clat_pct10;READ_clat_pct11;READ_clat_pct12;READ_clat_pct13;READ_clat_pct14;READ_clat_pct15;READ_clat_pct16;READ_clat_pct17;READ_clat_pct18;READ_clat_pct19;READ_clat_pct20;READ_tlat_min;READ_lat_max;READ_lat_mean;READ_lat_dev;READ_bw_min;READ_bw_max;READ_bw_agg_pct;READ_bw_mean;READ_bw_dev;WRITE_kb;WRITE_bandwidth;WRITE_IOPS;WRITE_runtime;WRITE_Slat_min;WRITE_Slat_max;WRITE_Slat_mean;WRITE_Slat_dev;WRITE_Clat_max;WRITE_Clat_min;WRITE_Clat_mean;WRITE_Clat_dev;WRITE_clat_pct01;WRITE_clat_pct02;WRITE_clat_pct03;WRITE_clat_pct04;WRITE_clat_pct05;WRITE_clat_pct06;WRITE_clat_pct07;WRITE_clat_pct08;WRITE_clat_pct09;WRITE_clat_pct10;WRITE_clat_pct11;WRITE_clat_pct12;WRITE_clat_pct13;WRITE_clat_pct14;WRITE_clat_pct15;WRITE_clat_pct16;WRITE_clat_pct17;WRITE_clat_pct18;WRITE_clat_pct19;WRITE_clat_pct20;WRITE_tlat_min;WRITE_lat_max;WRITE_lat_mean;WRITE_lat_dev;WRITE_bw_min;WRITE_bw_max;WRITE_bw_agg_pct;WRITE_bw_mean;WRITE_bw_dev;CPU_user;CPU_sys;CPU_csw;CPU_mjf;PU_minf;iodepth_1;iodepth_2;iodepth_4;iodepth_8;iodepth_16;iodepth_32;iodepth_64;lat_2us;lat_4us;lat_10us;lat_20us;lat_50us;lat_100us;lat_250us;lat_500us;lat_750us;lat_1000us;lat_2ms;lat_4ms;lat_10ms;lat_20ms;lat_50ms;lat_100ms;lat_250ms;lat_500ms;lat_750ms;lat_1000ms;lat_2000ms;lat_over_2000ms;disk_name;disk_read_iops;disk_write_iops;disk_read_merges;disk_write_merges;disk_read_ticks;write_ticks;disk_queue_time;disk_utilization"
HEADER="device;operation;block_BS;terse_version;fio_version;jobname;groupid;error;READ_kb;READ_bandwidth;READ_IOPS;READ_runtime;READ_Slat_min;READ_Slat_max;READ_Slat_mean;READ_Slat_dev;READ_Clat_max;READ_Clat_min;READ_Clat_mean;READ_Clat_dev;READ_clat_pct01;READ_clat_pct02;READ_clat_pct03;READ_clat_pct04;READ_clat_pct05;READ_clat_pct06;READ_clat_pct07;READ_clat_pct08;READ_clat_pct09;READ_clat_pct10;READ_clat_pct11;READ_clat_pct12;READ_clat_pct13;READ_clat_pct14;READ_clat_pct15;READ_clat_pct16;READ_clat_pct17;READ_clat_pct18;READ_clat_pct19;READ_clat_pct20;READ_tlat_min;READ_lat_max;READ_lat_mean;READ_lat_dev;READ_bw_min;READ_bw_max;READ_bw_agg_pct;READ_bw_mean;READ_bw_dev;WRITE_kb;WRITE_bandwidth;WRITE_IOPS;WRITE_runtime;WRITE_Slat_min;WRITE_Slat_max;WRITE_Slat_mean;WRITE_Slat_dev;WRITE_Clat_max;WRITE_Clat_min;WRITE_Clat_mean;WRITE_Clat_dev;WRITE_clat_pct01;WRITE_clat_pct02;WRITE_clat_pct03;WRITE_clat_pct04;WRITE_clat_pct05;WRITE_clat_pct06;WRITE_clat_pct07;WRITE_clat_pct08;WRITE_clat_pct09;WRITE_clat_pct10;WRITE_clat_pct11;WRITE_clat_pct12;WRITE_clat_pct13;WRITE_clat_pct14;WRITE_clat_pct15;WRITE_clat_pct16;WRITE_clat_pct17;WRITE_clat_pct18;WRITE_clat_pct19;WRITE_clat_pct20;WRITE_tlat_min;WRITE_lat_max;WRITE_lat_mean;WRITE_lat_dev;WRITE_bw_min;WRITE_bw_max;WRITE_bw_agg_pct;WRITE_bw_mean;WRITE_bw_dev;CPU_user;CPU_sys;CPU_csw;CPU_mjf;PU_minf;iodepth_1;iodepth_2;iodepth_4;iodepth_8;iodepth_16;iodepth_32;iodepth_64;lat_2us;lat_4us;lat_10us;lat_20us;lat_50us;lat_100us;lat_250us;lat_500us;lat_750us;lat_1000us;lat_2ms;lat_4ms;lat_10ms;lat_20ms;lat_50ms;lat_100ms;lat_250ms;lat_500ms;lat_750ms;lat_1000ms;lat_2000ms;lat_over_2000ms"

echo "The selected mount points are: "${MNT[*]}

rm -fr ./out/*

for D in "${MNT[@]}"
do
	for T in "${OP[@]}"
	do
		for S in "${BS[@]}"
		do
			O=`echo $D | sed 's/\\//_/g'`
			OUT="./out/$O-$T-$S"
			touch $OUT
			sudo fio --filename=$D/hd-benchmark-throughput-$OP --size=$GB --direct=1 --rw=$T --bs=$S --ioengine=libaio --iodepth=64 --runtime=$RT --numjobs=4 --time_based --group_reporting --name=throughput-$OP-job --output=$OUT --output-format=terse --minimal && rm $D/hd-benchmark-throughput-$OP
			echo -e "$HEADER\n$O;$T;$S;$(cat $OUT)" > $OUT

		done
	done
done
