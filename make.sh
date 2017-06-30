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

# '-t io_loop' is needed to start the loop in the stand alone version
swipl -nodebug -g true -t io_loop -O -q --stand_alone=true -o  "$PROLOG_MAIN_FILE.out" -c "$PROLOG_MAIN_FILE.pro" > /dev/null 2> /dev/null

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
chmod +x Toki_Pona.out
mv *.out _build
if [ ! -f _build/$PROLOG_MAIN_FILE.out ]; then
        echo "ERROR"
        exit 1
fi
#
# _build/Toki_Pona.out 



# 
# To Do
# http://www.swi-prolog.org/pldoc/man?section=runtime
# http://www.swi-prolog.org/pldoc/man?section=runcomp
# http://www.swi-prolog.org/pldoc/doc_for?object=section%282,%272.10%27,swi%28%27/doc/Manual/compilation.html%27%29%29
# http://www.swi-prolog.org/pldoc/man?section=cmdline

# chmod +x test.pro
# ./test.pro -g go


#
echo " "
echo "end $0"
echo "########################################################################"
echo " "
#
###############################################################################
# eof
