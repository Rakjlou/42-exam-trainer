#!/bin/bash

gcc -Wall -Wextra -Werror -pedantic -g3 -I../work/get_next_line -D BUFFER_SIZE="$1" ../work/get_next_line/*.c main.c -o test
