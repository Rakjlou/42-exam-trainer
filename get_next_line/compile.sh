#!/bin/bash

gcc -Wall -Wextra -Werror -pedantic -g3 -I../rendu/get_next_line -D BUFFER_SIZE="$1" ../rendu/get_next_line/*.c main.c -o test
