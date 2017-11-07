#!/bin/sh

../src/sandbox -e exit0
if [ $? -ne 0 ]; then
	exit 1
fi
