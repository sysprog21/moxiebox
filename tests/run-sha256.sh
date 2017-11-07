#!/bin/sh

srcdir=`pwd`

TFN=SHA256-TEST.tmp$$
BFN=$srcdir/random.data.sum

rm -f $FN

../src/sandbox -e sha256 -d $srcdir/random.data -o $TFN -p gmon.out
if [ $? -ne 0 ]; then
	exit 1
fi

cmp -s $TFN $BFN
RET=$?

echo
moxie-none-moxiebox-gprof -l sha256

rm -f $TFN gmon.out

if [ $RET -ne 0 ]; then
	exit 1
fi

exit 0
