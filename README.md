# hd-benchmark

This repository contains a collection of simple Linux command lines to perform benchmarks of spinning disks.

The available scripts are:

**hd-benchmark-iops.sh** - it runs tests directly on the physical device and tests disk performance, abstracting the operating system and file system aspects.

Using this is possible to find out the speed of the disk and also the performance of the disk interface/disk controller (i.e: PCIe SATA Controller or Port Multiplier).

In the end, you can summarize all results in a single CSV file and compare multiple disks.

**hd-benchmark-throughput.sh** - it runs tests file system and/or a disk array.

> [!CAUTION]
> These scripts can cause irreparable damage to the file system if you select devices in use.s
