#!/bin/bash
###############################################################################
#
# Make teste and builds for the Prolog Files to describe Toki Pona- 
# Robert Warnke
#
###############################################################################
#
PROLOG_MAIN_FILE="Toki_Pona"
#
echo " "
echo "########################################################################"
echo "start $0"
echo " "
#
rm -f *.out
echo "make $PROLOG_MAIN_FILE.out"
swipl -o  "$PROLOG_MAIN_FILE.out" -c "$PROLOG_MAIN_FILE.pro" > /dev/null 2> /dev/null
if [ $? != 0  ]; then
        echo "ERROR"
        exit 1
fi
if [ ! -f $PROLOG_MAIN_FILE.out ]; then
        echo "ERROR"
        exit 1
fi
#
rm -rf _build
mkdir -p _build
mv *.out _build
if [ ! -f _build/$PROLOG_MAIN_FILE.out ]; then
        echo "ERROR"
        exit 1
fi
#
echo " "
echo "end $0"
echo "########################################################################"
echo " "
#
###############################################################################
# eof
