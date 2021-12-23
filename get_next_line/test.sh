#!/bin/bash
print_test_summary()
{
	echo "    $(tput setaf 244)file $(tput sgr 0)$2 $(tput setaf 244)buffer_size $(tput sgr 0)$1"
}

test_get_next_line()
{
	./compile.sh $1 || return 1
	valgrind ./test < $2 > "$2.$1.test" 2> "$2.$1.valgrind"
	diff $2 "$2.$1.test" > "$2.$1.diff"
	if	[ $? -eq 0 ]
	then
		leaks_check=$(cat "$2.$1.valgrind" | grep "no leaks are possible" | wc -l)

		if [ $leaks_check -gt 0 ]
		then
			rm -f "$2.$1.test" "$2.$1.valgrind" "$2.$1.diff"
			return 0
		else
			print_test_summary $1 $2
			cat "$2.$1.valgrind"
			return 1
		fi
	else
		print_test_summary $1 $2
		cat "$2.$1.diff"
		return 1
	fi
	rm -f test
}

test_get_next_line 1 main.c &&
	test_get_next_line 1 empty && \
	test_get_next_line 1 nlonly && \
	test_get_next_line 18 main.c && \
	test_get_next_line 18 empty && \
	test_get_next_line 18 nlonly && \
	test_get_next_line 17 main.c && \
	test_get_next_line 17 empty && \
	test_get_next_line 17 nlonly && \
	test_get_next_line 19 main.c && \
	test_get_next_line 19 empty && \
	test_get_next_line 19 nlonly && \
	test_get_next_line 4096 main.c && \
	test_get_next_line 4096 empty && \
	test_get_next_line 4096 nlonly && \
	test_get_next_line 4096 bible.txt
