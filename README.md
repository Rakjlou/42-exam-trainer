
  

# 42-exam-trainer
A quick and easy program to train 42 exams.
Only exam 02 is supported for now.
Currently WIP.
## Install
- Dependencies:  `gcc`, `valgrind` and `ts`
- Setup: just clone the repository where you want
## Usage
```bash
./exam-trainer.sh
```
Now don't say `LET'S GO !!` to anyone, and you should be good.

## Features
- Freely inspired by `examshell`
	- `grademe` runs tests
	- `status` prints the time spent overall and on the current test
	- `help` prints all available commands
	- `quit` quits the exam
- Extensive error details (compilation errors, runtime, diffs, leaks)
- Simple tests, just like during the exams
- Easily recompile and rerun tests outside the trainer
- Checking leaks
- Easy to tweak
- Passive aggressive humor

### Upcoming features
- Finally determining `bash`'s minimum required version 
- Adding level 1 tests (`inter` and `union`)
- Adding tests subjects
- Exam mode, where only one test is chosen by level
- Allowing to skip a test
- Allowing to chose only one test to pass
- History
- Keeping high time score records
- A mode where I shut up


### Contributing
Do it !

## Screenshots
![nice screenshot of the program running smoothly](https://i.ibb.co/37cpDMt/image.png)![fantastic sceenshot of the program being nice](https://i.ibb.co/yWG5ybt/image.png)

## LICENSE
```
/*
 * ----------------------------------------------------------------------------
 * "THE SANDWICH-WARE LICENSE" (Revision 42):
 * <nsierra-@student.42.fr> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a sandwich in return. Rakjlou
 * ----------------------------------------------------------------------------
 */
```
