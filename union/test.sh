#!/bin/bash
_test_count=0

test_union()
{
	local test_name="test_$_test_count"
	local test_file="$test_name.test"
	local ref_file="$test_name.ref"
	local error_file="$test_name.error"
	local diff_file="$test_name.diff"

	bash compile.sh || return 1

	echo -n "$(tput setaf 244)#$_test_count test $(tput sgr 0)"
	_test_count=$(( (_test_count + 1) ))

	echo "$3" > $ref_file
	valgrind --leak-check=full ./a.out "$1" "$2" > $test_file 2> $error_file
	if	diff --unified=0 $ref_file $test_file > $diff_file
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

test_union_args()
{
	local test_name="test_$_test_count"
	local test_file1="$test_name-1.test"
	local test_file2="$test_name-2.test"
	local ref_file="$test_name.ref"
	local error_file1="$test_name-1.error"
	local error_file2="$test_name-2.error"
	local diff_file1="$test_name-1.diff"
	local diff_file2="$test_name-2.diff"

	bash compile.sh || return 1

	echo -n "$(tput setaf 244)#$_test_count test$(tput sgr 0) "
	_test_count=$(( (_test_count + 1) ))

	echo "" > $ref_file
	valgrind --leak-check=full ./a.out  > "$test_file1" 2> "$error_file1"
	valgrind --leak-check=full ./a.out "mdr" > "$test_file2" 2> "$error_file2"
	if	diff --unified=0 $ref_file $test_file1 > $diff_file1
	then
		leaks_check=$(cat $error_file1 | grep "no leaks are possible" | wc -l)
		leaks_check2=$(cat $error_file2 | grep "no leaks are possible" | wc -l)

		if [ $leaks_check -gt 0 ] && [ $leaks_check2 -gt 0 ]
		then
			echo "$(tput setaf 2)OK$(tput sgr 0)"
			bash clean.sh
			return 0
		else
			echo "$(tput setaf 1)LEAKS$(tput sgr 0)"
			cat $error_file1
			cat $error_file2
			return 1
		fi
	else
		echo "$(tput setaf 1)FAIL$(tput sgr 0) (wrong gestion of argc)"
		cat $diff_file1
		cat $diff_file2
		return 1
	fi
}

test_union_args && \
test_union "zpadinton" "paqefwtdjetyiytjneytjoeyjnejeyj" "zpadintoqefwjy" && \
test_union "ddf6vewg64f" "gtwthgdwthdwfteewhrtag6h4ffdhsd" "df6vewg4thras" && \
test_union "" "" "" && \
test_union "abcdef" "ghiklmn" "abcdefghiklmn" && \
test_union "abcdef" "" "abcdef" && \
test_union "" "abcdef" "abcdef"
