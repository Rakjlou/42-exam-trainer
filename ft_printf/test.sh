#!/bin/bash
_test_count=0

test_ft_printf()
{
	local test_name="test_$_test_count"
	local test_file="$test_name.test"
	local ref_file="$test_name.ref"
	local error_file="$test_name.error"
	local diff_file="$test_name.diff"

	bash compile.sh || return 1

	echo -n "$(tput setaf 244)#$_test_count test $(tput sgr 0)"
	_test_count=$(( (_test_count + 1) ))

	valgrind --leak-check=full ./a.out.mine > "$test_file" 2> "$error_file"
	./a.out.ref > "$ref_file" 2> /dev/null
	if	diff --unified=0 "$ref_file" "$test_file" > "$diff_file"
	then
		leaks_check=$(cat $error_file | grep "no leaks are possible" | wc -l)

		if [ $leaks_check -gt 0 ]
		then
			echo "$(tput setaf 2)OK$(tput sgr 0)"
			bash clean.sh
			return 0
		else
			echo "$(tput setaf 1)LEAKS$(tput sgr 0)"
			cat $error_file
			return 1
		fi
	else
		echo "$(tput setaf 1)FAIL$(tput sgr 0)"
		cat $diff_file
		return 1
	fi
}

test_ft_printf