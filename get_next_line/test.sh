#!/bin/bash
_test_count=0

test_get_next_line()
{
	local test_name="test_$_test_count"
	local test_file="$test_name.test"
	local ref_file="$test_name.ref"
	local error_file="$test_name.error"
	local diff_file="$test_name.diff"

	bash compile.sh $1 || return 1

	echo -n "$(tput setaf 244)#$_test_count test $(tput sgr 0)"
	_test_count=$(( (_test_count + 1) ))

	valgrind --leak-check=full ./a.out < $2 > "$test_file" 2> "$error_file"
	cat $2 | sed -e "s/.*/>>>&/" > "$ref_file"
	if	diff --unified=0 "$ref_file" "$test_file" > "$diff_file"
	then
		leaks_check=$(cat $error_file | grep "no leaks are possible" | wc -l)

		if [ $leaks_check -gt 0 ]
		then
			echo "$(tput setaf 2)OK$(tput sgr 0)"
			bash clean.sh
			return 0
		else
			echo "$(tput setaf 1)LEAKS$(tput sgr 0) with BUFFER_SIZE $1 and file $2"
			cat $error_file
			return 1
		fi
	else
		echo "$(tput setaf 1)FAIL$(tput sgr 0)  with BUFFER_SIZE $1 and file $2"
		cat $diff_file
		return 1
	fi
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