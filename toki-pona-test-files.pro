#!/usr/bin/env swipl
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
% These scripts do not support Toki Pona slangs!
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Allow testing all lines in a file to succeed or to fail
% by Jörn Eichler

% remove anything after a % sign in a line
remove_comments([C|TL],[C|CL]) :-
    C \= 37,
    remove_comments(TL,CL).
remove_comments([37|_],[]).
remove_comments([],[]).

% read a line and remove comments
read_file_line(CL) :-
    read_line(TL), remove_comments(TL,CL), !.

% print a line for error messages
print_line(CL) :- atom_codes(L,CL), write(L), nl.

% check a line that should be correct
check_right_line :-
    read_file_line(CL), wordlist(WL,CL,[]), !,
    (paragraph(_,WL,[]) -> true
    ; flag(testFailed,_,1), write('Error - wrongly fails: '), print_line(CL)).

% check file with correct lines.
check_right :-
    repeat, (at_end_of_stream -> true ; check_right_line, fail).

% check a line that should be wrong
check_wrong_line :-
    read_file_line(CL), wordlist(WL,CL,[]), !,
    (paragraph(_,WL,[]) -> flag(testFailed,_,1),
     write('Error - wrongly passes: '), print_line(CL),
     foreach(paragraph(P,WL,[]),(write('-> '), write(P), nl))
     ; true).

% check file with correct lines.
check_wrong :-
    repeat, (at_end_of_stream -> true ; check_wrong_line, fail).

% run through a test file using predicate given
check_read(File,Pred) :-
    open(File,read,IN), see(IN),
    write('Checking file '), write(File), nl, !,
    call(Pred),
    close(IN).

% Consult needed files
% The Toki Pona grammar rules.
:- ['toki-pona-grammar-rules.pro'].

% This catalog file contains the official  Toki Pona words.
:- ['toki-pona-official-words.pro'].

% Unofficial Words - Adjectives catalogs
:- ['toki-pona-unofficial-words-continents.pro'].
:- ['toki-pona-unofficial-words-countries.pro'].
:- ['toki-pona-unofficial-words-cities.pro'].
:- ['toki-pona-unofficial-words-languages.pro'].
:- ['toki-pona-unofficial-words-ideologies.pro'].
:- ['toki-pona-unofficial-words-communities.pro'].
:- ['toki-pona-unofficial-words-female-prominent-personages.pro'].
:- ['toki-pona-unofficial-words-male-prominent-personages.pro'].
:- ['toki-pona-unofficial-words-female-names.pro'].
:- ['toki-pona-unofficial-words-male-names.pro'].
:- ['toki-pona-unofficial-words-persons.pro'].
:- ['toki-pona-unofficial-words-movies.pro'].
:- ['toki-pona-unofficial-words-miscellaneous.pro'].

% This file contains the DCG and Prolog rules for a user friendly input.
:- ['toki-pona-io-rules.pro'].

% reset error flag. This is not really needed as any 'flag' is initialized
% to 0 by Prolog. But so we know what we do
:- flag(testFailed,_,0).

% Run the tests
:- check_read('toki-pona-sentences-right.txt',check_right).
:- check_read('toki-pona-sentences-wrong.txt',check_wrong).

% exit, returning the result of the tests
:- flag(testFailed,Value,0), halt(Value).
