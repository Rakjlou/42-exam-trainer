#!/bin/bash
find .\
	! -name "main.c" \
	! -name "compile.sh" \
	! -name "test.sh" \
	! -name "clean.sh" \
	! -name "subject.txt" \
	! -name "." \
	-exec rm -f {} +
