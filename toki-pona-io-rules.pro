%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Learn Definite Clause Grammars
% Read a line of words from the user and check the grammar.
% Every word and !,.:;? are elements of a list.
% by Robert Warnke http://rowa.giso.de
% released under the GNU General Public License
%
% These scripts are based on the offical Toki Pona book of Sonja Lang (http://tokipona.org ),
% the lessons of jan Pije ( http://tokipona.net/tp/janpije/ ) and
% the lessons of jan Lope ( https://jan-lope.github.io ).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For a user friendly input:

% Read lines and analyze until we read an empty line
io_loop :- repeat, check_grammar, halt.

check_grammar :-
    read_line(CL),                                 % read a line
    ( CL = [] -> true                              % exit loop on empty line
      ; wordlist(WL,CL,[]), !, paragraph(P,WL,[]),  % analyze
      write(P), nl, fail).                         % print results and loop

% Read a line from the user, put it in a list of words and check it with "sentence".
check_grammar(P) :-
     read_line(CL),
     wordlist(WL,CL,[]), !, paragraph(P,WL,[]).

read_line(WL)             :- get0(C), codelist(C,WL).                           % Read a character code and put it in a list of codes.

codelist(10,[])           :- !.                                                 % Stop to build the list after line feed (10).
codelist(13,[])           :- !.                                                 % Stop to build the list after carriage return (13).
%codelist(81,[])           :- !.                                                 % Stop to build the list after "Q" (81).
%codelist(113,[])          :- !.                                                 % Stop to build the list after "q"" (113).

codelist(33,[32,33,32|X]) :- get0(C2), codelist(C2,X).                          % Put spaces (32) arround the "!" (33) and continue to build the list.
codelist(44,[32,44,32|X]) :- get0(C2), codelist(C2,X).                          % Put spaces (32) arround the "," (44) and continue to build the list.
codelist(46,[32,46,32|X]) :- get0(C2), codelist(C2,X).                          % Put spaces (32) arround the "." (46) and continue to build the list.
codelist(58,[32,58,32|X]) :- get0(C2), codelist(C2,X).                          % Put spaces (32) arround the ":" (58) and continue to build the list.
codelist(59,[32,59,32|X]) :- get0(C2), codelist(C2,X).                          % Put spaces (32) arround the ";" (59) and continue to build the list.
codelist(63,[32,63,32|X]) :- get0(C2), codelist(C2,X).                          % Put spaces (32) arround the "?" (63) and continue to build the list.

codelist(C,[C|X])         :- get0(C2), codelist(C2,X).                          % Continue to build the list of codes with the next character code.

% The rest is in dcg syntax:

wordlist([X|Y])          --> word(X), whitespaces, wordlist(Y).                 % A wordlist could be bild of one word, whitespaces and an other wordlist.
wordlist([X])            --> whitespaces, wordlist(X).                          % A wordlist could be bild of whitespaces and the same wordlist.
wordlist([X])            --> word(X).                                           % A wordlist could be bild of one word.
wordlist([X])            --> word(X), whitespaces.                              % A wordlist could be bild of one word and whitespaces character.

word(W)                  --> charlist(X), {name(W,X)}.                          % Build a word from a list of character codes.
                                                                                %  The prolog built-in predicate "name" represent a list of character codes as Atomic.
charlist([X|Y])          --> chr(X), charlist(Y).                               % A list of characters could be bild of one character and and an other list of characters.
charlist([X])            --> chr(X).                                            % A list of characters could be bild of one character.

chr(X)                   --> [X],{X>=33}.                                       % A useful character code for words is greater than or equal 33.

whitespaces              --> whitespace, whitespaces.                           % A whitspace could be one and more whitspaces.
whitespaces              --> whitespace.                                        % A whitspace could be one whitspace

whitespace               --> [X], {X<33}.                                       % A useful character code for whitespaces is less than 33.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eof
