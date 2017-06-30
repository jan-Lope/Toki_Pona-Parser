#!/usr/bin/env swipl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Spelling, Grammar Check and Ambiguity Check of Toki Pona Sentences
% Main Program
% 
% by Robert Warnke http://rowa.giso.de
% released under the GNU General Public License
% twitter: #tokipona #SWIprolog
%
% These scripts do not support Toki Pona slangs!
%
% First you have to install swi-prolog.
%   Windows, Mac OS X: http://www.swi-prolog.org/download/stable
%   Ubuntu/Debian: sudo apt-get install swi-prolog
%
% Download and decompress these scripts: http://rowa.giso.de/languages/toki-pona/dcg/toki-pona-dcg.tar.gz
%
% Start swi-prolog in the directory where the scripts are (here in Ubuntu):
%
% $ swipl
% ?-
%
% In swi-prolog load the main script:
%
% ?- ['Toki_Pona.pro'].
%
% Now you can check the grammar of a Toki Pona sentence with the command check_grammar(P).
% In this example it is the sentence "mi moku.".
% To get all possible variants type semicolons until "false" or "no" is printed.
% "false" or "no" mean no (more) variants can be found.
%
% ?- check_grammar(P).
% |: mi moku.
% P = s(dec(sim(np(sub(pronoun(mi))), vp(verb_tra(moku)))), sep('.')) ;
% P = s(dec(sim(np(sub(pronoun(mi))), vp(be, obj_be(adjective(moku))))), sep('.')) ;
% P = s(dec(sim(np(sub(pronoun(mi))), vp(be, obj_be(noun(moku))))), sep('.')) ;
% false.
%
% As an alternative way you can start swi-prolog and and the main script by one command:
% $ swipl -s Toki_Pona.pro
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abbreviations
%
% To avoid long phrase trees we need abbreviations.
%
% s        sentence
%
% dec      declarative sentence
% exc      exclamatory sentence
% imp      imperative sentence
% int      interrogative sentence
% hdl      headline
%
% sim      simple sentence
% voc      vocativ sentence
% inj      interjection sentence
% salut    salutation sentence
% com      command sentence
% des      designate sentence
%
% np       noun phrase
% vp       verb phrase
% lp       "la" phrase
% vocp     vocativ phrase
% salutp   salutation phrase
%
% subj     subject
%
% obj_d    object direct after transitive verb
% obj_i    object after intransitive verb
% obj_be   object after missing "be"
% obj_p    object after prepositiion
% obj_a    object after "anu"
%
% unofficial_ unofficial word (adjective)
%
% card     cardinal number
% ord      ordinal number
%
% conj     conjunction
% sep      separator
% verb_int verb_intransitive
% verb_tra verb transitive
% be       The missing "be", "am", "are", "is" in Toki Pona.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Include Files
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

% Start the io loop if we are not called for compiling
:- current_prolog_flag(os_argv,Argv),               % get all args for prolog
   \+ member('--stand_alone=true',Argv) -> io_loop  % start if not compiling
   ; true.                                          % just avoid warning.

