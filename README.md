# hd-benchmark

This repository contains a collection of simple Linux command lines to perform benchmarks of spinning disks.

The available scripts are:

**hd-benchmark-iops.sh** - it runs performance tests directly on the physical device, abstracting the operating system and file system aspects.

Using this is possible to find out the speed of the disk and also the performance of the disk interface/disk controller (i.e: PCIe SATA Controller or Port Multiplier).

In the end, you can summarize all results in a single CSV file and compare multiple disks.

**hd-benchmark-throughput.sh** - it runs tests file system and/or a disk array.

> [!CAUTION]
> These scripts can cause irreparable damage to the file system if you select devices in use.s

## Setup

Before running the test it is necessary to define the variables:

to **hd-benchmark-iops.sh**:

| Variable | Description | Value(s) |
| --- | --- | --- |
| DEV    | Defines which devices will be tested                                                    |  /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf   |
| BS     | Defines which block sizes will be tested                                                | 4k 16k 256k 1m                                  |
| OP     | Defines which operations will be tested                                                 | randread randwrite randrw read write readwrite  |
| RT     | Defines how long (in seconds) each test will take                                       | 300                                             |
| HEADER | Defines the headers to the CSV output file, it follows the FIO --minimal specification  | Do not change!                                  |

to **hd-benchmark-throughput.sh**:

| Variable | Description | Value(s) |
| --- | --- | --- |
| MNT    | Defines which devices will be tested                                                    |  /mnt/mount-point   |
| BS     | Defines which block sizes will be tested                                                | 4k 16k 256k 1m                                  |
| GB     | Defines which file size will be tested                                                  | 100GB                                  |
| OP     | Defines which operations will be tested                                                 | randread randwrite randrw read write readwrite  |
| RT     | Defines how long (in seconds) each test will take                                       | 300                                             |
| HEADER | Defines the headers to the CSV output file, it follows the FIO --minimal specification  | Do not change!                                  |

## Credits

https://docs.oracle.com/en-us/iaas/Content/Block/References/samplefiocommandslinux.htm

https://github.com/amarao/fio_minimal_csv_header

https://linuxconfig.org/bash-script-yes-no-prompt-example
