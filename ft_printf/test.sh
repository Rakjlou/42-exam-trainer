#!/bin/bash

test_ft_printf()
{
	./compile.sh || return 1
	valgrind ./a.out.mine > test.mine.out 2> test.mine.valgrind
	./a.out.ref > test.ref.out
	diff test.ref.out test.mine.out > test.diff
	if [ $? -eq 0 ]
	then
		leaks_check=$(cat "test.mine.valgrind" | grep "no leaks are possible" | wc -l)

		if [ $leaks_check -gt 0 ]
		then
			./clean.sh
			return 0
		else
			cat "test.mine.valgrind"
			return 1
		fi
	else
		cat test.diff
		return 1
	fi
}

test_ft_printf
