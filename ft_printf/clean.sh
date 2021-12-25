find .\
	! -name "main.c" \
	! -name "bible.txt" \
	! -name "empty" \
	! -name "nlonly" \
	! -name "compile.sh" \
	! -name "test.sh" \
	! -name "clean.sh" \
	! -name "gnl.c" \
	! -name "." \
	! -name "subject.txt" \
	-exec rm -f {} +
