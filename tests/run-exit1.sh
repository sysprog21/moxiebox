#!/bin/sh

../src/sandbox -e exit1
if [ $? -ne 1 ]; then
	exit 1
fi
