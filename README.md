# moxiebox

## Motivation

The goal of moxiebox is to provide a secure, sandboxed execution
mechanism that enables deterministic input, processing and output.
Execution is separated out into distinct phases:

1. Prepare and load hash-sealed program executables, data.
2. Execute program as a black box, with no I/O capability.
   Runs until exit or CPU budget exhausted (or CPU exception).
3. Gather processed data, if any.

A single thread of execution pre-loads necessary data, then simulates a
32-bit little endian Moxie CPU, running the loaded code.

This program is built using the "moxiebox" target in upstream binutils
and gcc.  A reduced (C-only) gcc toolchain is therefore available for
immediate use by developers.

From the Moxie program's point of view, it is a single thread running
as root and is essentially the entire operating system kernel +
application, all in a single wrapper.

From the sandbox's point of view, the application is running as an
unpriv'd application with only the ability to access data within the
hand-built memory map.

Check [sandbox execution environment](sandbox-design.md) for details.

More info about the Moxie architecture may be found as following:
* [Moxie Architecture](http://moxielogic.org/blog/pages/architecture.html)
* [Moxie Blog](http://moxielogic.org/blog)


## Prerequisites

You will need to build and install moxie binutils+gcc cross-compiler
toolchain first. It is suggested using derived [crosstool-ng](https://github.com/jserv/crosstool-ng):

    git clone https://github.com/jserv/crosstool-ng
    ./bootstrap
    ./configure
    make
    make install
    mkdir -p ~/build-toolchain
    cd ~/build-toolchain
    ct-ng moxie-none-moxiebox
    ct-ng build

After [crosstool-NG](https://crosstool-ng.github.io/docs/) builds everything
from scratch, you will get GNU toolchain for Moxiebox in directory
`$HOME/x-tools/moxie-none-moxiebox`. You can update `$PATH` via:

    source envsetup


## Build and verify sandbox

Once Moxiebox toolchain is properly installed, simply build with GNU make:

    make

And verify:

    make check


## Usage

Example usage of sandbox:

    $ src/sandbox \
          -e runtime/test1 \
          -d mydata.json \
          -d mydata2.dat \
          -o file.out

If you specify the -g <port> option, then sandbox will wait for a GDB
connection on the given port.  For example, run sandbox like so:

    $ src/sandbox -e tests/rtlib -g 9999
    ep 00001000
    ro 00000f8c-00001540 elf0
    rw 00001640-00001aa8 elf1
    rw 00002aa8-00012aa8 stack
    ro 00013aa8-00013b48 mapdesc
    
And, in a separate console, run GDB to connect to sandbox using the
`target remote` command like so:

    $ moxie-none-moxiebox-gdb -q tests/rtlib
    Reading symbols from basic...done.
    (gdb) target remote :9999
    Remote debugging using :9999
    0x00001000 in __start ()
    (gdb) b main
    Breakpoint 1 at 0x13da: file rtlib.c, line 73.
    (gdb) c
    Continuing.

    Breakpoint 1, main (argc=0, argv=0x2) at rtlib.c:73
    73	{
    (gdb) x/4i $pc
    => 0x13da <main>:	push	$sp, $r6
       0x13dc <main+2>:	push	$sp, $r7
       0x13de <main+4>:	dec	$sp, 0x38
       0x13e0 <main+6>:	ldi.l	$r2, 0x11
    (gdb)


## Licensing

`moxiebox` is freely redistributable under MIT X License.
Use of this source code is governed by the license that can be found
in the `LICENSE` file.
