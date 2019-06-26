#!/bin/bash

echo "\033[1;32m"
cat -e ../roliveir/auteur

echo "====================================================================="
echo "============================ NORM CHECK  ============================"
echo "====================================================================="
echo "\033[0m"

read $VAR

make fclean -C ../roliveir
norminette ../roliveir

echo "\033[1;32m"
echo "====================================================================="
echo "======================== EXTENDED NORM CHECK ========================"
echo "====================================================================="
echo "\033[32m"

read $VAR

echo "End-Of-Line OPERATORS...\n\033[31m"
find ../roliveir -name '*.c' -exec cat {} \; | grep "+$"
find ../roliveir -name '*.c' -exec cat {} \; | grep "*$"
find ../roliveir -name '*.c' -exec cat {} \; | grep "\-$"
find ../roliveir -name '*.c' -exec cat {} \; | grep " /$"
find ../roliveir -name '*.c' -exec cat {} \; | grep "&$"
find ../roliveir -name '*.c' -exec cat {} \; | grep "|$"
find ../roliveir -name '*.c' -exec cat {} \; | grep "%$"
find ../roliveir -name '*.c' -exec cat {} \; | grep "?$"
find ../roliveir -name '*.c' -exec cat {} \; | grep "=$"
find ../roliveir -name '*.c' -exec cat {} \; | grep " >$"
find ../roliveir -name '*.c' -exec cat {} \; | grep "<$"
find ../roliveir -name '*.c' -exec cat {} \; | grep "!$"
find ../roliveir -name '*.c' -exec cat {} \; | grep ":$"
echo "\033[32m"

echo "Code-Defining DEFINES...\n\033[31m"
find ../roliveir -name '*.h' -exec cat {} \; | grep "define\(.\?\)*(\|define\(.\?\)*)\|define\(.\?\)*\\[\|define\(.\?\)*\\]"

echo "\033[1;32m"
echo "====================================================================="
echo "============================== MAKE ================================="
echo "====================================================================="
echo "\033[0m"

read $VAR

make re -C ../roliveir
make clean -C ../roliveir

echo "\033[1;32m"
echo "====================================================================="
echo "========================= ALLOWED FUNCTIONS ========================="
echo "====================================================================="

read $VAR

echo "Fonction autorisees:\nwrite\nread\nmalloc\nexit\nfree\n\033[0m"
nm -u ../roliveir/push_swap
nm -u ../roliveir/checker

echo "\033[1;32m"
echo "====================================================================="
echo "============================== MALLOC ==============================="
echo "====================================================================="
echo "\033[0m"

read $VAR

find ../roliveir -name '*.c' -exec cat {} \; | grep "join" -A1
find ../roliveir -name '*.c' -exec cat {} \; | grep "strnew" -A1
find ../roliveir -name '*.c' -exec cat {} \; | grep "strdup" -A1
find ../roliveir -name '*.c' -exec cat {} \; | grep "malloc" -A1
find ../roliveir -name '*.c' -exec cat {} \; | grep "lstnew" -A1
find ../roliveir -name '*.c' -exec cat {} \; | grep "strsub" -A1
find ../roliveir -name '*.c' -exec cat {} \; | grep "strtrim" -A1

echo "\033[1;32m"
echo "====================================================================="
echo "============================= INCLUDES =============================="
echo "====================================================================="
echo "\033[31m"

read $VAR

find ../roliveir -name '*.c*' -exec cat {} \; | grep "stdio"
find ../roliveir -name '*.h*' -exec cat {} \; | grep "stdio"

echo "\033[1;32m"
echo "====================================================================="
echo "============================= CHECKER ==============================="
echo "=====================================================================\n"

echo "====================================================================="
echo "========================== ERROR ARG TEST ==========================="
read $VAR
echo "\033[0m"

echo "\033[33m\nPas d'argument\033[0m"
./../roliveir/checker
echo "\033[33m\nOverflow ARG=2147483648\033[0m"
./../roliveir/checker 2147483648
echo "\033[33m\nOverflow ARG=-2147483649\033[0m"
./../roliveir/checker -2147483649
echo "\033[33m\nMeme argument: ARG=0 -1 -2 0\033[0m"
./../roliveir/checker 0 -1 -2 0
echo "\033[33m\nLettre: ARG=1 2 3 a\033[0m"
./../roliveir/checker 1 2 3 a
echo "\033[33m\nARG=-06 6\033[0m"
./../roliveir/checker -06 -6
echo "\033[33m\nLettre et chiffre ARG=\"b1\" 10 33\033[0m"
./../roliveir/checker "b1" 10 33
echo "\033[33m\nBig Overflow: ARG=9999999999999999999999999999999999999999999999999\033[0m"
./../roliveir/checker 9999999999999999999999999999999999999999999999999
echo "\033[33m\nBig Overflow dans une string ARG =\"1 3 5555555555555555555555555555555 6 7\"\033[0m"
./../roliveir/checker "1 3 55555555555555555555555555555555555555 6 7"
echo "\033[33m\nOverflow negatif dans string ARG=\" 10 11 -2147482649 2\"\033[0m"
./../roliveir/checker "10 11 -2147483649 2"
echo "\033[33m\nMulti string et meme arg ARG:\"3 2 1\" \"8 9 10\" \"1\"\033[0m"
./../roliveir/checker "3 2 1" "8 9 10" "1"
echo "\033[33m\nMulti string invalid arg ARG=\"3 2 1\" \" 8 9 10\" \"-\"\033[0m"
./../roliveir/checker "3 2 1" "8 9 10" "-"
echo "\033[33m\nMulti string invalid arg ARG=\"3 2 1\" \" 8 9 10\" -\033[0m"
./../roliveir/checker "3 2 1" "8 9 10" -
echo "\033[33m\nMulti string invalid arg ARG= "+" \"3 2 1\" \" 8 9 10\"\033[0m"
./../roliveir/checker "+" "3 2 1" "8 9 10"
echo "\033[33m\nBeaucoup d'espace ARG=\"                                \"\033[0m"
./../roliveir/checker "                                       "
echo "\033[33m\n/dev/random ARG=50\033[0m"
cat /dev/random | ./../roliveir/checker 50

echo "\033[1;32m"
echo "====================================================================="
echo "======================== ERROR COMMAND TEST ========================="
read $VAR

echo "\033[0m"
echo "\033[33m\nWrong command: r\033[0m"
cat file/error2 | ./../roliveir/checker 2 3 4 5
echo "\033[33m\nWrong command: rrrr\033[0m"
cat file/error3 | ./../roliveir/checker 2 3 4 5
echo "\033[33m\nWrong command: \"sa \"\033[0m"
cat file/error4 | ./../roliveir/checker 2 3 4 5
echo "\033[33m\nWrong command: oups\033[0m"
cat file/error5 | ./../roliveir/checker 2 5 6 8
echo "\033[33m\nWrong command: saut de lignes\033[0m"
cat file/error6 | ./../roliveir/checker 2 5 6 8
echo "\033[33m\nWrong command: long command\033[0m"
cat file/error7 | ./../roliveir/checker 1 2 3
echo "\033[33m\nWrong command: space before command\033[0m"
cat file/error8 | ./../roliveir/checker 1 2 3

echo "\033[1;32m"
echo "====================================================================="
echo "============================== KO TEST =============================="
read $VAR

cat file/ko1 | ./../roliveir/checker 33 12 25
cat file/ko2 | ./../roliveir/checker 10 2 3 4
cat file/ko3 | ./../roliveir/checker 3 2 4 5 1

echo "\033[1;32m"
echo "====================================================================="
echo "============================== OK TEST =============================="
read $VAR

cat file/ok1 | ./../roliveir/checker 0
cat file/ok2 | ./../roliveir/checker 2 1 3 6 5 8
cat file/ok2 | ./../roliveir/checker 2 0 3 6 5 8
cat file/error1 | ./../roliveir/checker 50
cat /dev/null | ./../roliveir/checker " 1" 2 3 4
cat /dev/null | ./../roliveir/checker "0 2 3                               "
cat /dev/null | ./../roliveir/checker 50
cat /dev/null | ./../roliveir/checker -0 1 2 123456789
cat file/ok3 | ./../roliveir/checker 3 2 1 0
cat /dev/null | ./../roliveir/checker "-1000 -999 -998" -500 -1 "0" "1 2 3" "99999 999999"

echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nPas d'argument\033[0m"
valgrind ./../roliveir/checker
echo "\033[33m\nOverflow ARG=2147483648\033[0m"
valgrind ./../roliveir/checker 2147483648
echo "\033[33m\nOverflow ARG=-2147483649\033[0m"
valgrind ./../roliveir/checker -2147483649

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nMeme argument: ARG=0 -1 -2 0\033[0m"
valgrind ./../roliveir/checker 0 -1 -2 0
echo "\033[33m\nLettre: ARG=1 2 3 a\033[0m"
valgrind ./../roliveir/checker 1 2 3 a
echo "\033[33m\nARG=\" 1\" 2 3 4\033[0m"
cat /dev/null | valgrind ./../roliveir/checker " 1" 2 3 4

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nLettre et chiffre ARG=\"b1\" 10 33\033[0m"
valgrind ./../roliveir/checker "b1" 10 33
echo "\033[33m\nARG=\"0 2 3                         \"\033[0m"
cat /dev/null | valgrind ./../roliveir/checker "0 2 3                            "
echo "\033[33m\nARG=\"                                        \"\033[0m"
valgrind ./../roliveir/checker "                                            "
echo "\033[33m\nBig Overflow: ARG=9999999999999999999999999999999999999999999999999\033[0m"
valgrind ./../roliveir/checker 9999999999999999999999999999999999999999999999999

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\n/dev/random ARG=50\033[0m"
cat /dev/random | valgrind ./../roliveir/checker 50
echo "\033[33m\nWrong command: r\033[0m"
cat file/error2 | valgrind ./../roliveir/checker 2 4 5
echo "\033[33m\nWrong command: rrrr\033[0m"
cat file/error3 | valgrind ./../roliveir/checker 2 3 4 5
echo "\033[33m\nWrong command: \"sa \"\033[0m"
cat file/error4 | valgrind ./../roliveir/checker 2 3 4 5

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nWrong command: oups\033[0m"
cat file/error5 | valgrind ./../roliveir/checker 2 5 6 8
echo "\033[33m\nWrong command: saut de lignes\033[0m"
cat file/error6 | valgrind ./../roliveir/checker 2 5 6 8
echo "\033[33m\nWrong command: saut de lignes\033[0m"
cat file/ko1 | valgrind ./../roliveir/checker 33 12 25

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
cat file/ko2 | valgrind ./../roliveir/checker 10 2 3 4
cat file/ko3 | valgrind ./../roliveir/checker 3 2 4 5 1
cat file/ok1 | valgrind ./../roliveir/checker 0

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
cat file/ok2 | valgrind ./../roliveir/checker 2 1 3 6 5 8
cat file/ok2 | valgrind ./../roliveir/checker 2 0 3 6 5 8
cat /dev/null | ./../roliveir/checker "-1000 -999 -998" -500 -1 "0" "1 2 3" "99999 999999"
cat file/error1 | valgrind ./../roliveir/checker 50

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
cat /dev/null | valgrind ./../roliveir/checker 50
cat file/ok3 | valgrind ./../roliveir/checker 3 2 1 0
echo "\033[33m\nMulti string et meme arg ARG:\"3 2 1\" \"8 9 10\" \"1\"\033[0m"
valgrind ./../roliveir/checker "3 2 1" "8 9 10" "1"
echo "\033[33m\nARG=-06 6\033[0m"
valgrind ./../roliveir/checker -06 -6

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nBig Overflow dans une string ARG =\"1 3 5555555555555555555555555555555 6 7\"\033[0m"
valgrind ./../roliveir/checker "1 3 55555555555555555555555555555555555 6 7"
echo "\033[33m\nOverflow negatif dans string ARG=\" 10 11 -2147482649 2\"\033[0m"
valgrind ./../roliveir/checker "10 11 -2147483649 2"
cat file/error7 | valgrind ./../roliveir/checker 1 2 3
echo "\033[33m\nWrong command: space before command\033[0m"
cat file/error8 | valgrind ./../roliveir/checker 1 2 3


echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nMulti string invalid arg ARG=\"3 2 1\" \" 8 9 10\" \"-\"\033[0m"
valgrind ./../roliveir/checker "3 2 1" "8 9 10" "-"
echo "\033[33m\nMulti string invalid arg ARG=\"3 2 1\" \" 8 9 10\" -\033[0m"
valgrind ./../roliveir/checker "3 2 1" "8 9 10" -
echo "\033[33m\nMulti string invalid arg ARG= "+" \"3 2 1\" \" 8 9 10\"\033[0m"
valgrind ./../roliveir/checker "+" "3 2 1" "8 9 10"

echo "\033[1;32m"
echo "====================================================================="
echo "============================ PUSH_SWAP =============================="
echo "=====================================================================\n"

echo "====================================================================="
echo "========================== ERROR ARG TEST ==========================="
read $VAR

echo "\033[0m"
echo "\033[33m\nPas d'argument\033[0m"
./../roliveir/push_swap
echo "\033[33m\nOverflow ARG=2147483648\033[0m"
./../roliveir/push_swap 2147483648
echo "\033[33m\nOverflow ARG=-2147483649\033[0m"
./../roliveir/push_swap -2147483649
echo "\033[33m\nMeme argument: ARG=0 -1 -2 0\033[0m"
./../roliveir/push_swap 0 -1 -2 0
echo "\033[33m\nARG=-06 -6\033[0m"
./../roliveir/checker -06 -6
echo "\033[33m\nLettre: ARG=1 2 3 a\033[0m"
./../roliveir/push_swap 1 2 3 a
echo "\033[33m\nLettre et chiffre ARG=\"b1\" 10 33\033[0m"
./../roliveir/push_swap "b1" 10 33
echo "\033[33m\nBig Overflow: ARG=9999999999999999999999999999999999999999999999999\033[0m"
./../roliveir/push_swap 9999999999999999999999999999999999999999999999999
echo "\033[33m\nBig Overflow dans une string ARG =\"1 3 5555555555555555555555555555555 6 7\"\033[0m"
./../roliveir/push_swap "1 3 55555555555555555555555555555555555555 6 7"
echo "\033[33m\nOverflow negatif dans string ARG=\" 10 11 -2147482649 2\"\033[0m"
./../roliveir/push_swap "10 11 -2147483649 2"
echo "\033[33m\nMulti string et meme arg ARG:\"3 2 1\" \"8 9 10\" \"1\"\033[0m"
./../roliveir/push_swap "3 2 1" "8 9 10" "1"
echo "\033[33m\nMulti string invalid arg ARG=\"3 2 1\" \" 8 9 10\" \"-\"\033[0m"
./../roliveir/push_swap "3 2 1" "8 9 10" "-"
echo "\033[33m\nMulti string invalid arg ARG=\"3 2 1\" \" 8 9 10\" -\033[0m"
./../roliveir/push_swap "3 2 1" "8 9 10" -
echo "\033[33m\nMulti string invalid arg ARG= "+" \"3 2 1\" \" 8 9 10\"\033[0m"
./../roliveir/push_swap "+" "3 2 1" "8 9 10"
echo "\033[33m\nBeaucoup d'espace ARG=\"                                \"\033[0m"
./../roliveir/push_swap "                                       "

echo "\033[1;32m"
echo "====================================================================="
echo "========================= NOHTING TO PRINT =========================="
read $VAR

echo "\033[0m"
./../roliveir/push_swap 0
./../roliveir/push_swap 0 1 2
./../roliveir/push_swap -1
./../roliveir/push_swap 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108

echo "\033[1;32m"
echo "====================================================================="
echo "============================= ANALYSING  ============================"

echo "3 arguments\n\033[0m"

read $STOP

NBRBOT=-2
NBRTOP=0
TRY=100
MED=3

NBR=$(($NBRTOP - $NBRBOT))
((NBR++))
MOY=0;
MAX=-1;
MIN=-1;
ACTMAX="";
ACTMIN="";
MORE=0;
LESS=0;
IND=$TRY;
WELL=0;
TEST="";

printf "[ NBR == $NBR && TRY == $TRY && MED == $MED ]\n"

echo "Analyse in progress ...\n\n";
while [ $IND -gt 0 ];
do
	ARG=`ruby -e "puts ($NBRBOT..$NBRTOP).to_a.shuffle.join(' ')"`
	NBRCOUP=$(./../roliveir/push_swap $ARG | wc -l);
	TEST=$(./../roliveir/push_swap $ARG | ./../roliveir/checker $ARG);
	if [ $TEST = "OK" ]
	then
		printf "\033[0;32m▓\033[0;0m"
		WELL=$(( $WELL + 1 ));
	else
		printf "\033[0;31m▓\033[0;0m"
	fi;

	if [ $MAX -lt $NBRCOUP ]
	then
		MAX=$NBRCOUP;
		ACTMAX=$ARG;
	fi;
	if [ $MIN -eq "-1" ];
	then
		MIN=$NBRCOUP;
		ACTMIN=$ARG;
	fi;
	if [ $NBRCOUP -lt $MIN ]
	then MIN=$NBRCOUP;
		ACTMIN=$ARG;
	fi;
	MOY=$(( $MOY + $NBRCOUP ));
	IND=$(( $IND - 1 ));
	if [ $NBRCOUP -gt $MED ]
	then
		((MORE++))
	else
		((LESS++))
	fi;
done;
MOY=$(( $MOY / $TRY ));
echo "\nThere is \x1b[33m$WELL/$TRY\x1b[0m correct answer"
echo "There is \x1B[31m$MORE\x1b[0m more than $MED"
echo "There is \x1B[32m$LESS\x1b[0m less than $MED"
echo "The biggest  is :\x1B[31m$MAX\x1b[0m"
echo "The average is :\t\x1b[33m$MOY\x1b[0m"
echo "The smallest is :\x1B[32m$MIN\x1b[0m"
echo "The worst list :\t$ACTMAX"
echo "The best list :\t\t$ACTMIN"

read $STOP

echo "\033[1;32m"
echo "5 arguments\n\033[0m"

read $STOP

NBRBOT=-2
NBRTOP=2
TRY=100
MED=12

NBR=$(($NBRTOP - $NBRBOT))
((NBR++))
MOY=0;
MAX=-1;
MIN=-1;
ACTMAX="";
ACTMIN="";
MORE=0;
LESS=0;
IND=$TRY;
WELL=0;
TEST="";

printf "[ NBR == $NBR && TRY == $TRY && MED == $MED ]\n"

echo "Analyse in progress ...\n\n";
while [ $IND -gt 0 ];
do
	ARG=`ruby -e "puts ($NBRBOT..$NBRTOP).to_a.shuffle.join(' ')"`
	NBRCOUP=$(./../roliveir/push_swap $ARG | wc -l);
	TEST=$(./../roliveir/push_swap $ARG | ./../roliveir/checker $ARG);
	if [ $TEST = "OK" ]
	then
		printf "\033[0;32m▓\033[0;0m"
		WELL=$(( $WELL + 1 ));
	else
		printf "\033[0;31m▓\033[0;0m"
	fi;

	if [ $MAX -lt $NBRCOUP ]
	then
		MAX=$NBRCOUP;
		ACTMAX=$ARG;
	fi;
	if [ $MIN -eq "-1" ];
	then
		MIN=$NBRCOUP;
		ACTMIN=$ARG;
	fi;
	if [ $NBRCOUP -lt $MIN ]
	then MIN=$NBRCOUP;
		ACTMIN=$ARG;
	fi;
	MOY=$(( $MOY + $NBRCOUP ));
	IND=$(( $IND - 1 ));
	if [ $NBRCOUP -gt $MED ]
	then
		((MORE++))
	else
		((LESS++))
	fi;
done;
MOY=$(( $MOY / $TRY ));
echo "\nThere is \x1b[33m$WELL/$TRY\x1b[0m correct answer"
echo "There is \x1B[31m$MORE\x1b[0m more than $MED"
echo "There is \x1B[32m$LESS\x1b[0m less than $MED"
echo "The biggest  is :\x1B[31m$MAX\x1b[0m"
echo "The average is :\t\x1b[33m$MOY\x1b[0m"
echo "The smallest is :\x1B[32m$MIN\x1b[0m"
echo "The worst list :\t$ACTMAX"
echo "The best list :\t\t$ACTMIN"

read $STOP

echo "\033[1;32m"
echo "100 arguments\n\033[0m"

read $STOP

NBRBOT=-50
NBRTOP=49
TRY=50
MED=700

NBR=$(($NBRTOP - $NBRBOT))
((NBR++))
MOY=0;
MAX=-1;
MIN=-1;
ACTMAX="";
ACTMIN="";
MORE=0;
LESS=0;
IND=$TRY;
WELL=0;
TEST="";

printf "[ NBR == $NBR && TRY == $TRY && MED == $MED ]\n"

echo "Analyse in progress ...\n\n";
while [ $IND -gt 0 ];
do
	ARG=`ruby -e "puts ($NBRBOT..$NBRTOP).to_a.shuffle.join(' ')"`
	NBRCOUP=$(./../roliveir/push_swap $ARG | wc -l);
	TEST=$(./../roliveir/push_swap $ARG | ./../roliveir/checker $ARG);
	if [ $TEST = "OK" ]
	then
		printf "\033[0;32m▓\033[0;0m"
		WELL=$(( $WELL + 1 ));
	else
		printf "\033[0;31m▓\033[0;0m"
	fi;

	if [ $MAX -lt $NBRCOUP ]
	then
		MAX=$NBRCOUP;
		ACTMAX=$ARG;
	fi;
	if [ $MIN -eq "-1" ];
	then
		MIN=$NBRCOUP;
		ACTMIN=$ARG;
	fi;
	if [ $NBRCOUP -lt $MIN ]
	then MIN=$NBRCOUP;
		ACTMIN=$ARG;
	fi;
	MOY=$(( $MOY + $NBRCOUP ));
	IND=$(( $IND - 1 ));
	if [ $NBRCOUP -gt $MED ]
	then
		((MORE++))
	else
		((LESS++))
	fi;
done;
MOY=$(( $MOY / $TRY ));
echo "\nThere is \x1b[33m$WELL/$TRY\x1b[0m correct answer"
echo "There is \x1B[31m$MORE\x1b[0m more than $MED"
echo "There is \x1B[32m$LESS\x1b[0m less than $MED"
echo "The biggest  is :\x1B[31m$MAX\x1b[0m"
echo "The average is :\t\x1b[33m$MOY\x1b[0m"
echo "The smallest is :\x1B[32m$MIN\x1b[0m"
echo "The worst list :\t$ACTMAX"
echo "The best list :\t\t$ACTMIN"

read $STOP

echo "\033[1;32m"
echo "500 arguments\n\033[0m"

read $STOP

NBRBOT=-400
NBRTOP=99
TRY=50
MED=5500

NBR=$(($NBRTOP - $NBRBOT))
((NBR++))
MOY=0;
MAX=-1;
MIN=-1;
ACTMAX="";
ACTMIN="";
MORE=0;
LESS=0;
IND=$TRY;
WELL=0;
TEST="";

printf "[ NBR == $NBR && TRY == $TRY && MED == $MED ]\n"

echo "Analyse in progress ...\n\n";
while [ $IND -gt 0 ];
do
	ARG=`ruby -e "puts ($NBRBOT..$NBRTOP).to_a.shuffle.join(' ')"`
	NBRCOUP=$(./../roliveir/push_swap $ARG | wc -l);
	TEST=$(./../roliveir/push_swap $ARG | ./../roliveir/checker $ARG);
	if [ $TEST = "OK" ]
	then
		printf "\033[0;32m▓\033[0;0m"
		WELL=$(( $WELL + 1 ));
	else
		printf "\033[0;31m▓\033[0;0m"
	fi;

	if [ $MAX -lt $NBRCOUP ]
	then
		MAX=$NBRCOUP;
		ACTMAX=$ARG;
	fi;
	if [ $MIN -eq "-1" ];
	then
		MIN=$NBRCOUP;
		ACTMIN=$ARG;
	fi;
	if [ $NBRCOUP -lt $MIN ]
	then MIN=$NBRCOUP;
		ACTMIN=$ARG;
	fi;
	MOY=$(( $MOY + $NBRCOUP ));
	IND=$(( $IND - 1 ));
	if [ $NBRCOUP -gt $MED ]
	then
		((MORE++))
	else
		((LESS++))
	fi;
done;
MOY=$(( $MOY / $TRY ));
echo "\nThere is \x1b[33m$WELL/$TRY\x1b[0m correct answer"
echo "There is \x1B[31m$MORE\x1b[0m more than $MED"
echo "There is \x1B[32m$LESS\x1b[0m less than $MED"
echo "The biggest  is :\x1B[31m$MAX\x1b[0m"
echo "The average is :\t\x1b[33m$MOY\x1b[0m"
echo "The smallest is :\x1B[32m$MIN\x1b[0m"
echo "The worst list :\t$ACTMAX"
echo "The best list :\t\t$ACTMIN"

read $STOP

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="

echo "\033[0m"
read $VAR
ARG=`ruby -e "puts (-1..1).to_a.shuffle.join(' ')"; valgrind ./../roliveir/push_swap $ARG | valgrind ./../roliveir/checker $ARG
read $VAR
valgrind ./../roliveir/push_swap 0 | valgrind ./../roliveir/checker 0
read $VAR
ARG=`ruby -e "puts (-250..249).to_a.shuffle.join(' ')"; valgrind ./../roliveir/push_swap $ARG | valgrind ./../roliveir/checker $ARG

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nPas d'argument\033[0m"
valgrind ./../roliveir/push_swap
echo "\033[33m\nOverflow ARG=2147483648\033[0m"
valgrind ./../roliveir/push_swap 2147483648
echo "\033[33m\nOverflow ARG=-2147483649\033[0m"
valgrind ./../roliveir/push_swap -2147483649

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nMeme argument: ARG=0 -1 -2 0\033[0m"
valgrind ./../roliveir/push_swap 0 -1 -2 0
echo "\033[33m\nLettre: ARG=1 2 3 a\033[0m"
valgrind ./../roliveir/push_swap 1 2 3 a
echo "\033[33m\nARG=\" 1\" 2 3 4\033[0m"
valgrind ./../roliveir/push_swap " 1" 2 3 4

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nLettre et chiffre ARG=\"b1\" 10 33\033[0m"
valgrind ./../roliveir/push_swap "b1" 10 33
echo "\033[33m\nARG=\"0 2 3                         \"\033[0m"
valgrind ./../roliveir/push_swap "0 2 3                            "
echo "\033[33m\nARG=\"                                        \"\033[0m"
valgrind ./../roliveir/push_swap "                                            "
echo "\033[33m\nBig Overflow: ARG=9999999999999999999999999999999999999999999999999\033[0m"
valgrind ./../roliveir/push_swap 9999999999999999999999999999999999999999999999999

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
valgrind ./../roliveir/push_swap 0
valgrind ./../roliveir/push_swap "-1000 -999 -998" -500 -1 "0" "1 2 3" "99999 999999"

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nMulti string et meme arg ARG:\"3 2 1\" \"8 9 10\" \"1\"\033[0m"
valgrind ./../roliveir/push_swap "3 2 1" "8 9 10" "1"

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nBig Overflow dans une string ARG =\"1 3 5555555555555555555555555555555 6 7\"\033[0m"
valgrind ./../roliveir/push_swap "1 3 55555555555555555555555555555555555 6 7"
echo "\033[33m\nOverflow negatif dans string ARG=\" 10 11 -2147482649 2\"\033[0m"
valgrind ./../roliveir/push_swap "10 11 -2147483649 2"

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nMulti string invalid arg ARG=\"3 2 1\" \" 8 9 10\" \"-\"\033[0m"
valgrind ./../roliveir/push_swap "3 2 1" "8 9 10" "-"
echo "\033[33m\nMulti string invalid arg ARG=\"3 2 1\" \" 8 9 10\" -\033[0m"
valgrind ./../roliveir/push_swap "3 2 1" "8 9 10" -
echo "\033[33m\nMulti string invalid arg ARG= "+" \"3 2 1\" \" 8 9 10\"\033[0m"
valgrind ./../roliveir/push_swap "+" "3 2 1" "8 9 10"

echo "\033[1;32m"
echo "====================================================================="
echo "============================== LEAKS ==============================="
read $VAR

echo "\033[0m"
echo "\033[33m\nMeme argument: ARG=0 -1 -2 0\033[0m"
valgrind ./../roliveir/push_swap 0 -1 -2 0 | valgrind ./../roliveir/checker 0 -1 -2 0
echo "\033[33m\nLettre: ARG=1 2 3 a\033[0m"
valgrind ./../roliveir/push_swap 1 2 3 a | valgrind ./../roliveir/checker 1 2 3 a

echo "\033[1;32m"
echo "====================================================================="
echo "=============================== END ================================="
echo "====================================================================="
echo "\033[0m"
