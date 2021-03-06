Octopus
=========
Octopus is a commandline tool for running the same command on multiple remote hosts in parallel.

[![Build Status](https://travis-ci.com/BlaineEXE/octopus.svg?branch=master)](https://travis-ci.com/BlaineEXE/octopus)

Known Issues
--------------
There is a bug in openSUSE Leap 15.0 which likely affects all openSUSE distributions where octopus
will randomly fail to be able to execute on remote hosts as non-root users. Executing as the `root`
user seems to work appropriately.</br>
https://bugzilla.opensuse.org/show_bug.cgi?id=1115550

Theory
--------
Octopus is a simple tool inspired by `pdsh`'s ability to execute commands on multiple hosts in
parallel. In environments where `pdsh` cannot be installed, Go's ability to produce static binaries
is useful; thus, Octopus is written in Go. As long as one has the ability to `scp` or `rsync` files
to a host, a static `octopus` executable can be copied to it. A host may be a cluster admin node,
for example.

Octopus can execute arbitrary commands on multiple hosts in parallel, and hosts are grouped together
into "host groups" in a file which inspired by `pdsh`'s "genders" file. The host groups file for
Octopus is actually a Bash file with groups defined by variable definitions. A file which defines
host groups as Bash variables was chosen so that so that the same file may be used easily by both
Octopus and by user-made scripts.

Usage
-------
See `octopus [--help|-h]` for command usage.

An example host groups file can be found in the [config](config) directory.
