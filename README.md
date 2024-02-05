# hd-bechmark

This repository is a collection of simple command line scripts to perform benchmarks of spinning disks.

There are two scripts:

hd-benchmark-iops.sh - it runs tests directly on the physical device and tests disk performance, abstracting the operating system and file system aspects.

hd-benchmark-throughput.sh - it runs tests file system and/or a disk array.

> [!CAUTION]
> These scripts can cause irreparable damage to the file system if you select devices in use.s
