# hd-bechmark

This repository contains a collection of simple Linux command line scripts to perform benchmarks of spinning disks.

The available scripts are:

hd-benchmark-iops.sh - it runs tests directly on the physical device and tests disk performance, abstracting the operating system and file system aspects.

hd-benchmark-throughput.sh - it runs tests file system and/or a disk array.

> [!CAUTION]
> These scripts can cause irreparable damage to the file system if you select devices in use.s
