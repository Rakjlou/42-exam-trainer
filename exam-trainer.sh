#!/bin/bash

##
# Globals
##
_version="1.0"
_program="Exam Trainer"
_author="rakjlou"

_tests=("inter" "union" "ft_printf" "get_next_line")
_exams=("exam02")
_modes=("all tests" "exam")

_exam="exam02"
_mode="all tests"
_user_dirname="work/"

_force_quit=0

_start=0
_level=0

_test=""
_test_success=0
_test_start=0

_tests_passed=()
_tests_passed_elapsed=()

_ifs=$IFS

##
# Utils
##

enter_to_continue()
{
	read -esp "(press ENTER to continue...)"
	eprint
}

##
# Configuration
##
configure_exam()
{
	eprint "Select the exam you want to train for:"
	eprint_indent++

	for i in ${!_exams[@]}
	do
		local current=${_exams[$i]}

		case $current
		in
			$_exam) eprint "$(tput setaf 1)*$(tput sgr 0)$(tput setaf 244)$i$(tput sgr 0) $current" ;;
			*) eprint "$(tput setaf 244)$i $(tput sgr 0) $current" ;;
		esac
	done

	eprint_indent--
	eprint
	read -ep "Pick a number (just type enter to ignore): " response

	if [ ! -z $response ]
	then
		local found=0

		for i in ${!_exams[@]}
		do
			if [ $i -eq $response ]
			then
				found=1
				_exam=${_exams[$i]}
			fi
		done
		if [ $found -eq 0 ]; then configure_exam; fi
	fi
	eprint_tput 244 "$_exam selected"
	eprint
}

configure_mode()
{
	eprint "Select the trainer's mode:"
	eprint_indent++

	for i in ${!_modes[@]}
	do
		local current=${_modes[$i]}
		local number_select=""
		local description=""

		case $current
		in
			$_mode) number_select="$(tput setaf 1)*$(tput sgr 0)$(tput setaf 244)$i$(tput sgr 0)" ;;
			*) number_select="$(tput setaf 244)$i $(tput sgr 0)" ;;
		esac

		case $current
		in
			"all tests") description="all tests for all levels";;
			"exam") description="only one test by level";;
		esac

		eprint "$number_select $current $(tput setaf 244)$description$(tput sgr 0)"
	done

	eprint_indent--
	eprint
	read -ep "Pick a number (just type enter to ignore): " response

	if [ ! -z $response ]
	then
		local found=0

		for i in ${!_modes[@]}
		do
			if [ $i -eq $response ]
			then
				found=1
				_mode=${_modes[$i]}
			fi
		done
		if [ $found -eq 0 ]; then configure_mode; fi
	fi
	eprint_tput 244 "$_mode selected"
	eprint
}

configure()
{
	configure_exam
	configure_mode
}

##
# Setting up
##
confirm()
{
	eprint "Config for current training:"
	eprint_1 "$(tput setaf 244)exam: $(tput sgr 0)$_exam"
	eprint_1 "$(tput setaf 244)mode: $(tput sgr 0)$_mode"
	eprint_tput 3 "$_user_dirname will be reset"
	read -ep "Are you ready to start ? (configure, yes, $(tput smul)no$(tput rmul)) [cyN]" response
	eprint

	case $response
	in
		""|"n"|"N"|"no"|"No") return 1 ;;
		"y"|"Y"|"yes"|"Yes") return 0 ;;
		"c"|"C"|"configure"|"Configure")
			eprint
			configure
			confirm
		;;
		*) confirm ;;
	esac
}

setup()
{
	eprint_grey "resetting $_user_dirname..."
	rm -rf $_user_dirname
	mkdir $_user_dirname

	for test in ${_tests[@]}
	do
		cd $test
		bash clean.sh
		cd - >/dev/null
		eprint_grey "$test/clean.sh"
	done
	eprint
}

##
# Printing
##
_indent_level=0

eprint_test()
{
	eprint_kv "level" "$_level" "test" "$_test" "folder" "work/$_test"
}

eprint_indent()
{
	local limit=$((${_indent_level} * 4))

	if [ $limit -lt 1 ]; then return; fi

	for i in $(seq 1 $limit); do echo -n " "; done;
}

eprint_indent++()
{
	_indent_level=$(( $_indent_level + 1 ))
}

eprint_indent--()
{
	_indent_level=$(( $_indent_level - 1 ))
}

eprint_indent_set()
{
	_indent_level=$1
}

eprint_tput()
{
	eprint "$(tput setaf $1)$2$(tput sgr 0)"
}

eprint_grey()
{
	eprint_tput 244 $1
}

eprint_kv()
{
	local maxlen=0
	local args=("$@")

	for i in ${!args[@]}
	do
		if [ $(( $i % 2 )) -eq 1 ]; then continue; fi

		local arg=${args[$i]}
		local len=${#args[$i]}

		if [ $len -gt $maxlen ]; then maxlen=$len; fi
	done

	local key=""
	local value=""
	local padding=0

	for i in ${!args[@]}
	do
		if [ $(( $i % 2 )) -eq 1 ]
		then
			value=${args[$i]}
			padding=$(( ((($maxlen - ${#key}) + 1) * 1) ))

			eprint_indent
			echo -n "$(tput setaf 244)$key:$(tput sgr 0)"
			for j in $(seq 1 $padding); do echo -n " "; done;
			echo "$value"

		else
			key=${args[i]}
		fi
	done

}

eprint()
{
	eprint_indent
	IFS=$''
	echo $1
	IFS=$_ifs
}

eprint_1()
{
	eprint_indent++
	eprint_indent
	eprint_indent--
	IFS=$''
	echo $1
	IFS=$_ifs
}

eprint_2()
{
	eprint_indent++
	eprint_indent++
	eprint_indent
	eprint_indent--
	eprint_indent--
	IFS=$''
	echo $1
	IFS=$_ifs
}

##
# Commands
##
cmd_grademe()
{
	read -ep "Are you sure you want to be graded ? [yN]" response
	eprint

	case $response
	in
		""|"n"|"N") return ;;
	esac

	if	bash test.sh
	then
		echo "$(tput setaf 2)>>>>>LET'S GOOOOO<<<<<$(tput sgr 0)"
		_test_success=1
		return 0
	else
		echo "$(tput setaf 1)>>>>>FAILURE<<<<<$(tput sgr 0)"
		return 1
	fi
}

cmd_status()
{
	local now=$(date +"%s")
	local elapsed=$(( ($now - $_start) ))
	local elapsed_human="$(( elapsed / 3600 ))h $(( (elapsed / 60) % 60 ))m $(( elapsed % 60 ))s"
	local elapsed_test=$(( ($now - $_test_start) ))
	local elapsed_test_human="$(( elapsed_test / 3600 ))h $(( (elapsed_test / 60) % 60 ))m $(( elapsed_test % 60 ))s"

	eprint_kv "level" "$_level" "test" "$_test" "folder" "work/$_test" "total time" "$elapsed_human" "test time" "$elapsed_test_human"
	eprint
}

cmd_skip()
{
	read -ep "Are you sure you want to skip this test ? [Yn]" response
	eprint

	case $response
	in
		""|"y"|"Y") _test_success=1	;;
	esac
}

cmd_quit()
{
	read -ep "Are you sure you want to quit ? [Yn]" response
	eprint

	case $response
	in
		""|"y"|"Y") _force_quit=1 ;;
	esac
}

cmd_help()
{
	eprint "available commands:"
	eprint_indent++
	eprint_kv "grademe, g" "runs all tests, try to move to next level" \
		"status, s" "prints current level infos, and timers" \
		"skip, sk" "skips to next test" \
		"quit, q" "quits the program" \
		"help, h" "prints this" \
		"compile, c" "compile files for the current test" \
		"test, t" "launch tests" \
		"clean, cl" "clean the test subfolder" \
		"subject, sub" "prints the subject"
	eprint_indent--
	eprint
}

cmd_subject()
{
	IFS=$''
	eprint_tput 6 `cat subject.txt`
	IFS=$_ifs
}

cmd_compile()
{
	bash compile.sh
}

cmd_test()
{
	bash test.sh
}

cmd_clean()
{
	bash clean.sh
}

##
# Main Loop
##
eprompt()
{
	read -ep "$(tput setaf 244)exam-trainer$(tput sgr 0)> " user_cmd

	case $user_cmd in
		"") return 0;;
		"grademe"|"g") cmd_grademe;;
		"status"|"s") cmd_status ;;
		"skip"|"sk") cmd_skip ;;
		"quit"|"q") cmd_quit ;;
		"help"|"h") cmd_help ;;
		"compile"|"c") cmd_compile ;;
		"test"|"t") cmd_test ;;
		"clean"|"cl") cmd_clean ;;
		"subject"|"sub") cmd_subject ;;
		*)
			eprint "Unknown command"
			eprint_1 "type $(tput setaf 244)help$(tput sgr 0) to get a list of available commands"
		;;
	esac
}

exam()
{
	_start=$(date +"%s")
	local start_human=`date +"%c" -ud @$_start`

	eprint "$(tput setaf 244)Exam started $start_human$(tput sgr 0)"

	while [ ! -z $1 ]
	do
		# Get level tests count
		local tests_count=$1
		shift

		# Retrieving and shuffling tests
		local args=("$@")
		local tests=($(shuf -e ${args[@]:0:$tests_count}))
		shift $tests_count

		# Doing tests
		_test_success=0
		for i in ${!tests[@]}
		do
			if [ $_force_quit -ne 0 ]; then continue;
			elif [[ $_test_success -ne 0 ]] && [[ $_mode = "exam" ]]; then continue;
			fi

			_test_success=0
			_test_start=$(date +"%s")
			_test=${tests[$i]}

			eprint_test
			eprint
			cd $_test
			while [ $_test_success -eq 0 ] && [ $_force_quit -eq 0 ]
			do
				eprompt
			done
			local elapsed_test=$(( $(date +"%s") - $_test_start ))
			local elapsed_human="$(( elapsed_test / 3600 ))h $(( (elapsed_test / 60) % 60 ))m $(( elapsed_test % 60 ))s"

			_tests_passed+=("$_test: $elapsed_human")
			eprint "$(tput setaf 244)You completed $_test in$(tput sgr 0) $elapsed_human !"
			cd - >/dev/null
		done

		_level=$(($_level + 1))
	done
}

start_message()
{
	eprint "================================================="
	eprint "You're all set !"
	eprint_1 "$_exam will start after all this... hopefully"
	eprint
	eprint "$(tput smul)Remember:$(tput rmul)"
	eprint_1	"$(tput setaf 2)work/$(tput sgr 0)"
	eprint_2		"you put your files there"
	eprint_1	"$(tput setaf 2)grademe$(tput sgr 0)"
	eprint_2		"is just pure adrenaline rush"
	eprint_1	"$(tput setaf 2)subject$(tput sgr 0)"
	eprint_2		"in order to print the subject"
	eprint_1	"$(tput setaf 2)help$(tput sgr 0)"
	eprint_2	"in case you're drunk or new around here"
	eprint_1	"$(tput setaf 2)compile$(tput sgr 0)"
	eprint_1	"$(tput setaf 2)test$(tput sgr 0)"
	eprint_2		"can be used manually"
	eprint
	eprint "Don't panic ! Take a deep breath and..."
	enter_to_continue
	eprint "================================================="
}

start()
{
	case $_exam
	in
		"exam02") exam 2 "union" "inter" 2 "ft_printf" "get_next_line" ;;
		*)
			echo "$_exam is an invalid exam"
			return 1;
			;;
	esac
}


eprint "$(tput smul)$_program$(tput rmul) by $_author - v$_version"
eprint

if confirm
then
	setup
	start_message
	start
fi

eprint "Exit exam."