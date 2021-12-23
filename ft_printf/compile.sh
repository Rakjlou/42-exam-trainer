#!/bin/bash
gcc -Wall -Wextra -Werror -pedantic -g3 ../rendu/ft_printf/*.c main.c -o a.out.mine && \
gcc -Wall -Wextra -Werror -pedantic -g3 -D TEST_REF main.c -o a.out.ref
