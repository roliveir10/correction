#!/bin/bash

LIG="-l"
PA="../roliveir"

echo "\033[1;32m"
cat -e $PA/auteur

echo "====================================================================="
echo "============================ NORM CHECK  ============================"
echo "====================================================================="
echo "\033[0m"

read $VAR

make fclean -C $PA
norminette $PA

echo "\033[1;32m"
echo "====================================================================="
echo "======================== EXTENDED NORM CHECK ========================"
echo "====================================================================="
echo "\033[32m"

read $VAR

echo "End-Of-Line OPERATORS...\n\033[31m"
find $PA -name '*.c' -exec cat {} \; | grep "\+$"
find $PA -name '*.c' -exec cat {} \; | grep "\*$"
find $PA -name '*.c' -exec cat {} \; | grep "\-$"
find $PA -name '*.c' -exec cat {} \; | grep " \/$"
find $PA -name '*.c' -exec cat {} \; | grep "\&$"
find $PA -name '*.c' -exec cat {} \; | grep "\|$"
find $PA -name '*.c' -exec cat {} \; | grep "\%$"
find $PA -name '*.c' -exec cat {} \; | grep "\?$"
find $PA -name '*.c' -exec cat {} \; | grep "\=$"
find $PA -name '*.c' -exec cat {} \; | grep " \>$"
find $PA -name '*.c' -exec cat {} \; | grep "\<$"
find $PA -name '*.c' -exec cat {} \; | grep "\!$"
find $PA -name '*.c' -exec cat {} \; | grep "\:$"
echo "\033[32m"

echo "Code-Defining DEFINES...\n\033[31m"
find $PA -name '*.h' -exec cat {} \; | grep "define\(.\?\)*(\|define\(.\?\)*)\|define\(.\?\)*\\[\|define\(.\?\)*\\]"

echo "\033[1;32m"
echo "====================================================================="
echo "============================== MAKE ================================="
echo "====================================================================="
echo "\033[0m"

read $VAR

make re -C $PA
make clean -C $PA

echo "\033[1;32m"
echo "====================================================================="
echo "========================= ALLOWED FUNCTIONS ========================="
echo "====================================================================="

read $VAR

echo "Fonction autorisees:\nwrite\nread\nmalloc\nexit\nfree\nperror\nstrerror\033[0m"
nm -u $PA/lem-in

echo "\033[1;32m"
echo "====================================================================="
echo "============================== MALLOC ==============================="
echo "====================================================================="
echo "\033[0m"

read $VAR

find $PA -name '*.c' -exec cat {} \; | grep "join" -A1
find $PA -name '*.c' -exec cat {} \; | grep "strnew" -A1
find $PA -name '*.c' -exec cat {} \; | grep "strdup" -A1
find $PA -name '*.c' -exec cat {} \; | grep "malloc" -A1
find $PA -name '*.c' -exec cat {} \; | grep "lstnew" -A1
find $PA -name '*.c' -exec cat {} \; | grep "strsub" -A1
find $PA -name '*.c' -exec cat {} \; | grep "strtrim" -A1

echo "\033[1;32m"
echo "====================================================================="
echo "============================= INCLUDES =============================="
echo "====================================================================="
echo "\033[31m"

read $VAR

find $PA -name '*.c*' -exec cat {} \; | grep "stdio"
find $PA -name '*.h*' -exec cat {} \; | grep "stdio"

echo "\033[1;32m"
echo "====================================================================="
echo "============================= ERROR TEST ============================"
echo "====================================================================="
echo "\033[0m"

read $VAR
echo "\033[32mEmpty (Comm/D)\033[0m"
./$PA/"lem-in"
./$PA/"lem-in" < file/error1
./$PA/"lem-in" < file/error2
./$PA/"lem-in" < file/error3
./$PA/"lem-in" < file/error4
./$PA/"lem-in" < file/error5
./$PA/"lem-in" < file/error6
./$PA/"lem-in" < file/error7
./$PA/"lem-in" < file/error8
./$PA/"lem-in" < file/error9
./$PA/"lem-in" < file/error10
./$PA/"lem-in" < file/error11
./$PA/"lem-in" < file/error12
./$PA/"lem-in" < file/error13
./$PA/"lem-in" < file/error14
./$PA/"lem-in" < file/error15
./$PA/"lem-in" < file/error16
./$PA/"lem-in" < file/error17
./$PA/"lem-in" < file/error18
./$PA/"lem-in" < file/error19
./$PA/"lem-in" < file/error20
./$PA/"lem-in" < file/error21
./$PA/"lem-in" < file/error22
./$PA/"lem-in" < file/error23
./$PA/"lem-in" < file/error24
./$PA/"lem-in" < file/error25
./$PA/"lem-in" < file/error26
./$PA/"lem-in" < file/error27
./$PA/"lem-in" < file/error28
./$PA/"lem-in" < file/error29
./$PA/"lem-in" < /dev/null
./$PA/"lem-in" < /dev/random
./$PA/"lem-in" < /dev/stdin < file/error29
./$PA/"lem-in" < /dev/stdin < file
./$PA/"lem-in" < libft

read $VAR

echo "\033[1;32m"
echo "====================================================================="
echo "============================ LEM-IN TEST ============================"
echo "====================================================================="
echo "\033[0m"

echo "\033[31mTEST LEM-IN\033[0m"
read $VAR

valgrind ./$PA/"lem-in" < file/test1

echo "\033[1;32m"
echo "====================================================================="
echo "=============================== NEXT ================================"
echo "\033[0m"

valgrind ./$PA/"lem-in" < file/test2

echo "\033[1;32m"
echo "====================================================================="
echo "=============================== NEXT ================================"
echo "\033[0m"
read $VAR

valgrind ./../roliveir/"lem-in" < file/test3

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ================================"
echo "\033[0m"
read $VAR

valgrind ./$PA/"lem-in"
read $VAR
valgrind ./$PA/"lem-in" < file/error1
read $VAR
valgrind ./$PA/"lem-in" < file/error2
read $VAR
valgrind ./$PA/"lem-in" < file/error3
read $VAR
valgrind ./$PA/"lem-in" < file/error4
read $VAR
valgrind ./$PA/"lem-in" < file/error5
read $VAR
valgrind ./$PA/"lem-in" < file/error6
read $VAR
valgrind ./$PA/"lem-in" < file/error7
read $VAR
valgrind ./$PA/"lem-in" < file/error8
read $VAR
valgrind ./$PA/"lem-in" < file/error9
read $VAR
valgrind ./$PA/"lem-in" < file/error10
read $VAR
valgrind ./$PA/"lem-in" < file/error11
read $VAR
valgrind ./$PA/"lem-in" < file/error12
read $VAR
valgrind ./$PA/"lem-in" < file/error13
read $VAR
valgrind ./$PA/"lem-in" < file/error14
read $VAR
valgrind ./$PA/"lem-in" < file/error15
read $VAR
valgrind ./$PA/"lem-in" < file/error16
read $VAR
valgrind ./$PA/"lem-in" < file/error17
read $VAR
valgrind ./$PA/"lem-in" < file/error18
read $VAR
valgrind ./$PA/"lem-in" < file/error19
read $VAR
valgrind ./$PA/"lem-in" < file/error20
read $VAR
valgrind ./$PA/"lem-in" < file/error21
read $VAR
valgrind ./$PA/"lem-in" < file/error22
read $VAR
valgrind ./$PA/"lem-in" < file/error23
read $VAR
valgrind ./$PA/"lem-in" < file/error24
read $VAR
valgrind ./$PA/"lem-in" < file/error25
read $VAR
valgrind ./$PA/"lem-in" < file/error26
read $VAR
valgrind ./$PA/"lem-in" < file/error27
read $VAR
valgrind ./$PA/"lem-in" < file/error28
read $VAR
valgrind ./$PA/"lem-in" < file/error29
read $VAR
valgrind ./$PA/"lem-in" < /dev/null
read $VAR
valgrind ./$PA/"lem-in" < /dev/random
read $VAR
valgrind ./$PA/"lem-in" < /dev/stdin < file/error29
read $VAR
valgrind ./$PA/"lem-in" < /dev/stdin < file
read $VAR
valgrind ./$PA/"lem-in" < libft
