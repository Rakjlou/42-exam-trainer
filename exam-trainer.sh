#!/bin/bash
VERSION="0.5";
TESTS_0=()
TESTS_1=("get_next_line" "ft_printf")

exam_enter_to_continue()
{
	read -sp "Press ENTER to continue..."
	echo
	echo
}

exam_print_elapsed_time()
{
	echo "$(tput setaf 244)$1$(tput sgr 0) $(( ${2} / 3600 ))h $(( (${2} / 60) % 60 ))m $(( ${2} % 60 ))s"
}

exam_print_current_test()
{
	echo "$(tput setaf 244)level:$(tput sgr 0)       $1"
	echo "$(tput setaf 244)test:$(tput sgr 0)        $2"
	echo "$(tput setaf 244)folder:$(tput sgr 0)      work/$2"
}

exam_print_help()
{
	echo "commands:"
	echo "    $(tput setaf 244)grademe, g$(tput sgr 0) run tests and maybe try to be worthwile"
	echo "    $(tput setaf 244)status, s$(tput sgr 0)  display elapsed time"
	echo "    $(tput setaf 244)skip, sk$(tput sgr 0)   skips to next test"
	echo "    $(tput setaf 244)quit, q$(tput sgr 0)    leaves the exam"
	echo "    $(tput setaf 244)help, h$(tput sgr 0)    duh"
	echo
}

exam_print_status()
{
	total_time_elapsed=$(($1 - $2));
	test_time_elapsed=$(($1 - $3));
	exam_print_elapsed_time "total time  " $total_time_elapsed
	exam_print_elapsed_time "test time   " $test_time_elapsed
	echo
}

exam_confirm()
{
	echo "$(tput setaf 3)work/ will be reset$(tput sgr 0)"
	read -p "Are you ready to start ? [yN]" response
	echo

	if [ -z $response ] || [ $response = "n" ] || [ $response = "N" ]
	then
		return 1
	elif [ $response = "y" ] || [ $response = "Y" ]
	then
		return 0
	else
		exam_confirm
	fi
}

exam_setup()
{
	rm -rf work/ *.trace && \
	echo "$(tput setaf 244)rm -rf work/ *.trace$(tput sgr 0)" && \
	mkdir work && \
	echo "$(tput setaf 244)mkdir work$(tput sgr 0)" && \
	local all_tests=()
	all_tests+=(${TESTS_0[@]})
	all_tests+=(${TESTS_1[@]})
	for test in ${all_tests[@]}
	do
		cd $test
		bash clean.sh
		cd - >/dev/null
		echo "$(tput setaf 244)$test/clean.sh$(tput sgr 0)"
	done
	echo
}

test_exo()
{
	cd $1 >/dev/null
	bash test.sh
	if	[ $? -eq 0 ]
	then
		cd - >/dev/null
		echo "$(tput setaf 2)>>>>>SUCCESS<<<<<$(tput sgr 0)"
		return 0
	else
		cd - >/dev/null
		echo "$(tput setaf 1)>>>>>FAILURE<<<<<$(tput sgr 0)"
		return 1
	fi
}

exam_start()
{
	local start_human=$(date +"%c");
	local start_timestamp=$(date +"%s");
	local exam_tests=()

	echo "You're all set !"
	echo "The exam will start after all this... hopefully"
	echo "$(tput smul)Remember:$(tput rmul)"
	echo "    $(tput setaf 2)work/$(tput sgr 0)"
	echo "        you put your files there"
	echo "    $(tput setaf 2)grademe$(tput sgr 0)"
	echo "        is just pure adrenaline rush"
	echo "    $(tput setaf 2)help$(tput sgr 0)"
	echo "        in case you're drunk or new around here"
	echo "    $(tput setaf 2)TESTNAME/compile.sh$(tput sgr 0)"
	echo "    $(tput setaf 2)TESTNAME/test.sh$(tput sgr 0)"
	echo "        can be triggered manually for debugging purposes and could be useful"
	echo
	echo "Take a deep breath and..."
	exam_enter_to_continue
	echo "================================================="
	echo "$(tput setaf 244)Exam started $start_human$(tput sgr 0)"

	for level in 0 1
	do
		case $level
		in
			0) exam_tests=($(shuf -e "${TESTS_0[@]}")) ;;
			1) exam_tests=($(shuf -e "${TESTS_1[@]}")) ;;
			*)
				echo "$level is in invalid level"
				return 1;
				;;
		esac
		for i in ${!exam_tests[@]}
		do
			local test_name=${exam_tests[i]};
			local test_start_timestamp=$(date +"%s");

			exam_print_current_test $level $test_name
			echo
			while [ 42 -eq 42 ]
			do
				read -p "$(tput setaf 244)exam-trainer$(tput sgr 0)> " user_cmd
				if [ -z $user_cmd ]
				then
					continue
				elif [ $user_cmd = "quit" ] ||  [ $user_cmd = "q" ]
				then
					return 1
				elif [ $user_cmd = "skip" ]  ||  [ $user_cmd = "sk" ]
				then
					read -p "Are you sure you want to skip $test_name ? [yN]" answer

					if [ -z $answer ] || [ $answer = "n" ] || [ $answer = "N" ]
					then
						continue
					elif [ $answer = "y" ] || [ $answer = "Y" ]
					then
						break
					fi
				elif [ $user_cmd = "help" ]  ||  [ $user_cmd = "h" ]
				then
					exam_print_help
				elif [ $user_cmd = "status" ]  ||  [ $user_cmd = "s" ]
				then
					echo "status:"
					exam_print_current_test $level $test_name | sed -e "s/.*/    &/"
					exam_print_status $(date +"%s") $start_timestamp $test_start_timestamp  | sed -e "s/.*/    &/"
				elif [ $user_cmd = "grademe" ]  ||  [ $user_cmd = "g" ]
				then
					read -p "Are you sure you want to be graded ? [yN]" answer
					echo

					if [ -z $answer ] || [ $answer = "n" ]  || [ $answer = "N" ]
					then
						continue
					elif [ $answer = "y" ]  || [ $answer = "Y" ]
					then
						echo "$(tput setaf 244)testing $test_name (it may take a while)...$(tput sgr 0)"
						if test_exo $test_name
						then
							total_time_elapsed=$(($(date +"%s") - $test_start_timestamp));
							exam_print_elapsed_time "finished in " $total_time_elapsed
							break
						fi
					else
						continue
					fi
				else
					echo "Unknown command"
					echo "Type help if you're lost"
				fi
			done
		done
	done
	total_time_elapsed=$(($(date +"%s") - $start_timestamp));
	exam_print_elapsed_time "total time  " $total_time_elapsed
}

exam()
{
	echo "$(tput smul)Exam Trainer by Rakjlou$(tput rmul) (v$VERSION)"
	echo

	if exam_confirm
	then
		echo
		exam_setup
		exam_start
	fi
	echo "Exam left"
}

exam
