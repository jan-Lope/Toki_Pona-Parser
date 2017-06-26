#!/usr/bin/env swipl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Spelling, Grammar Check and Ambiguity Check of Toki Pona Sentences
% Test Program


:- ['Toki_Pona.pro'].

:- initialization go.

go :- 
	prompt(_, 'Write a Toki Pona sentece: '),
	check_grammar(P), 
	write(P),
	nl.
go :- 
	halt.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eof

/*
To Do:
http://www.cs.fsu.edu/~engelen/expr.htmlhttp://www.cs.fsu.edu/~engelen/expr.html
http://cecs.wright.edu/~tkprasad/VHDL/VHDL-AMS/vhdl97.htmlhttp://cecs.wright.edu/~tkprasad/VHDL/VHDL-AMS/vhdl97.html
pretty printing
https://user.phil-fak.uni-duesseldorf.de/~rumpf/WS2004/Prolog/h8.pdf
http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse42
https://github.com/dragonwasrobot/learn-prolog-now-exercises/blob/master/chapter-12/practical-session.pl
http://www.swi-prolog.org/pldoc/doc/swi/library/pprint.pl
*/
