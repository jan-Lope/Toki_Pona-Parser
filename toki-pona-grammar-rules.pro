%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Toki Pona - Grammar Rules
% by Robert Warnke http://rowa.giso.de
% released under the GNU General Public License
% twitter: #tokipona #SWIprolog
%
% These scripts are based on the offical Toki Pona book of Sonja Lang (http://tokipona.org ),
% the lessons of jan Pije ( http://tokipona.net/tp/janpije/ ) and
% the lessons of jan Lope ( https://jan-lope.github.io ).
% These scripts do not support Toki Pona slangs!
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% paragraph and sentences
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% paragraph

% A paragraph can consists of of one and (optional) several sentences.
paragraph(P) -->
  sentence(S1),
  sentences(S2),
  {removing_extraneous_tree_nodes_ab(P,S1,S2)}.

% A paragraph can consists of of a headline.
% A special separator is needed for this script version.
paragraph(P) -->
  headline(H),
  {removing_extraneous_tree_nodes_a(P,H)}.

% A paragraph can consists of of a headline and at least one sentences.
paragraph(P) -->
  headline(H),
  separator(_,'/'),
  sentences(S),
  sentences(Ss),
  {removing_extraneous_tree_nodes_abc(P,H,S,Ss)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% several sentences

sentences(epsilon) --> [].

sentences(Ses) -->
  sentence(S),
  sentences(Ss),
  {removing_extraneous_tree_nodes_ab(Ses,S,Ss)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sentence types
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A headline (title) is mostly not a complete sentence and has no punctuation mark and can start with a optional conjunction.
% examples:
% moku
% en moku
% en moku a
% en sina o a
headline(S) -->
  conjunction_optional(C),
  headline_simple(HL),
  interjection_optional(I),
  {removing_extraneous_tree_nodes_pr_abc('headline',S,C,HL,I)}.  % Pure prolog rule to remove extraneous tree nodes (see below).

% A declarative sentence can start with a optional conjunction and end with a full stop.
% examples:
% mi moku e moku.
% anu mi moku e moku.
sentence(S) -->
  conjunction_optional(C),
  sentence_declarative(SD),
  separator(Sep,'.'),
  {removing_extraneous_tree_nodes_pr_abc('s',S,C,SD,Sep)}.

% An exclamatory sentence can start with a optional conjunction and end with an optional interjection word and an exclamation mark.
% examples:
% mi moku e moku!
% anu mi moku e moku!
% anu mi moku e moku a!
sentence(S) -->
  conjunction_optional(C),
  sentence_exclamatory(SE),
  interjection_optional(I),
  separator(Sep,'!'),
  {removing_extraneous_tree_nodes_pr_abcd('s',S,C,SE,I,Sep)}.

% An exclamatory sentence can start with a optional conjunction and end with an interjection word and a full stop.
% examples:
% mi moku e moku a.
% anu mi moku e moku a.
sentence(S) -->
  conjunction_optional(C),
  sentence_exclamatory(SE),
  interjections(I),
  separator(Sep,'.'),
  {removing_extraneous_tree_nodes_pr_abcd('s',S,C,SE,I,Sep)}.

% An exclamatory sentence can consists a optional conjunction, interjections and end with an optional interjection word and an exclamation mark or full stop..
% examples:
% anu jaki!
sentence(S) -->
  conjunction_optional(C),
  interjection(I),
  separator(Sep,'!'),
  {removing_extraneous_tree_nodes_pr_abc('s',S,C,I,Sep)}.

% An imperative sentence can start with a optional conjunction and end with an optional interjection word
% and a full stop or an an exclamation mark.
% examples:
% o moku e moku.
% en o moku e moku!
% o moku e telo a!
% en o moku e telo a.
sentence(S) -->
  conjunction_optional(C),
  sentence_imperative(SI),
  interjection_optional(I),
  (separator(Sep,'!') ; separator(Sep,'.')),                           % '!' or '.'
  {removing_extraneous_tree_nodes_pr_abcd('s',S,C,SI,I,Sep)}.

% An interrogative sentence can start with a optional conjunction and end with an optional interjection word with and a question mark.
% examples:
% seme?
% en seme?
% en seme a?
% en sina pona ala pona e tawa?
sentence(S) -->
  conjunction_optional(C),
  sentence_interrogative(SI),
  interjection_optional(I),
  separator(Sep,'?'),
  {removing_extraneous_tree_nodes_pr_abcd('s',S,C,SI,I,Sep)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% definitions of the sentence types
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% declarative sentences:

% A declarative sentence can build of optional "la"-phrases, a simple sentence and optional "la"-phrases.
% examples:
% mi moku e moku.
% ken la mi moku e moku.
% tenpo kama la mi moku e moku la ken.
sentence_declarative(S) -->
  la_phrases(L1),
  sentence_simple(SS),
  la_phrase_follow(L2),
  {removing_extraneous_tree_nodes_pr_abc('dec',S,L1,SS,L2)}.

% A declarative sentence can build of two simple sentences separated by a colon with optional "la"-phrases.
% examples:
% mi wile e ni: mi moku e moku.
% tenpo kama la mi wile e ni: mi moku e moku.
% tenpo kama la mi wile e ni: ken la mi moku e moku.
sentence_declarative(S) -->
  la_phrases(L1),
  sentence_simple(SS1),
  separator(Sep,':'),
  la_phrases(L2),
  sentence_simple(SS2),
  {removing_extraneous_tree_nodes_pr_abcde('dec',S,L1,SS1,Sep,L2,SS2)}.

% A declarative sentence can be a yes answer.
% examples:
% moku.
sentence_declarative(S) -->
  answer_yes(A),
  {removing_extraneous_tree_nodes_pr_a('dec',S,A)}.

% A declarative sentence can be a no answer.
% examples:
% moku ala.
sentence_declarative(S) -->
  answer_no(A),
  {removing_extraneous_tree_nodes_pr_a('dec',S,A)}.

% A declarative sentence can be a vocativ sentence (addressing people).
% examples:
% sina o, sina moku e moku.
sentence_declarative(S) -->
  vocativ(V),
  {removing_extraneous_tree_nodes_pr_a('dec',S,V)}.

% A declarative sentence can be a salutation.
% examples:
% jan Lope o, toki a!
sentence_declarative(S) -->
  salutation(Sa),
  {removing_extraneous_tree_nodes_pr_a('dec',S,Sa)}.

% A declarative sentence can be an interjection.
% examples:
% ken la jaki!
sentence_declarative(S) -->
  la_phrases(L),
  interjection(I),
  {removing_extraneous_tree_nodes_pr_ab('dec',S,L,I)}.

% A declarative sentence can be an interjection and vocativ sentence.
% examples:
% sina o, toki!
sentence_declarative(S) -->
  vocativ_interjection(V),
  {removing_extraneous_tree_nodes_pr_a('dec',S,V)}.

% A declarative sentence can be an special sentence for designate.
% examples:
% nimi mi li Lope.
sentence_declarative(S) -->
  designate(D),
  {removing_extraneous_tree_nodes_pr_a('dec',S,D)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% exclamatory sentences:

% A exclamatory sentence can build of optional "la"-phrases, a simple sentence and optional "la"-phrases.
% examples:
% ken la mi moku e moku!
% ken la mi moku e moku la tenpo kama a!
sentence_exclamatory(S) -->
  la_phrases(L1),
  sentence_simple(SS),
  la_phrase_follow(L2),
  {removing_extraneous_tree_nodes_pr_abc('exc',S,L1,SS,L2)}.

% A exclamatory sentence can build of two simple sentences separated by a colon with optional "la"-phrases.
% examples:
% mi wile e ni: sina moku e moku!
% ken la mi wile e ni: sina moku e moku!
sentence_exclamatory(S) -->
  la_phrases(L1),
  sentence_simple(SS1),
  separator(Sep,':'),
  la_phrases(L2),
  sentence_simple(SS2),
  {removing_extraneous_tree_nodes_pr_abcde('exc',S,L1,SS1,Sep,L2,SS2)}.

% A exclamatory sentence can be a yes answer.
% examples:
% moku!
% moku ala a!
sentence_exclamatory(S) -->
  answer_yes(A),
  {removing_extraneous_tree_nodes_pr_a('exc',S,A)}.

% A exclamatory sentence can be a no answer.
% examples:
% moku ala!
% moku ala a!
sentence_exclamatory(S) -->
  answer_no(A),
  {removing_extraneous_tree_nodes_pr_a('exc',S,A)}.

% A exclamatory sentence can be a vocativ sentence (addressing people).
% examples:
% jan Lope o, sina moku e moku a!
sentence_exclamatory(S) -->
  vocativ(V),
  {removing_extraneous_tree_nodes_pr_a('exc',S,V)}.

% A exclamatory sentence can be a salutation.
% examples:
% jan Lope o, toki a!
sentence_exclamatory(S) -->
  salutation(Sa),
  {removing_extraneous_tree_nodes_pr_a('exc',S,Sa)}.

% A exclamatory sentence can be an interjection.
% examples:
% ken la jaki!
sentence_exclamatory(S) -->
  la_phrases(L),
  interjection(I),
  {removing_extraneous_tree_nodes_pr_ab('exc',S,L,I)}.

% A exclamatory sentence can be an interjection and vocativ sentence.
% examples:
% sina o, toki!
sentence_exclamatory(S) -->
  vocativ_interjection(V),
  {removing_extraneous_tree_nodes_pr_a('exc',S,V)}.

% A exclamatory sentence can be an special sentence for designate.
% examples:
% nimi mi li Lope!
sentence_exclamatory(S) -->
  designate(D),
  {removing_extraneous_tree_nodes_pr_a('exc',S,D)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% imperative sentences:

% An imperative sentence can build of a command and "la"-phrases.
% examples:
% tenpo kama la o moku e moku!
% tenpo kama la o moku e moku la ken!
sentence_imperative(S) -->
  la_phrases(L1),
  command(CO),
  la_phrase_follow(L2),
  {removing_extraneous_tree_nodes_pr_abc('imp',S,L1,CO,L2)}.

% An imperative sentence can build of a simple sentence and a command and "la"-phrases.
% examples:
% tenpo kama la mi wile e ni: ken la o moku e moku!
sentence_imperative(S) -->
  la_phrases(L1),
  sentence_simple(SS),
  separator(Sep,':'),
  la_phrases(L2),
  command(CO),
  {removing_extraneous_tree_nodes_pr_abcde('imp',S,L1,SS,Sep,L2,CO)}.

% An imperative sentence can build of a command and a simple sentence separated by a colon with optional "la"-phrases.
% examples:
% tenpo kama la o wile e ni: sina moku e moku!
sentence_imperative(S) -->
  la_phrases(L1),
  command(CO),
  separator(Sep,':'),
  la_phrases(L2),
  sentence_simple(SS),
  {removing_extraneous_tree_nodes_pr_abcde('imp',S,L1,CO,Sep,L2,SS)}.

% An imperative sentence can build of two commands separated by a colon with optional "la"-phrases.
% examples:
% tenpo kama la o wile e ni: o moku e moku!
sentence_imperative(S) -->
  la_phrases(L1),
  command(CO1),
  separator(Sep,':'),
  la_phrases(L2),
  command(CO2),
  {removing_extraneous_tree_nodes_pr_abcde('imp',S,L1,CO1,Sep,L2,CO2)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% interrogative sentences:

% An interrogative sentence can be build of a question and "la" phrases.
% examples:
% tenpo kama la seme la ken?
sentence_interrogative(S) -->
  la_phrases(L1),
  question(Q),
  la_phrase_follow(L2),
  {removing_extraneous_tree_nodes_pr_abc('int',S,L1,Q,L2)}.

% An interrogative sentence can be build of a sentence simple and a question separated by a colon and "la" phrases.
% examples:
% ken la mi pilin e ni: seme?
sentence_interrogative(S) -->
  la_phrases(L1),
  sentence_simple(SS),
  separator(Sep,':'),
  la_phrases(L2),
  question(Q),
  {removing_extraneous_tree_nodes_pr_abcde('int',S,L1,SS,Sep,L2,Q)}.

% An interrogative sentence can be build of a question and a sentence simple separated by a colon and "la" phrases.
% examples:
% tenpo kama la seme: ken la mi moku e moku?
sentence_interrogative(S) -->
  la_phrases(L1),
  question(Q),
  separator(Sep,':'),
  la_phrases(L2),
  sentence_simple(SS),
  {removing_extraneous_tree_nodes_pr_abcde('int',S,L1,Q,Sep,L2,SS)}.

% An interrogative sentence can be build of two questions separated by a colon and "la" phrases.
% examples:
% tenpo kama la seme: ken la seme?
sentence_interrogative(S) -->
  la_phrases(L1),
  question(Q1),
  separator(Sep,':'),
  la_phrases(L2),
  question(Q2),
  {removing_extraneous_tree_nodes_pr_abcde('int',S,L1,Q1,Sep,L2,Q2)}.

% A question as "la" phrase.
% examples:
% seme la sina pilin e ni?
sentence_interrogative(S) -->
  la_phrase_question(LQ),
  sentence_simple(SS),
  {removing_extraneous_tree_nodes_pr_ab('int',S,LQ,SS)}.

% An interrogative sentence (question) can be a vocativ question.
% examples:
% sina o, sina moku e seme?
sentence_interrogative(S) -->
  vocativ_question(VQ),
  {removing_extraneous_tree_nodes_pr_a('int',S,VQ)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% headline_simple phrases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This definitions of headlines are incorrect at the moment ;-)

% A headline is not a complete sentence.
% examples:
% moku soweli
% moku pi soweli suli
% sitelen lon tomo
% headline(HL) -->
%   subjects_all(SU),
%   {removing_extraneous_tree_nodes_pr_a('hdl',HL,SU)}.
headline_simple(HL) -->
  objects_intrans(IO),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_ab(HL,IO,PO)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sentence main phrases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% simple sentence:

% A simple sentence consist of a noun phrase and verb phrases.
% examples:
% jan li lukin e ma.
sentence_simple(S) -->
  noun_phrase(NP),
  verb_phrases(VP),
  {removing_extraneous_tree_nodes_pr_ab('sim',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% answers yes/no

% A yes answer consists of a verb phrase without "ala".
% examples:
% pali.
% pali!
answer_yes(S) -->
  answer_yes_phrase(AP),
  {removing_extraneous_tree_nodes_pr_a('answer',S,AP)}.

% A no answer consists of a verb phrase with "ala".
% examples:
% wile ala.
% wile ala!
answer_no(S) -->
  answer_no_phrase(AP),
  {removing_extraneous_tree_nodes_pr_a('answer',S,AP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% vocativ

% A vocativ sentence consists of a vocativ phrase and a simple sentence.
% examples:
% sina o, sina toki e ni.
% sina o, sina toki e ni!
% sina o, sina toki e ni!
vocativ(S) -->
  vocativ_phrase(VO),
  sentence_simple(SS),
  {removing_extraneous_tree_nodes_pr_ab('voc',S,VO,SS)}.

% A vocativ salutation consists of a vocativ phrase and a salutation phrase.
% examples:
% sina o, toki!
vocativ_interjection(S) -->
  vocativ_phrase(VO),
  salutation_phrase(SP),
  {removing_extraneous_tree_nodes_pr_ab('voc',S,VO,SP)}.

% A vocativ interjection consists of a vocativ phrase and a interjection phrase.
% examples:
% sina o, pakala!
% sina o, a a a!
% sina o, sina o a!
vocativ_interjection(S) -->
  vocativ_phrase(VO),
  interjection_phrases(IP),
  {removing_extraneous_tree_nodes_pr_ab('voc',S,VO,IP)}.

% A vocativ question consists of a vocativ phrase and a question.
% examples:
% sina o, seme?
vocativ_question(S) -->
  vocativ_phrase(VO),
  question(Q),
  {removing_extraneous_tree_nodes_pr_ab('voc',S,VO,Q)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% interjection

% A interjection can consists of interjection phrases.
% examples:
% pakala!
% jaki!
% pona!
% kin!
% a a a!
interjection(S) -->
  interjection_phrases(IP),
  {removing_extraneous_tree_nodes_pr_a('inj',S,IP)}.

% A interjection can consists of special noun phrase with an interjection word and verb phrases.
% examples:
% ken la sina a kama!       (pu)
interjection(S) -->
  noun_phrase_interjection(NPI),
  verb_phrases(VP),
  {removing_extraneous_tree_nodes_pr_ab('inj',S,NPI,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% salutation

% A salutation can consists a special phrase for salutation.
% examples:
% toki!
% pona!
salutation(S) -->
  salutation_phrase(SP),
  {removing_extraneous_tree_nodes_pr_a('salut',S,SP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% command

% A command can consists ofa special noun phrase for a command and verb phrases.
% examples:
% o pona e tomo!
command(S) -->
  noun_phrase_command(NP),
  verb_phrases(VP),
  {removing_extraneous_tree_nodes_pr_ab('com',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% designate

% A designate consists of a special noun phrase and a special verb phrase.
% examples:
% nimi mi li Lope.
designate(S) -->
  noun_phrase_designate_person(NP),
  verb_phrase_designate_person(VP),
  {removing_extraneous_tree_nodes_pr_ab('des',S,NP,VP)}.

% examples:
% nimi pi ma suli mi li Elopa.
designate(S) -->
  noun_phrase_designate_continent(NP),
  verb_phrase_designate_continent(VP),
  {removing_extraneous_tree_nodes_pr_ab('des',S,NP,VP)}.

% examples:
% nimi pi ma mi li Tosi.
designate(S) -->
  noun_phrase_designate_country(NP),
  verb_phrase_designate_country(VP),
  {removing_extraneous_tree_nodes_pr_ab('des',S,NP,VP)}.

% examples:
% nimi pi ma tomo mi li Pelin.
designate(S) -->
  noun_phrase_designate_city(NP),
  verb_phrase_designate_city(VP),
  {removing_extraneous_tree_nodes_pr_ab('des',S,NP,VP)}.

% examples:
% nimi pi toki mi li Tosi.
designate(S) -->
  noun_phrase_designate_language(NP),
  verb_phrase_designate_language(VP),
  {removing_extraneous_tree_nodes_pr_ab('des',S,NP,VP)}.

% examples:
% nimi pi toki luka mi li Tosi.
designate(S) -->
  noun_phrase_designate_sign_language(NP),
  verb_phrase_designate_sign_language(VP),
  {removing_extraneous_tree_nodes_pr_ab('des',S,NP,VP)}.

% examples:
% nimi pi nasin sewi mi li Patapali.
designate(S) -->
  noun_phrase_designate_ideology(NP),
  verb_phrase_designate_ideology(VP),
  {removing_extraneous_tree_nodes_pr_ab('des',S,NP,VP)}.

% examples:
% nimi pi kulupu mi li Neje.
designate(S) -->
  noun_phrase_designate_community(NP),
  verb_phrase_designate_community(VP),
  {removing_extraneous_tree_nodes_pr_ab('des',S,NP,VP)}.

% examples:
% nimi pi sitelen tawa ni li X-Files.
designate(S) -->
  noun_phrase_designate_movie(NP),
  verb_phrase_designate_movie(VP),
  {removing_extraneous_tree_nodes_pr_ab('des',S,NP,VP)}.

% examples:
% nimi pi tomo tawa mi li Pata.
designate(S) -->
  noun_phrase_designate_misc(NP),
  verb_phrase_designate_misc(VP),
  {removing_extraneous_tree_nodes_pr_ab('des',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question pardon

% A pardon question consists of the word "seme".
% examples:
% seme?
question(S) -->
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_a('pardon',S,QW)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question yes no

% A yes/no question consists of a noun phrase and a special verb phrase with "ala".
% examples:
% sina wile ala wile moku e telo?
question(S) -->
  noun_phrase(NP),
  verb_phrase_question_yn(VP),
  {removing_extraneous_tree_nodes_pr_ab('yes_no',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question decision

% A decision question (subject) can consists of a special noun phrase with "anu" and a verb phrase.
% examples:
% sina anu ona li moku e moku?
question(S) -->
  noun_phrase_question_decision(NP),
  verb_phrases(VP),
  {removing_extraneous_tree_nodes_pr_ab('decision_subject',S,NP,VP)}.

% A decision question (vp) can consists of a noun phrase and a special verb phrase with "anu".
% examples:
% sina moku e moku anu pona e ilo?
question(S) -->
  noun_phrase(NP),
  verb_phrases_question_decision(VP),
  {removing_extraneous_tree_nodes_pr_ab('decision_vp',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question "or what"

% A "or what" question consists of a noun phrase and a special verb phrase with "anu seme".
% examples:
% sina moku e moku anu seme?
question(S) -->
  noun_phrase(NP),
  verb_phrases_question_or_what(VP),
  {removing_extraneous_tree_nodes_pr_ab('or_what',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question what

% A "what" question (subject) consists of a special noun phrase with "seme" and verb phrases.
% examples:
% seme li pakala e ilo?
question(S) -->
  noun_phrase_what(NP),
  verb_phrases(VP),
  {removing_extraneous_tree_nodes_pr_ab('what_subject',S,NP,VP)}.

% A "what" question (direct object) consists of a noun phrase and a special verb phrases with "e" and "seme".
% examples:
% ona li moku e seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_what_object_d(VP),
  {removing_extraneous_tree_nodes_pr_ab('what_d_object',S,NP,VP)}.

% A "what" question (indirect object) consists of a noun phrase and a special verb phrases with "seme".
% examples:
% sina kepeken seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_what_object_i(VP),
  {removing_extraneous_tree_nodes_pr_ab('what_i_object',S,NP,VP)}.

% A "what" question (prepositional object) consists of a noun phrase and a special verb phrases with a preposition and "seme".
% examples:
% sina pali e ni, kepeken seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_what_object_p(VP),
  {removing_extraneous_tree_nodes_pr_ab('what_p_object',S,NP,VP)}.

% A "what is" question (object) consists of a noun phrase and a special verb phrases with a noun and "seme".
% examples:
% ona li moku seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_what_is_object(VP),
  {removing_extraneous_tree_nodes_pr_ab('what_is_object',S,NP,VP)}.

% A "what" question (verb) consists of a noun phrase and a special verb phrases
% with "seme" as transitive or intransitive rb.
% examples:
% ona li seme e ijo, kepeken ilo?
% sina seme mi?
question(S) -->
  noun_phrase(NP),
  verb_phrases_what_verb_trans(VP),
  {removing_extraneous_tree_nodes_pr_ab('what_verb',S,NP,VP)}.
question(S) -->
  noun_phrase(NP),
  verb_phrases_what_verb_intrans(VP),
  {removing_extraneous_tree_nodes_pr_ab('what_verb',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% questions where, where from

% A where-question consists of a noun phrase and a special verb phrases with the preposition "lon" and "seme".
% examples:
% ona li moku e moku, lon seme?
% ona li moku e moku, lon poka seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_where(VP),
  {removing_extraneous_tree_nodes_pr_ab('where',S,NP,VP)}.

% A where-from-question consists of a noun phrase and a special verb phrases with the preposition "tan" and "seme".
% examples:
% ona li kama, tan ma tomo seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_wherefrom(VP),
  {removing_extraneous_tree_nodes_pr_ab('where_from',S,NP,VP)}.

% A where-to-question consists of a noun phrase and a special verb phrases with the preposition "tawa" and "seme".
% examples:
% ona li tawa e kiwen, tawa anpa seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_whereto(VP),
  {removing_extraneous_tree_nodes_pr_ab('where_to',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question who

% A who-question (subject) consists of a special noun phrase with "jan", "meli" or mije" and verb phrases.
% examples:
% jan seme pi mama sina li moku e moku?
% meli seme pi jan ni pi tawa musi li ' pona, tawa sina?
% mije seme pi jan ni li ' pona, tawa sina?
question(S) -->
  noun_phrase_who(NP),
  verb_phrases(VP),
  {removing_extraneous_tree_nodes_pr_ab('who',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question whom

% A whom-question (object) consists of a noun phrase and a special verb phrase with "jan", "meli" or mije".
% examples:
% ona li pakala e ijo e jan pona seme?
% ona li pakala e tomo, tan jan mije seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_whom(VP),
  {removing_extraneous_tree_nodes_pr_ab('whom',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question which

% A which-question (subject) consists of a special noun phrase with a noun followed by "seme" as an adjective and verb phrases.
% examples:
% ma seme li pona, tawa sina?
question(S) -->
  noun_phrase_which(NP),
  verb_phrases(VP),
  {removing_extraneous_tree_nodes_pr_ab('which_subject',S,NP,VP)}.

% A which-question (object) consists of a noun phrase and a special verb phrase with a noun followed by "seme" as an adjective.
% examples:
% sina pakala, tawa ijo seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_which(VP),
  {removing_extraneous_tree_nodes_pr_ab('which_object',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question when

% A when-question (object) consists of a noun phrase and a special verb phrase with the noun "tenpo" followed by "seme" as an adjective.
% examples:
% sina moku e moku, lon tenpo seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_when(VP),
  {removing_extraneous_tree_nodes_pr_ab('when_object',S,NP,VP)}.

% A when-question ("la"-phrase") consists of a "la"-phrase with the noun "tenpo" followed by "seme" as an adjective,
% a noun phrase and verb phrases.
% examples:
% tenpo seme la sina moku e moku?
question(S) -->
  la_phrase_when(LA),
  noun_phrase(NP),
  verb_phrases(VP),
  {removing_extraneous_tree_nodes_pr_abc('when_la',S,LA,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question why

% A why-question (object) consists of a noun phrase and a special verb phrase with the preposition "tan" followed by "seme".
% examples:
% sina pali e tomo, tan seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_why(VP),
  {removing_extraneous_tree_nodes_pr_ab('why_object',S,NP,VP)}.

% A why-question ("la"-phrase") consists of a "la"-phrase with the preposition "tan" followed by "seme", a noun phrase and verb phrases.
% examples:
% tan seme la soweli wawa pimeja li moku e ona?
question(S) -->
  la_phrase_why(LA),
  noun_phrase(NP),
  verb_phrases(VP),
  {removing_extraneous_tree_nodes_pr_abc('why_la',S,LA,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question how

% A how-question (object) consists of a noun phrase and a special verb phrase with the noun "nasin" followed by "seme".
% examples:
% sina pali e ni, kepeken nasin seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_how(VP),
  {removing_extraneous_tree_nodes_pr_ab('how_object',S,NP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question how many

% A how-many-question ("la"-phrase") consists of a "la"-phrase with "mute" followed by "seme", a noun phrase and verb phrases.
% examples:
% tenpo pi mute seme la sina sike e suno?
question(S) -->
  la_phrase_how_many(LA),
  noun_phrase(NP),
  verb_phrases(VP),
  {removing_extraneous_tree_nodes_pr_abc('how_many_la',S,LA,NP,VP)}.

% A how-many-question (subject) consists of a special noun phrase with "mute" followed by "seme" and verb phrases.
% examples:
% soweli pi mute seme li moku e telo?
question(S) -->
  noun_phrase_how_many(NP),
  verb_phrases(VP),
  {removing_extraneous_tree_nodes_pr_ab('how_many_subject',S,NP,VP)}.

% A how-many-question (object) consists of a noun phrase and a special verb phrase with "mute"" followed by "seme".
% examples:
% akesi li pakala e tomo e soweli pi mute seme?
question(S) -->
  noun_phrase(NP),
  verb_phrase_how_many(VP),
  {removing_extraneous_tree_nodes_pr_ab('how_many_object',S,NP,VP)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  noun phrases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% standard noun phrase

% A noun phrase can consists of a subject with the pronoun "mi" or "sina".
% examples:
% mi moku e moku!
% sina moku e moku.
noun_phrase(NP) -->
  subject_no_li(SUB),
  {removing_extraneous_tree_nodes_pr_a('np',NP,SUB)}.

% A noun phrase can consists of a subject and the separator "li".
% The subject can't be only "mi" or "sina".
% examples:
% ona li moku e moku!
% ni li moku e moku.
% akesi ike li moku e moku.
noun_phrase(NP) -->
  subject_with_li(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% A noun phrase can consists of several subjects and the separator "li".
% examples:
% ona li pona e tawa.
% ni li pona, tawa sina.
noun_phrase(NP) -->
  subjects(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% interjection noun phrase

% A noun phrase (interjection) can consists of the pronoun "mi" or "sina" and the interjection word "a".
% examples:
% sina a moku e moku!
noun_phrase_interjection(NP) -->
  subject_no_li(SUB),
  interjection_word(IW,a),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,IW)}.

% A noun phrase (interjection) can consists of a subject, the interjection word "a" and the separator "li".
% The subject can't be only "mi" or "sina".
% examples:
% ona a li pona e tawa!
% ona pona a li moku e moku!
% ni a li moku e moku!
% akesi ike a li moku e moku!
noun_phrase_interjection(NP) -->
  subject_with_li(SUB),
  interjection_word(IW,a),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_abc('np',NP,SUB,IW,Sep)}.

% A noun phrase (interjection) can consists of several subjects and the separator "li".
% examples:
% ona en sina en mi a li moku e moku!
% ona pona en sina en mi a li moku e moku!
% soweli en akesi en pipi lili en mi a li moku e moku!
noun_phrase_interjection(NP) -->
  subjects(SUB),
  interjection_word(IW,a),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_abc('np',NP,SUB,IW,Sep)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question noun phrases

% A noun phrase (question decision) can consists of subjects, the conjunction "anu", subjects, and the separator "li".
% examples:
% sina en ona anu sina en mi li moku e moku?
noun_phrase_question_decision(NP) -->
  subjects_all(Sub1),
  conjunction(Con,anu),
  subjects_all(Sub2),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_abcd('np',NP,Sub1,Con,Sub2,Sep)}.

% A noun phrase (question what) can consists of the subject (what) and the separator "li".
% examples:
% seme li moku e moku?
noun_phrase_what(NP) -->
  subject_what(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% A noun phrase (question who) consists of a subject (who) and the separator "li".
% examples:
% jan seme li moku e moku?
% jan pona seme li moku e moku?
% jan seme pi mama sina li moku e moku?
% jan pona seme pi mama sina li moku e moku?
noun_phrase_who(NP) -->
  subject_who(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% A noun phrase (question which) can consists of a noun (no person), optional adjectives, the question word "seme" and the separator "li".
% examples:
% ma seme li ' pona, tawa sina?
% ma tomo seme li ' pona, tawa sina?
% ma seme pi mama sina li ' pona, tawa sina?
% ma tomo seme pi mama sina li ' pona, tawa sina?
% ma tomo seme pi mama sina li ' pona, tawa sina?
noun_phrase_which(NP) -->
  subject_which(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% A noun phrase (question how many) consists of the subject (how many) and the separator "li".
% examples:
% soweli pi mute seme li moku e telo?
% ona en sina pi mute seme li moku e telo?
noun_phrase_how_many(NP) -->
  subject_how_many(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% command noun phrases

% A noun phrase (command) can consists of optional subjects and the separator "o".
% examples:
% o pona e tomo!
% sina o pona e tomo!
% jan o pona e tomo!
% ona en sina mute o pona e tomo!

noun_phrase_command(NP) -->
  separator(Sep,o),
  {removing_extraneous_tree_nodes_pr_a('np',NP,Sep)}.

noun_phrase_command(NP) -->
  subjects_all(SUBA),
  separator(Sep,o),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUBA,Sep)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% designate noun phrases

% A noun phrase (designate) consists of a special subject and the separator "li".
% name
% examples:
% nimi mi li Lope.
noun_phrase_designate_person(NP) -->
  subject_designate_person(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% continent
% examples:
% nimi pi ma suli mi li Elopa.
noun_phrase_designate_continent(NP) -->
  subject_designate_continent(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% country
% examples:
% nimi pi ma mi li Tosi.
noun_phrase_designate_country(NP) -->
  subject_designate_country(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% city
% examples:
% nimi pi ma tomo mi li Pelin.
noun_phrase_designate_city(NP) -->
  subject_designate_city(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% language
% examples:
% nimi pi toki mi li Tosi.
noun_phrase_designate_language(NP) -->
  subject_designate_language(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% sign language
% examples:
% nimi pi toki luka mi li Tosi.
noun_phrase_designate_sign_language(NP) -->
  subject_designate_sign_language(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% ideology, religion
% examples:
% nimi pi nasin sewi mi li Patapali.
% nimi pi nasin pona mi li Patapali.
noun_phrase_designate_ideology(NP) -->
  subject_designate_ideology(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% community
% examples:
% nimi pi kulupu mi li Patapali.
noun_phrase_designate_community(NP) -->
  subject_designate_community(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% movies
% examples:
% nimi pi sitelen tawa ni li X-Files.
noun_phrase_designate_movie(NP) -->
  subject_designate_movie(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.

% miscellaneous
% examples:
% nimi pi tomo tawa mi li Tapan.
% nimi pi tomo tawa pona mi li Tapan.
noun_phrase_designate_misc(NP) -->
  subject_designate_misc(SUB),
  separator(Sep,li),
  {removing_extraneous_tree_nodes_pr_ab('np',NP,SUB,Sep)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  verb phrases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Verb phrases consist of one verb phrase and optional up to three additional verb phrases.
% examples:
% ona li moku e moku.
% ona li moku e moku li toki e ni.
% ona li moku e moku li jo e kili li toki e ni.
% ona li moku e moku li jo e kili li pali e tomo li toki e ni.

verb_phrases(VPS) -->
  verb_phrase(VP),
  {removing_extraneous_tree_nodes_a(VPS,VP)}.

verb_phrases(VPS) -->
  verb_phrase(VP),
  verb_phrase_add(VPA1),
  {removing_extraneous_tree_nodes_ab(VPS,VP,VPA1)}.

verb_phrases(VPS) -->
  verb_phrase(VP),
  verb_phrase_add(VPA1),
  verb_phrase_add(VPA2),
  {removing_extraneous_tree_nodes_abc(VPS,VP,VPA1,VPA2)}.

verb_phrases(VPS) -->
  verb_phrase(VP),
  verb_phrase_add(VPA1),
  verb_phrase_add(VPA2),
  verb_phrase_add(VPA3),
  {removing_extraneous_tree_nodes_abcd(VPS,VP,VPA1,VPA2,VPA3)}.

% A additional verb phrase consists of an optional comma (ignored here), the separator "li" and a verb phrase.
% examples:
% sina moku e moku li toki e toki.
% sina moku e moku, li toki e toki.
verb_phrase_add(VPA) -->
  comma_optional,
  separator(Sep,li),
  verb_phrase(VP),
  {removing_extraneous_tree_nodes_pr_ab('vp',VPA,Sep,VP)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases with different types of objects (direct, intrans, prepositional, after missing "be")

% A verb phrase can consist of a (compound) transitive verb, optional direct objects and optional prepositional objects.
% examples:
% sina moku e moku, kepeken ilo moku li toki e ni.
verb_phrase(VP) -->
  verb_transitive_compound(VTC),
  objects_direct(DO),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abc('vp',VP,VTC,DO,PO)}.

% A verb phrase can consist of a compound intransitive verb, optional intransitive objects and optional prepositional objects.
% examples:
% ona li kepeken sitelen pi ilo nanpa.
% ona li kepeken sitelen pi ilo nanpa, kepeken oko ona.
% ona li kepeken sitelen pi sina pona, kepeken oko ona.
verb_phrase(VP) -->
  verb_intransitive_compound(VIC),
  objects_intrans(IO),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abc('vp',VP,VIC,IO,PO)}.

% In toki pona is no verb "to be".
% A verb phrase can consists of an special object and optional prepositional objects.
% Inofficial: You can use an apostrophe instead of "to be".
% examples:
% sina jelo.
% sina ' jelo.
% sina jelo loje.
% ona li pona, tawa mi mute.
% ona li ' pona, tawa mi mute.
% jan Lope li ona.
% jan Lope li ' ona.
% jan Lope en jan Mewi li ona mute.
% jan Lope en jan Mewi li ' ona mute.
% ni li ona mute, tawa mi mute.
% ni li ' ona mute, tawa mi mute.
% ona li jan pi pona mute.
% ona li ' jan pi pona mute.
% ona li jan pi pona mute, tawa mi mute.
% ona li ' jan pi pona mute, tawa mi mute.
verb_phrase(VP) -->
  verb_be(Be),
  object_be(OB),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abc('vp',VP,Be,OB,PO)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% special verb phrases for designate sentences.

% A verb phrase (designate) consist of an special object.
% In toki pona is no verb "to be".
% examples:
% nimi mi li Mawija.
% nimi mi li ' Mawija.
% nimi mi li Mose.
% nimi mi li Lisa.
% nimi mi li ' Lope.
% nimi mi li Devil.
% nimi mi li Lopen.
verb_phrase_designate_person(VPD) -->
  verb_be(V),
  object_be_designate_person(O), !,
  {removing_extraneous_tree_nodes_pr_ab('vp',VPD,V,O)}.

% examples:
% nimi pi ma suli mi li Elopa.
verb_phrase_designate_continent(VPD) -->
  verb_be(V),
  object_be_designate_continent(OB), !,
  {removing_extraneous_tree_nodes_pr_ab('vp',VPD,V,OB)}.

% examples:
% nimi pi ma mi li ' Tosi.
verb_phrase_designate_country(VPD) -->
  verb_be(V),
  object_be_designate_country(OB), !,
  {removing_extraneous_tree_nodes_pr_ab('vp',VPD,V,OB)}.

% examples:
% nimi pi ma tomo mi li Pelin.
verb_phrase_designate_city(VPD) -->
  verb_be(V),
  object_be_designate_city(OB), !,
  {removing_extraneous_tree_nodes_pr_ab('vp',VPD,V,OB)}.

% examples:
% nimi pi toki mi li Tosi.
verb_phrase_designate_language(VPD) -->
  verb_be(V),
  object_be_designate_language(OB), !,
  {removing_extraneous_tree_nodes_pr_ab('vp',VPD,V,OB)}.

% examples:
% nimi pi toki luka mi li Tosi.
verb_phrase_designate_sign_language(VPD) -->
  verb_be(V),
  object_be_designate_sign_language(OB), !,
  {removing_extraneous_tree_nodes_pr_ab('vp',VPD,V,OB)}.

% examples:
% nimi pi nasin sewi mi li ' Patapali.
verb_phrase_designate_ideology(VPD) -->
  verb_be(V),
  object_be_designate_ideology(OB) , !,
  {removing_extraneous_tree_nodes_pr_ab('vp',VPD,V,OB)}.

% examples:
% nimi pi kulupu mi li Neje.
verb_phrase_designate_community(VPD) -->
  verb_be(V),
  object_be_designate_community(OB), !,
  {removing_extraneous_tree_nodes_pr_ab('vp',VPD,V,OB)}.

% examples:
% nimi pi sitelen tawa ni li X-Files.
verb_phrase_designate_movie(VPD) -->
  verb_be(V),
  object_be_designate_movie(OB), !,
  {removing_extraneous_tree_nodes_pr_ab('vp',VPD,V,OB)}.

% examples:
% nimi pi tomo tawa mi li ' Pata.
verb_phrase_designate_misc(VPD) -->
  verb_be(V),
  object_be_designate_misc(OB), !,
  {removing_extraneous_tree_nodes_pr_ab('vp',VPD,V,OB)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (yes/no questions)

% A verb phrase (yes/no question) can consists of a transitive verb, the adverb "ala",
% the same transitive verb again, optional direct objects and optional prepositional objects.
% examples:
% sina pona ala pona?
% sina pona ala pona e tomo ni, kepeken ilo ni?
verb_phrase_question_yn(VPQ) -->
  verb_transitive(VT1,Verb),
  adverb(ADV,ala),
  verb_transitive(VT2,Verb),
  objects_direct(DO),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abcde('vp',VPQ,VT1,ADV,VT2,DO,PO)}.

% A verb phrase (yes/no question) can consists of a auxiliary verb, the adverb "ala",
% the same auxiliary verb again, a transitive verb, optional direct objects and optional prepositional objects.
% examples:
% sina wile ala wile alasa e soweli suli, kepeken palisa wawa?
verb_phrase_question_yn(VPQ) -->
  verb_pre(VP1,Verb_pre),
  adverb(ADV,ala),
  verb_pre(VP2,Verb_pre),
  verb_transitive(VT,Verb),   { Verb \= Verb_pre },
  objects_direct(DO),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abcdef('vp',VPQ,VP1,ADV,VP2,VT,DO,PO)}.

% A verb phrase (yes/no question) can consists of a auxiliary verb, the adverb "ala",
% the same auxiliary verb again, optional direct objects and optional prepositional objects.
% examples:
% sina wile ala wile e soweli suli, kepeken linja?
verb_phrase_question_yn(VPQ) -->
  verb_pre(VP1,Verb_pre),
  adverb(ADV,ala),
  verb_pre(VP2,Verb_pre),
  objects_direct(DO),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abcde('vp',VPQ,VP1,ADV,VP2,DO,PO)}.

% A verb phrase (yes/no question) can consists of a intransitive verb, the adverb "ala",
% the same intransitive verb again, optional intransitive objects and optional prepositional objects.
% examples:
% ona li tawa ala tawa?
% ona li tawa ala tawa ni?
% ona li tawa ala tawa, tawa sina?
% ona li unpa ala unpa sina?
verb_phrase_question_yn(VPQ) -->
  verb_intransitive(VI1,Verb),
  adverb(ADV,ala),
  verb_intransitive(VI2,Verb),
  objects_intrans(IO),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abcde('vp',VPQ,VI1,ADV,VI2,IO,PO)}.

% A verb phrase (yes/no question) can consists of a auxiliary verb, the adverb "ala",
% the same auxiliary verb again, an intransitive verb and optional intransitive objects.
% examples:
% sina wile ala wile unpa?
% sina wile ala wile unpa ona?
verb_phrase_question_yn(VPQ) -->
  verb_pre(VP1,Verb_pre),
  adverb(ADV,ala),
  verb_pre(VP2,Verb_pre),
  verb_intransitive(VI,Verb),  { Verb \= Verb_pre },
  objects_intrans(IO),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abcdef('vp',VPQ,VP1,ADV,VP2,VI,IO,PO)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (desicsion questions)

% Verb phrases (desicsion question) consist of verb phrases, the conjuncion "anu" and other verb phrases.
% examples:
% sina wile moku e moku anu wile moku e telo?
verb_phrases_question_decision(VPQ) -->
  verb_phrases(VP1),
  conjunction(CON,anu),
  verb_phrases(VP2),
  { VP1 \= VP2 },
  {removing_extraneous_tree_nodes_abc(VPQ,VP1,CON,VP2)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question "or what")

% A verb phrase (question or what) consists of verb phrases,
% the conjunction "anu", a special verb phase with "seme" and optional a prepositional object.
% examples:
% sina pali e tomo anu seme?
% sina pali e tomo anu seme, kepeken ilo?
verb_phrases_question_or_what(VPSQ) -->
  verb_phrases(VP),
  conjunction(Con,anu),
  verb_phrase_question_or_what(VPQ),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_abcd(VPSQ,VP,Con,VPQ,PO)}.

verb_phrase_question_or_what(VPQ) -->
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_a(VPQ,QW)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question what direct object)

% A verb phrase (question what direct object) consists of transitive compound verb,
% the separator "e", a special object and optional a prepositional object.
% examples:
% sina kipisi e seme?
% sina kipisi e seme, kepeken ilo ni?
verb_phrase_what_object_d(VPQ) -->
  verb_transitive_compound(VTC),
  object_direct_what(OQ),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abc('vp',VPQ,VTC,OQ,PO)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question what indirect object)

% A verb phrase (question what intransitive object) consists of intransitive compound verb,
% a special indirect object and optional a prepositional object.
% examples:
% sina ken mute seme?
% sina ken mute seme, kepeken ni?
verb_phrase_what_object_i(VPQ)       -->
  verb_intransitive_compound(VTC),
  object_indirect_what(OQ),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abc('vp',VPQ,VTC,OQ,PO)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question what prepositional object)

% A verb phrase (question what prepositional object) consists of transitive compound verb
% and a special prepositional object.
% The preposition "lon" is for where-questions. "tan" is for why- and wherefrom-questions.
% examples:
% sina namako lili, poka seme?
% sina namako lili e moku, poka seme?
verb_phrase_what_object_p(VPQ)      -->
  verb_transitive_compound(VTC),
  objects_direct(DO),
  object_prepositional_what(OQ),
  {removing_extraneous_tree_nodes_pr_abc('vp',VPQ,VTC,DO,OQ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question what object after missing "be")

% A verb phrase (question what is object) consists of  a special object and optional prepositional objecs.
% In toki pona is no verb "to be".
% examples:
% sina seme?
% sina ' seme?
% sina ' seme, kepeken ni?
verb_phrase_what_is_object(VPQ) -->
  verb_be(Be),
  object_be_what_is(OQ),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abc('vp',VPQ,Be,OQ,PO)}.

% A verb phrase (question what is object) consists of  a special object and optional prepositional objecs.
% In toki pona is no verb "to be".
% examples:
% ona li jan pi pana sona seme?
verb_phrase_what_is_object(VPQ) -->
  verb_be(Be),
  object_be_what_is_adjective(OQ),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abc('vp',VPQ,Be,OQ,PO)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question what transitive/intrasitive verb)

% A verb phrase (question what transitive verb) consists of the question word "seme" as transitive verb,
% optional intransitive objects and optional prepositional objects.
% examples:
% sina seme?
% sina seme e soweli suli?
% sina seme e soweli suli, kepeken palisa wawa?
verb_phrases_what_verb_trans(VPQ) -->
  verb_phrase_what_verb_trans(VP),
  objects_direct(DO),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abc('vp',VPQ,VP,DO,PO)}.

verb_phrase_what_verb_trans(VPQ) -->
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_a('verb_tra',VPQ,QW)}.

% A verb phrase (question what intransitive verb) consists of the question word "seme" as intransitive verb,
% optional intransitive objects and optional prepositional objects.
% examples:
% ona li seme?
% ona li seme sitelen pi ilo nanpa?
% ona li seme sitelen pi ilo nanpa, kepeken oko?
% ona li seme sitelen pi ilo nanpa, mute, kepeken oko?
verb_phrases_what_verb_intrans(VPQ) -->
  verb_phrase_what_verb_intrans(VP),
  objects_intrans(IO),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_pr_abc('vp',VPQ,VP,IO,PO)}.

verb_phrase_what_verb_intrans(VPQ) -->
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_a('verb_int',VPQ,QW)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question where)

% A verb phrase (question where) can consists of a compound transitive verb,
% direct objects and a special prepositional object phrase..
% examples:
% sina moku e moku, lon seme?
verb_phrase_where(VPQ) -->
  verb_transitive_compound(VTC),
  objects_direct(DO),
  object_prepositional_where(OQ),
  {removing_extraneous_tree_nodes_pr_abc('vp',VPQ,VTC,DO,OQ)}.

% A verb phrase (question where) can consists of a compound intransitive verb,
% intransitive objects and a special prepositional object phrase..
% examples:
% sina unpa jan pi pona lukin, lon seme?
verb_phrase_where(VPQ) -->
  verb_intransitive_compound(VIC),
  objects_intrans(IO),
  object_prepositional_where(OQ),
  {removing_extraneous_tree_nodes_pr_abc('vp',VPQ,VIC,IO,OQ)}.

% A verb phrase (question where) can consists of a object (be),
% and a special prepositional object phrase..
% In toki pona is no verb "to be".
% examples:
% ona li pona, lon seme?
% ona li ' pona, lon seme?
verb_phrase_where(VPQ) -->
  verb_be(Be),
  object_be(OB),
  object_prepositional_where(OQ),
  {removing_extraneous_tree_nodes_pr_abc('vp',VPQ,Be,OB,OQ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question where from)

% A verb phrase (question where from) can consists of the transitive verb "kama"
% and a special prepositional object.
% examples:
% ona li kama, tan seme?
% ona li kama, tan ma tomo seme?
verb_phrase_wherefrom(VPQ) -->
  verb_transitive(VT,kama),
  object_prepositional_wherefrom(OQ),
  {removing_extraneous_tree_nodes_pr_ab('vp',VPQ,VT,OQ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question where to)

% A verb phrase (question where to) can consists of normal verb phrases
% and a special prepositional object.
% examples:
% ona li tawa e kiwen, tawa seme?
% ona li tawa e kiwen, tawa anpa seme?
% ona li tawa e kiwen, kepeken ona, tawa anpa seme?
verb_phrase_whereto(VPQ) -->
  verb_phrases(VP),
  object_prepositional_whereto(OQ),
  {removing_extraneous_tree_nodes_ab(VPQ,VP,OQ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question whom)

% A verb phrase (question whom) can consists of normal verb phrases and
% a special object.
% examples:
% ona li pakala e ijo e jan seme?
% ona li pakala e ijo e jan pona seme?
% ona li pakala e ijo e meli seme?
% ona li pakala e ijo e meli pona seme?
% ona li pakala e ijo e mije seme?
% ona li pakala e ijo e mije pona seme?
verb_phrase_whom(VPQ) -->
  verb_phrases(VP),
  object_direct_whom(OQ),
  {removing_extraneous_tree_nodes_ab(VPQ,VP,OQ)}.

% A verb phrase (question whom) can consists of intransitive verb and
% a special object.
% ona li lukin jan pona seme?
% sina unpa jan seme?
verb_phrase_whom(VPQ) -->
  verb_intransitive_compound(VIC),
  object_intrans_whom(OQ),
  {removing_extraneous_tree_nodes_pr_ab('vp',VPQ,VIC,OQ)}.

% A verb phrase (question whom) can consists of normal verb phrases, an optional comma,
% a preposition, a noun_person  ("jan", "meli" or "mije"),
% optional adjectives and the question word "seme".
% examples:
% ona li pakala e tomo, tan jan seme?
% ona li pakala e tomo, tan jan sona seme?
% ona li pakala e tomo, tan meli seme?
% ona li pakala e tomo, tan meli pona seme?
% ona li pakala e tomo, tan mije seme?
% ona li pakala e tomo, tan mije pona seme?
verb_phrase_whom(VPQ) -->
  verb_phrases(VP),
  object_prepositional_whom(OQ),
  {removing_extraneous_tree_nodes_ab(VPQ,VP,OQ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question which)

% A verb phrase (question which) can consists of a (in)transitive verb
% and a special object.
% examples:
% ona li pakala e ijo seme?
% ona li pakala e ijo pona seme?

verb_phrase_which(VPQ) -->
  verb_transitive_compound(VTC),
  object_direct_which(OQ),
  {removing_extraneous_tree_nodes_pr_ab('vp',VPQ,VTC,OQ)}.

% sina kepeken ilo seme?
% sina kepeken ilo pona seme?
verb_phrase_which(VPQ) -->
  verb_intransitive_compound(VIC),
  object_intrans_which(OQ),
  {removing_extraneous_tree_nodes_pr_ab('vp',VPQ,VIC,OQ)}.

% sina pakala, tawa ijo seme?
% sina pakala, tawa ijo pona seme?
verb_phrase_which(VPQ) -->
  verb_transitive_compound(VTC),
  object_prepositional_which(OQ),
  {removing_extraneous_tree_nodes_pr_ab('vp',VPQ,VTC,OQ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question when)

% A verb phrase (question when) can consists of verb phrases and a special prepositional object.
% examples:
% sina moku e moku, lon tenpo seme?
verb_phrase_when(VPQ) -->
  verb_phrases(VP),
  object_prepositional_when(OQ),
  {removing_extraneous_tree_nodes_ab(VPQ,VP,OQ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question why)

% A verb phrase (question why) can consists of verb phrases and a special prepositional object.
% examples:
% sina pali e tomo, tan seme?
verb_phrase_why(VPQ) -->
  verb_phrases(VP),
  object_prepositional_why(OQ),
  {removing_extraneous_tree_nodes_ab(VPQ,VP,OQ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question how)

% A verb phrase (question how) can consists of  verb phrases a special prepositional object.
% examples:
% sina pali e ni, kepeken nasin seme?
verb_phrase_how(VPQ) -->
  verb_phrases(VP),
  object_prepositional_how(OQ),
  {removing_extraneous_tree_nodes_ab(VPQ,VP,OQ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% verb phrases (question how many)

% A verb phrase (question how many) can consists of verb phrases and a special direct object.
% examples:
% akesi li pakala e tomo e soweli pi mute seme?
% sina wile jo e mani seme, tan jan ni?                                         ??
verb_phrase_how_many(VPQ) -->
  verb_phrases(VP),
  object_direct_how_many(OQ),
  objects_prepositional(PO),
  {removing_extraneous_tree_nodes_abc(VPQ,VP,PO,OQ)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% la phrases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% several "la" phrases

% "la" phrases can consists of nothing.
la_phrases(epsilon) --> [].

% "la" phrases can consists of a "la" phrase.
% examples:
% ken la mi moku e moku.
la_phrases(LPS) -->
  la_phrase(LP),
  {removing_extraneous_tree_nodes_a(LPS,LP)}.

% "la" phrases can consists of two "la" phrase.
% examples:
% tenpo kama la ken la mi moku e moku.
la_phrases(LPS) -->
  la_phrase(LP1),
  la_phrase(LP2),
  {removing_extraneous_tree_nodes_ab(LPS,LP1,LP2)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% "la" phrase

% A "la" phrase can consists of subjects, an optional separator "," (useless),
% the separator "la" and an optional separator "," (also useless).
% examples:
% tenpo kama la ken la mi moku e moku.
% tenpo kama la, ken, la mi moku e moku.
% mi la mi moku e moku.
% ona en ni la ona li moku e moku.
la_phrase(LP) -->
  subjects_all(SUBA),
  comma_optional,
  separator(Sep,la),
  comma_optional,
  {removing_extraneous_tree_nodes_pr_ab('lp',LP,SUBA,Sep)}.

% A "la" phrase can consists of a simple sentence (noun phrase + verb phrases),
% an optional separator "," (useless),
% the separator "la" and an optional separator "," (also useless).
% examples:
% mi moku e moku li moku e telo la mi pilin pona.
% mi moku e moku li moku e telo, la, mi pilin pona.
la_phrase(LP) -->
  sentence_simple(SS),
  comma_optional,
  separator(Sep,la),
  comma_optional,
  {removing_extraneous_tree_nodes_pr_ab('lp',LP,SS,Sep)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% "la" phrase as the end of a sentence

% A "la" phrase at the end of a sentences can consists of the separator "la"
% with optional commas (useless) and a compound noun.
% examples:
% mi wile tawa la tenpo ni.
% o tawa la tenpo kama lili.
la_phrase_follow(epsilon) --> [].
la_phrase_follow(LPF) -->
  comma_optional,
  separator(Sep,la),
  comma_optional,
  subjects_all(SUBA),
  {removing_extraneous_tree_nodes_pr_ab('lp',LPF,Sep,SUBA)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% "la" phrase (question)

% A question as a "la" phrase.
% examples:
% seme la sina kama jo e mani?
la_phrase_question(LPQ) -->
  question(Q),
  comma_optional,
  separator(Sep,la),
  comma_optional,
  {removing_extraneous_tree_nodes_pr_ab('lp',LPQ,Q,Sep)}.

% A "la" phrase can be a when-question.
% examples:
% tenpo seme la sina moku e moku?
% tenpo pona seme la sina moku e moku?
% tenpo pona sina seme la sina moku e moku?
la_phrase_when(LPQ) -->
  noun(N,tenpo),
  adjectives(ADJS),
  question_word(QW,seme),
  separator(Sep,la),
  {removing_extraneous_tree_nodes_pr_abcd('lp',LPQ,N,ADJS,QW,Sep)}.

% A "la" phrase can be a why-question.
% examples:
% tan seme la soweli wawa pimeja li moku e ona?
la_phrase_why(LPQ) -->
  noun(N,tan),
  question_word(QW,seme),
  separator(Sep,la),
  {removing_extraneous_tree_nodes_pr_abc('lp',LPQ,N,QW,Sep)}.

% A "la" phrase can be a how-many-question.
% examples:
% tenpo pi mute seme la sina sike e suno?
la_phrase_how_many(LPQ) -->
  subjects_all(SU),
  separator(Sep1,pi),
  noun(N,mute),
  question_word(QW,seme),
  separator(Sep2,la),
  {removing_extraneous_tree_nodes_pr_abcde('lp',LPQ,SU,Sep1,N,QW,Sep2)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% vocativ phrases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A vocativ phrase consists of subjects, the separator "o" and the separator ",".
% examples:
% sina o, sina olin ala olin e mi?
% jan Lope o, sina olin ala olin e mi?
vocativ_phrase(VOP) -->
  subjects_all(SU),
  separator(S1,o),
  separator(S2,','),
  {removing_extraneous_tree_nodes_pr_abc('vocp',VOP,SU,S1,S2)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% interjection phrases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Interjection phrases can consists of interjection words, subjects, a noun or/and an adjectives.
% examples:
% sina o a!     (very emotional)
interjection_phrases(INP) -->
  subjects_all(SU),
  separator(Sep,o),
  interjection_word(IW,a),
  {removing_extraneous_tree_nodes_pr_abc('emotional',INP,SU,Sep,IW)}.

% examples:
% a a a!        (laughing)
interjection_phrases(INP) -->
  interjection_word(I1,a),
  interjection_word(I2,a),
  interjection_word(I3,a),
  {removing_extraneous_tree_nodes_pr_abc('laughing',INP,I1,I2,I3)}.

% examples:
% a!
% o!
% mu!
interjection_phrases(INP) -->
  interjection_word(IW,_),
  {removing_extraneous_tree_nodes_pr_a('expletive',INP,IW)}.

% examples:
% ala!          (no!)
interjection_phrases(INP) -->
  noun(N,ala),
  {removing_extraneous_tree_nodes_pr_a('expletive',INP,N)}.

% examples:
% ike!          (oh dear! woe! alas!)
interjection_phrases(INP) -->
  noun(N,ike),
  {removing_extraneous_tree_nodes_pr_a('expletive',INP,N)}.

% examples:
% jaki!         (ew! yuck!)
interjection_phrases(INP) -->
  noun(N,jaki),
  {removing_extraneous_tree_nodes_pr_a('expletive',INP,N)}.

% examples:
% kin!          (really!)
interjection_phrases(INP) -->
  adjectiv(N,kin),
  {removing_extraneous_tree_nodes_pr_a('expletive',INP,N)}.

% examples:
% pakala!       (damn! fuck!)
interjection_phrases(INP) -->
  noun(N,pakala),
  {removing_extraneous_tree_nodes_pr_a('expletive',INP,N)}.

% examples:
% pona!         (great! good! thanks! OK! cool! yay!)
interjection_phrases(INP) -->
  noun(N,pona),
  {removing_extraneous_tree_nodes_pr_a('expletive',INP,N)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% salutation phrases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Salutation phrases can consists of a special noun or pronoun, adjectives and optional verbs.
% Furthermore salutation phrases can consists an optional comma and a preposition.
% examples:
% toki!                                "Hello!"
salutation_phrase(SP) -->
  noun(N,toki),
  {removing_extraneous_tree_nodes_pr_a('salutp',SP,N)}.

% examples:
% pona!                                "Thank you!"
salutation_phrase(SP) -->
  noun(N,pona),
  {removing_extraneous_tree_nodes_pr_a('salutp',SP,N)}.

% examples:
% suno pona!                           "Good day!"
salutation_phrase(SP) -->
  noun(N,suno),
  adjectiv(ADJ,pona),
  {removing_extraneous_tree_nodes_pr_ab('salutp',SP,N,ADJ)}.

% examples:
% lape pona!                           "Sleep well!"
salutation_phrase(SP) -->
  noun(N,lape),
  adjectiv(ADJ,pona),
  {removing_extraneous_tree_nodes_pr_ab('salutp',SP,N,ADJ)}.

% examples:
% moku pona!                           "Enjoy your meal!"
salutation_phrase(SP) -->
  noun(N,moku),
  adjectiv(ADJ,pona),
  {removing_extraneous_tree_nodes_pr_ab('salutp',SP,N,ADJ)}.

% examples:
% tawa pona!                           "Good bye!"
salutation_phrase(SP) -->
  noun(N,tawa),
  adjectiv(ADJ,pona),
  {removing_extraneous_tree_nodes_pr_ab('salutp',SP,N,ADJ)}.

% examples:
% kama pona!                           "Welcome!"
salutation_phrase(SP) -->
  noun(N,kama),
  adjectiv(ADJ,pona),
  {removing_extraneous_tree_nodes_pr_ab('salutp',SP,N,ADJ)}.

% examples:
% musi pona!                           "Have fun!"
salutation_phrase(SP) -->
  noun(N,musi),
  adjectiv(ADJ,pona),
  {removing_extraneous_tree_nodes_pr_ab('salutp',SP,N,ADJ)}.

% examples:
% pali pona!                           "Good succeed!"
salutation_phrase(SP) -->
  noun(N,pali),
  adjectiv(ADJ,pona),
  {removing_extraneous_tree_nodes_pr_ab('salutp',SP,N,ADJ)}.

% examples:
% mi tawa!                             "Good bye!" (I go)
salutation_phrase(SP) -->
  pronoun(PN,mi),
  verb_intransitive(VI,tawa),
  {removing_extraneous_tree_nodes_pr_ab('salutp',SP,PN,VI)}.

% examples:
% mi mute tawa!                        "Good bye!" (we go)
salutation_phrase(SP) -->
  pronoun(PN,mi),
  adjectiv(ADJ,mute),
  verb_intransitive(VI,tawa),
  {removing_extraneous_tree_nodes_pr_abc('salutp',SP,PN,ADJ,VI)}.

% examples:
% pona tawa sina!                      "Peace be with you."
% pona, tawa sina!                     "Peace be with you."
salutation_phrase(SP) -->
  noun(N,pona),
  comma_optional,
  preposition(PRE,tawa),
  pronoun(PN,sina),
  {removing_extraneous_tree_nodes_pr_abc('salutp',SP,N,PRE,PN)}.

% examples:
% pona mute!                           "Very good!"
salutation_phrase(SP) -->
  noun(N,pona),
  adjectiv(ADJ,mute),
  {removing_extraneous_tree_nodes_pr_ab('salutp',SP,N,ADJ)}.

% examples:
% pona mute mute!                      "Very, very good!"
salutation_phrase(SP) -->
  noun(N,pona),
  adjectiv(ADJ1,mute),
  adjectiv(ADJ2,mute),
  {removing_extraneous_tree_nodes_pr_abc('salutp',SP,N,ADJ1,ADJ2)}.

% examples:
% pona mute mute mute!                  "Excellent!"
salutation_phrase(SP) -->
  noun(N,pona),
  adjectiv(ADJ1,mute),
  adjectiv(ADJ2,mute),
  adjectiv(ADJ3,mute),
  {removing_extraneous_tree_nodes_pr_abcd('salutp',SP,N,ADJ1,ADJ2,ADJ3)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% answer yes/no phrases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% answer yes

% A answer-yes-phrase consists of an auxiliary verb or/and a transitive verb.
% examples:
% moku.
answer_yes_phrase(AYP) -->
  verb_transitive(VT,_),
  {removing_extraneous_tree_nodes_pr_a('yes',AYP,VT)}.

% examples:
% wile moku.
answer_yes_phrase(AYP) -->
  verb_pre(VP,Vpre),
  verb_transitive(VT,V),   {V\=Vpre},
  {removing_extraneous_tree_nodes_pr_ab('yes',AYP,VP,VT)}.

% examples:
% wile.
answer_yes_phrase(AYP) -->
  verb_pre(VP,_),
  {removing_extraneous_tree_nodes_pr_a('yes',AYP,VP)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% answer no

% A answer-no-phrase consists of the noun "ala" or an auxiliary verb or/and a transitive verb with the adverb "ala".
% examples:
% ala.
answer_no_phrase(ANP) -->
  noun(N,ala),
  {removing_extraneous_tree_nodes_pr_a('no',ANP,N)}.

% examples:
% moku ala.
answer_no_phrase(ANP) -->
  verb_transitive(VT,_),
  adverb(ADV,ala),
  {removing_extraneous_tree_nodes_pr_ab('no',ANP,VT,ADV)}.

% examples:
% wile ala moku.
answer_no_phrase(ANP) -->
  verb_pre(VP,Vpre),
  adverb(ADV,ala),
  verb_transitive(VT,V), {V\=Vpre},
  {removing_extraneous_tree_nodes_pr_abc('no',ANP,VP,ADV,VT)}.

% examples:
% wile ala.
answer_no_phrase(ANP) -->
  verb_pre(VP,_),
  adverb(ADV,ala),
  {removing_extraneous_tree_nodes_pr_ab('no',ANP,VP,ADV)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% subject
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% subjects (all variants)

% subjects_all can consists of any possible subjects.
% examples:
% soweli pi mute seme li moku e telo?
% sina anu ona li moku e moku?
% jan Lisa anu jan Lope li moku e moku?
% soweli pi mute seme li moku e telo?
% sina anu ona li moku e moku?
% jan Lisa anu sina li moku e moku?
subjects_all(S) --> subject_no_li(S).
subjects_all(S) --> subject_with_li(S).
subjects_all(S) --> subjects(S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% several subjects

% Subjects can consist of a subject and up to four additional subjects.
% examples:
% ona en sina o a!
% sina en ona anu sina en mi li moku e moku?
% ona en sina en mi o a!
% soweli suwi en akesi suli en pipi ike en mi li moku e moku.
% soweli suwi en akesi suli en pipi ike en sina en mi li moku e moku.
subjects(SUBS) -->
  subject(SUB1),
  subject_add(SUB2),
  {removing_extraneous_tree_nodes_ab(SUBS,SUB1,SUB2)}.

subjects(SUBS) -->
  subject(SUB1),
  subject_add(SUB2),
  subject_add(SUB3),
  {removing_extraneous_tree_nodes_abc(SUBS,SUB1,SUB2,SUB3)}.

subjects(SUBS) -->
  subject(SUB1),
  subject_add(SUB2),
  subject_add(SUB3),
  subject_add(SUB4),
  {removing_extraneous_tree_nodes_abcd(SUBS,SUB1,SUB2,SUB3,SUB4)}.

subjects(SUBS) -->
  subject(SUB1),
  subject_add(SUB2),
  subject_add(SUB3),
  subject_add(SUB4),
  subject_add(SUB5),
  {removing_extraneous_tree_nodes_abcde(SUBS,SUB1,SUB2,SUB3,SUB4,SUB5)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% subject

% A subject can consists of a pronoun or an compound pronoun or an compound noun.
% examples:
% sina o a!
% ona pona o a!
% sina o, sina olin ala olin e mi?
% tenpo pi mute seme la sina sike e suno?
subject(SUB) -->
  pronoun_with_optional_adjectives(PNC),
  {removing_extraneous_tree_nodes_pr_a('sub',SUB,PNC)}.

subject(SUB) -->
  noun_compound(NC),
  {removing_extraneous_tree_nodes_pr_a('sub',SUB,NC)}.

% A subject_no_li can consists of the pronoun "mi" or "sina".
% examples:
% mi moku e moku!
% sina moku e moku.
subject_no_li(SUB) -->
  pronoun(PN,mi),
  {removing_extraneous_tree_nodes_pr_a('sub',SUB,PN)}.

subject_no_li(SUB) -->
  pronoun(PN,sina),
  {removing_extraneous_tree_nodes_pr_a('sub',SUB,PN)}.

% A subject_with_li can consists of the pronoun "ona" or the pronoun "ni" or an compound pronoun or an compound noun.
% examples:
% ona li moku e moku.
% ni li moku e moku.
% ona pona li moku e moku.
% sina pona li moku e moku.
% jan ike li moku e moku.
subject_with_li(SUB) -->
    pronoun(PN,ona),
    {removing_extraneous_tree_nodes_pr_a('sub',SUB,PN)}.

subject_with_li(SUB) -->
    pronoun(PN,ni),
    {removing_extraneous_tree_nodes_pr_a('sub',SUB,PN)}.

subject_with_li(SUB) -->
    pronoun_with_at_least_one_adjectives(PNC),
    {removing_extraneous_tree_nodes_pr_a('sub',SUB,PNC)}.

subject_with_li(SUB) -->
    noun_compound(NC),
    {removing_extraneous_tree_nodes_pr_a('sub',SUB,NC)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% additional subject

% A additional subject consists of the conjunction "en" and a subject.
% examples:
% ona en sina en mi li moku e moku.
% meli pona en mije en mi li moku e moku.
% akesi pi jan Ana, en jan Lope li moku e moku.
subject_add(SUBA) -->
  comma_optional,
  conjunction(Con,en),
  subject(SUB),
  {removing_extraneous_tree_nodes_pr_ab('sub',SUBA,Con,SUB)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% special subjects questions

% A subject (what) consist of the question word "seme".
% examples:
% seme li moku e moku?
subject_what(SUB) -->
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_a('sub',SUB,QW)}.

% A subject (who) consist of a noun (person), optional adjectives, the question word "seme" and optional noun_pi_phrases.
% examples:
% jan seme li moku e moku?
% jan pona seme li moku e moku?
% jan seme pi mama sina li moku e moku?
% jan pona seme pi mama sina li moku e moku?
% jan pona seme pi mama sina pi mama ona li moku e moku?
% meli seme li moku e moku?
% mije seme li moku e moku?
subject_who(SUB) -->
  noun(N,X), {X=jan;X=meli;X=mije},
  adjectives(A),
  question_word(QW,seme),
  noun_pi_phrases(NPG),
  {removing_extraneous_tree_nodes_pr_abcd('sub',SUB,N,A,QW,NPG)}.

% A subject (which) consist of a noun (no person), optional adjectives, the question word "seme" and optional noun_pi_phrases.
% examples:
% ijo jelo seme li pakala e ona?
subject_which(SUB) -->
  noun(N,X), {X\=jan,X\=meli,X\=mije},
  adjectives(A),
  question_word(QW,seme),
  noun_pi_phrases(NPG),
  {removing_extraneous_tree_nodes_pr_abcd('sub',SUB,N,A,QW,NPG)}.

% A subject (how many) consists of subjects, the separator "pi", the noun "mute" and the question word "seme".
% examples:
% soweli pi mute seme li moku e telo?
% ona en sina pi mute seme li moku e telo?
subject_how_many(SUB) -->
  subjects_all(SU),
  separator(Sep1,pi),
  noun(N,mute),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abcd('sub',SUB,SU,Sep1,N,QW)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% special subjects designate

% A subject (designate) consists of the noun "nimi", a optional compound pronoun or a compound noun.
% name
% examples:
% nimi mi li Lope.
subject_designate_person(SUB) -->
  noun(N,nimi),
  pronoun(PN,_),
  {removing_extraneous_tree_nodes_pr_ab('sub',SUB,N,PN)}.

% continent
% examples:
% nimi pi ma suli mi li Elopa.
subject_designate_continent(SUB) -->
  noun(N1,nimi),
  separator(Sep,pi),
  noun(N2,ma),
  adjectiv(ADJ,suli),
  pronoun(PN,_),
  {removing_extraneous_tree_nodes_pr_abcde('sub',SUB,N1,Sep,N2,ADJ,PN)}.

% country
% examples:
% nimi pi ma mi li Tosi.
subject_designate_country(SUB) -->
  noun(N1,nimi),
  separator(Sep,pi),
  noun(N2,ma),
  pronoun(PN,_),
  {removing_extraneous_tree_nodes_pr_abcd('sub',SUB,N1,Sep,N2,PN)}.

% city
% examples:
% nimi pi ma tomo mi li Pelin.
subject_designate_city(SUB) -->
  noun(N1,nimi),
  separator(Sep,pi),
  noun(N2,ma),
  adjectiv(ADJ,tomo),
  pronoun(PN,_),
  {removing_extraneous_tree_nodes_pr_abcde('sub',SUB,N1,Sep,N2,ADJ,PN)}.

% language
% examples:
% nimi pi toki mi li Tosi.
subject_designate_language(SUB) -->
  noun(N1,nimi),
  separator(Sep,pi),
  noun(N2,toki),
  pronoun(PN,_),
  {removing_extraneous_tree_nodes_pr_abcd('sub',SUB,N1,Sep,N2,PN)}.

% sign language
% examples:
% nimi pi toki luka mi li Tosi.
subject_designate_sign_language(SUB) -->
  noun(N1,nimi),
  separator(Sep,pi),
  noun(N2,toki),
  adjectiv(ADJ,luka),
  pronoun(PN,_),
  {removing_extraneous_tree_nodes_pr_abcde('sub',SUB,N1,Sep,N2,ADJ,PN)}.

% ideology, religion
% examples:
% nimi pi nasin sewi mi li Patapali.
% nimi pi nasin pona mi li Patapali.
subject_designate_ideology(SUB) -->
  noun(N1,nimi),
  separator(Sep,pi),
  noun(N2,nasin),
  adjectiv(ADJ,sewi),
  pronoun(PN,_),
  {removing_extraneous_tree_nodes_pr_abcde('sub',SUB,N1,Sep,N2,ADJ,PN)}.
subject_designate_ideology(SUB) -->
  noun(N1,nimi),
  separator(Sep,pi),
  noun(N2,nasin),
  adjectiv(ADJ,pona),
  pronoun(PN,_),
  {removing_extraneous_tree_nodes_pr_abcde('sub',SUB,N1,Sep,N2,ADJ,PN)}.

% community
% examples:
% nimi pi kulupu mi li Patapali.
subject_designate_community(SUB) -->
  noun(N1,nimi),
  separator(Sep,pi),
  noun(N2,kulupu),
  pronoun(PN,_),
  {removing_extraneous_tree_nodes_pr_abcd('sub',SUB,N1,Sep,N2,PN)}.

% movies
% examples:
% nimi pi sitelen tawa ni li X-Files.
subject_designate_movie(SUB) -->
  noun(N1,nimi),
  separator(Sep,pi),
  noun(N2,sitelen),
  adjectiv(ADJ,tawa),
  pronoun(PN,_),
  {removing_extraneous_tree_nodes_pr_abcde('sub',SUB,N1,Sep,N2,ADJ,PN)}.

% miscellaneous
% examples:
% nimi pi tomo tawa mi li Tapan.
% nimi pi tomo tawa pona mi li Tapan.
subject_designate_misc(SUB) -->
  noun(N1,nimi),
  separator(Sep,pi),
  noun(N2,X),
  adjectives(ADJ),
  pronoun(PN,_),
  {X\=jan,X\=meli,X\=mije,X\=ma,X\=toki,X\=nasin,X\=kulupu,X\=sitelen},
  {removing_extraneous_tree_nodes_pr_abcde('sub',SUB,N1,Sep,N2,ADJ,PN)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% objects
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% direct objects

% Up to four direct objects are possible.
% examples:
% mi moku e moku.
% mi moku e moku e telo.
% mi moku e moku e telo e kili.
% mi moku e moku e telo e kili e soweli.
objects_direct(epsilon) --> [].

objects_direct(OSD) -->
  object_direct(O1),
  {removing_extraneous_tree_nodes_a(OSD,O1)}.

objects_direct(OSD) -->
  object_direct(O1),
  object_direct(O2),
  {removing_extraneous_tree_nodes_ab(OSD,O1,O2)}.

objects_direct(OSD) -->
  object_direct(O1),
  object_direct(O2),
  object_direct(O3),
  {removing_extraneous_tree_nodes_abc(OSD,O1,O2,O3)}.

objects_direct(OSD) -->
  object_direct(O1),
  object_direct(O2),
  object_direct(O3),
  object_direct(O4),
  {removing_extraneous_tree_nodes_abcd(OSD,O1,O2,O3,O4)}.

% A direct object consists of the separator "e", a compound pronoun or noun and optional additional objects.
% examples:
% mi olin e sina.
% mi olin e sina pona.
% mi olin e sina pona e ona pona.
% mi olin e sina pona e ona pona e mi pona.
% mi olin e sina pona anu ona pona.
object_direct(OD) -->
  separator(Sep,e),
  pronoun_with_optional_adjectives(PNC),
  object_optional_add(OOA),
  {removing_extraneous_tree_nodes_pr_abc('obj_d',OD,Sep,PNC,OOA)}.

% examples:
% mi olin e meli pi pona lukin.
% mi olin e meli pi pona lukin e meli mi.
% mi olin e meli pi pona lukin anu meli mi.
object_direct(OD) -->
  separator(Sep,e),
  noun_compound(NC),
  object_optional_add(OOA),
  {removing_extraneous_tree_nodes_pr_abc('obj_d',OD,Sep,NC,OOA)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% intransitive objects

% One intransitive objects is possible.
% examples:
% mi lon tomo pi kule loje.
% mi lon tomo pi kule loje anu tomo pi kule jelo.
objects_intrans(epsilon) --> [].

objects_intrans(OSI) -->
  object_intrans(O1),
  {removing_extraneous_tree_nodes_a(OSI,O1)}.

% A intransitive object consists of a compound pronoun or noun and optional additional objects.
% examples:
% ona li tawa ala tawa ni?
% ona pona li tawa ala tawa ni?
% mi lon ona pona.
% sina lon ona pona anu tomo suli.
% mi lon tomo pi kule loje.
object_intrans(OI) -->
  pronoun_with_optional_adjectives(PNC),
  object_optional_add(OOA),
  {removing_extraneous_tree_nodes_pr_ab('obj_i',OI,PNC,OOA)}.

object_intrans(OI) -->
  noun_compound(NC),
  object_optional_add(OOA),
  {removing_extraneous_tree_nodes_pr_ab('obj_i',OI,NC,OOA)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% object after missing "be".

% In toki pona is no verb "to be".
% An object after a missing "be" can consists of at least one adjective and optional more adjectives.
% examples:
% sina jelo.
% sina jelo loje.
% ona li pona, tawa mi mute.
object_be(OB) -->
  adjectives_at_least_one(ADJ),
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,ADJ)}.


% An object after a missing "be" can consists of (compound) pronoun.
% examples:
% jan Lope li ona.
% jan Lope en jan Mewi li ona mute.
% ni li ona mute, tawa mi mute.
object_be(OB) -->
  pronoun_with_optional_adjectives(PNC),
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,PNC)}.

% An object after a missing "be" can consists of a compound noun.
% examples:
% ona li jan pi pona mute.
% ona li jan pi pona mute, tawa mi mute.
object_be(OB) -->
  noun_compound(NC),
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,NC)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% special forms of an object after missing "be".

% A special, designate object for a person consist of special adjective.
% examples:
% nimi mi li Mawija.
object_be_designate_person(OB) -->
  adjective_female_prominent_personage(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi mi li Mose.
object_be_designate_person(OB) -->
  adjective_male_prominent_personage(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi mi li Lisa.
object_be_designate_person(OB) -->
  adjective_female_name(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi mi li Lope.
object_be_designate_person(OB) -->
  adjective_male_name(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi mi li Devil.
object_be_designate_person(OB) -->
  adjective_person_name(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi mi li Lopen.
object_be_designate_person(OB) -->
  adjective_person_name_unknown(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% A special, designate object for a non person consist of special adjective.
% examples:
% nimi pi ma suli mi li Elopa.
object_be_designate_continent(OB) -->
  adjective_continent(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi pi ma mi li Tosi.
object_be_designate_country(OB) -->
  adjective_country(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi pi ma tomo mi li Pelin.
object_be_designate_city(OB) -->
  adjective_city(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi pi toki mi li Tosi.
object_be_designate_language(OB) -->
  adjective_language(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi pi toki luka mi li Tosi.
object_be_designate_sign_language(OB) -->
  adjective_sign_language(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi pi nasin sewi mi li Patapali.
object_be_designate_ideology(OB) -->
  adjective_ideology(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi pi kulupu mi li Neje.
object_be_designate_community(OB) -->
  adjective_community(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi pi sitelen tawa ni li X-Files.
object_be_designate_movie(OB) -->
  adjective_movie(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

% examples:
% nimi pi tomo tawa mi li Pata.
object_be_designate_misc(OB) -->
  adjective_unofficial_words_miscellaneous(A,_), !,
  {removing_extraneous_tree_nodes_pr_a('obj_be',OB,A)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% prepositional objects

% Up to four prepositional objects are possible.
% examples:
% mi pona e ni, kepeken ilo wawa, kepeken telo pona, kepeken ilo suno.
objects_prepositional(epsilon) --> [].

objects_prepositional(OSP) -->
  object_prepositional(O1),
  {removing_extraneous_tree_nodes_a(OSP,O1)}.

objects_prepositional(OSP) -->
  object_prepositional(O1),
  object_prepositional(O2),
  {removing_extraneous_tree_nodes_ab(OSP,O1,O2)}.

objects_prepositional(OSP) -->
  object_prepositional(O1),
  object_prepositional(O2),
  object_prepositional(O3),
  {removing_extraneous_tree_nodes_abc(OSP,O1,O2,O3)}.

objects_prepositional(OSP) -->
  object_prepositional(O1),
  object_prepositional(O2),
  object_prepositional(O3),
  object_prepositional(O4),
  {removing_extraneous_tree_nodes_abcd(OSP,O1,O2,O3,O4)}.

% A prepositional object can consists of optional comma, the preposition "lon",
% a optional spatial noun, a noun or pronoun and optional additional objects.
% examples:
% mi moku e moku, lon poka jan pona sina.
object_prepositional(OP) -->
  comma_optional,
  preposition(Pre,_),
  noun(N,X), {X=anpa;X=insa;X=monsi;X=noka;X=poka;X=sewi;X=sinpin },                   % spatial noun
  pronoun_with_optional_adjectives(PNC),
  object_optional_add(OOA),
  {removing_extraneous_tree_nodes_pr_abcd('obj_p',OP,Pre,N,PNC,OOA)}.

object_prepositional(OP) -->
  comma_optional,
  preposition(Pre,_),
  noun(N,X), {X=anpa;X=insa;X=monsi;X=noka;X=poka;X=sewi;X=sinpin },                   % spatial noun
  noun_compound(NC),
  object_optional_add(OOA),
  {removing_extraneous_tree_nodes_pr_abcd('obj_p',OP,Pre,N,NC,OOA)}.

% A prepositional object can consists of optional comma, a preposition, a (compound) pronoun or noun and optional additional objects.
% examples:
% ni li pona, tawa mi.
% ni li pona, tawa mi pona.
% mi pona, tawa sina.
% mi alasa e soweli, kepeken ona suli.
% mi alasa, poka jan pona mi.
% mi alasa e soweli, kepeken ilo palisa, lon poka jan pona mi.
object_prepositional(OP) -->
  comma_optional,
  preposition(Pre,_),
  pronoun_with_optional_adjectives(PNC),
  object_optional_add(OOA),
  {removing_extraneous_tree_nodes_pr_abc('obj_p',OP,Pre,PNC,OOA)}.

object_prepositional(OP) -->
  comma_optional,
  preposition(Pre,_),
  noun_compound(NC),
  object_optional_add(OOA),
  {removing_extraneous_tree_nodes_pr_abc('obj_p',OP,Pre,NC,OOA)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% additional objects

% A additional object consists of the conjunction "anu" and a (compound) pronoun or (compound) noun.
% examples:
% mi kute e ona anu sina.
% mi kute e ona pona anu sina pona.
% mi kute e mije anu meli.
% ona li esun e moku anu telo nasa.
object_optional_add(epsilon) --> [].

object_optional_add(OA) -->
  conjunction(Con,anu),
  pronoun_with_optional_adjectives(PNC),
  {removing_extraneous_tree_nodes_pr_ab('obj_a',OA,Con,PNC)}.

object_optional_add(OA) -->
  conjunction(Con,anu),
  noun_compound(NC),
  {removing_extraneous_tree_nodes_pr_ab('obj_a',OA,Con,NC)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% question objects

% An object for a question (what direct object) consist of the separator "e" and the question word "seme".
% examples:
% sina kipisi e seme?
% sina kipisi e seme, kepeken ilo?
object_direct_what(OQ) -->
  separator(Sep,e),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_ab('obj_d',OQ,Sep,QW)}.

% An object for a question (what indirect object) consist of the question word "seme".
% examples:
% sina ken mute seme?
% sina ken mute seme, kepeken ni?
object_indirect_what(OQ) -->
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_a('obj_i',OQ,QW)}.

% An object for question (what prepositional object) consists of
% an optional comma, a preposition and the question word "seme".
% The preposition "lon" is for where-questions. "tan" is for why- and wherefrom-questions.
% examples:
% sina namako lili, poka seme?
% sina namako lili e moku mute, poka seme?
object_prepositional_what(OQ) -->
  comma_optional,
  preposition(Prep,P), {P\=lon,P\=tan,P\=tawa},
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_ab('obj_p',OQ,Prep,QW)}.

% A object for question (what is object) consists of the question word "seme".
% In toki pona is no verb "to be".
% examples:
% sina ' seme?
% sina ' seme, kepeken ni?
object_be_what_is(OQ) -->
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_a('obj_be',OQ,QW)}.

% A verb phrase (question what is object) consists of a compound noun and the question word "seme".
% In toki pona is no verb "to be".
% examples:
% ona li jan pi pana sona seme?
object_be_what_is_adjective(OQ) -->
  noun_compound(NC),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_ab('obj_be',OQ,NC,QW)}.

% A object for a question (where) can consists of an optional comma,
% the preposition "lon" and the question word "seme".
% examples:
% ona li pona, lon seme?
object_prepositional_where(OQ) -->
  comma_optional,
  preposition(Prep,lon),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_ab('obj_p',OQ,Prep,QW)}.

% A object for a question (where) can consists of an optional comma,
% the preposition "lon", a spatial and the question word "seme".
% examples:
% ona li lukin e ma, lon poka seme?
object_prepositional_where(OQ) -->
  comma_optional,
  preposition(Prep,lon),
  noun(N,X), {X=anpa;X=insa;X=monsi;X=noka;X=poka;X=sewi;X=sinpin },      % spatial nouns
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abc('obj_p',OQ,Prep,N,QW)}.

% A object for a question (where from) can consists of an optional comma,
% the preposition "tan" and the question word "seme".
% examples:
% ona li kama, tan seme?
object_prepositional_wherefrom(OQ) -->
  comma_optional,
  preposition(Prep,tan),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_ab('obj_p',OQ,Prep,QW)}.

% A object for a question (where from) can consists of an optional comma,
% the preposition "tan", a compound noun and the question word "seme".
% examples:
% ona li kama, tan ma tomo seme?
% ona li kama, tan ma pi mama mi seme?
object_prepositional_wherefrom(OQ) -->
  comma_optional,
  preposition(Prep,tan),
  noun_compound(NC),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abc('obj_p',OQ,Prep,NC,QW)}.

% A object for a question (where to) can consists of an optional comma,
% the preposition "tawa" and the question word "seme".
% examples:
% ona li tawa e kiwen, tawa seme?
object_prepositional_whereto(OQ) -->
  comma_optional,
  preposition(Prep,tawa),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_ab('obj_p',OQ,Prep,QW)}.

% A object for a question (where to) can consists of an optional comma,
% the preposition "tawa", a spatial noun and the question word "seme".
% examples:
% ona li tawa e kiwen, tawa anpa seme?
% ona li tawa e kiwen, kepeken ona, tawa anpa seme?
object_prepositional_whereto(OQ) -->
  comma_optional,
  preposition(Prep,tawa),
  noun(N,X), {X=anpa;X=insa;X=monsi;X=noka;X=poka;X=sewi;X=sinpin },                   % spatial noun
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abc('obj_p',OQ,Prep,N,QW)}.

% A direct object for a question (whom) can consists of the separator "e",
% a noun_person  ("jan", "meli" or "mije"), optional adjectives and the question word "seme".
% examples:
% ona li pakala e ijo e jan seme?
% ona li pakala e ijo e jan pona seme?
% ona li pakala e ijo e meli seme?
% ona li pakala e ijo e meli pona seme?
% ona li pakala e ijo e mije seme?
% ona li pakala e ijo e mije pona seme?
object_direct_whom(OQ) -->
  separator(Sep,e),
  noun(N,X), {X=jan;X=meli;X=mije},
  adjectives(ADJ),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abcd('obj_d',OQ,Sep,N,ADJ,QW)}.

% A indirect object for a question (whom) can consists of
% a noun_person  ("jan", "meli" or "mije"), optional adjectives and the question word "seme".
% examples:
% sina unpa jan seme?
object_intrans_whom(OQ) -->
  noun(N,X), {X=jan;X=meli;X=mije},
  adjectives(ADJ),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abc('obj_i',OQ,N,ADJ,QW)}.


% A prepositional object for a question (where to) can consists of a an optional comma, apreposition,
% a noun_person  ("jan", "meli" or "mije"), optional adjectives and the question word "seme".
% examples:
% ona li pakala e tomo, tan jan seme?
% ona li pakala e tomo, tan jan sona seme?
% ona li pakala e tomo, tan meli seme?
% ona li pakala e tomo, tan meli pona seme?
% ona li pakala e tomo, tan mije seme?
% ona li pakala e tomo, tan mije pona seme?
object_prepositional_whom(OQ) -->
  comma_optional,
  preposition(Pre,_),
  noun(N,X), {X=jan;X=meli;X=mije},
  adjectives(ADJ),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abcd('obj_p',OQ,Pre,N,ADJ,QW)}.

% A direct object for a question (which) can consists of the separator "e",
% a noun (except jan, meli, mije, tan tenpo), optional adjectives and the question word "seme".
% examples:
% ona li pakala e ijo seme?
% ona li pakala e ijo pona seme?
object_direct_which(OQ) -->
  separator(Sep,e),
  noun(No,N), {N\=jan,N\=meli,N\=mije,N\=tan,N\=tenpo},
  adjectives(ADJ),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abcd('obj_d',OQ,Sep,No,ADJ,QW)}.

% A indirect object for a question (which) can consists of
% a noun (except jan, meli, mije, tan tenpo), optional adjectives and the question word "seme".
% examples:
% sina kepeken ilo seme?
% sina kepeken ilo pona seme?
object_intrans_which(OQ) -->
  noun(No,N), {N\=jan,N\=meli,N\=mije,N\=tan,N\=tenpo},
  adjectives(ADJ),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abc('obj_i',OQ,No,ADJ,QW)}.

% A prepositional object for a question (which) can consists of an optional comma,
% a preposition, a noun (except jan, meli, mije, tan tenpo), optional adjectives and the question word "seme".
% examples:
% sina pakala, tawa ijo seme?
% sina pakala, tawa ijo pona seme?
object_prepositional_which(OQ) -->
  comma_optional,
  preposition(Pre,P), {P\=lon,P\=tan},
  noun(No,N), {N\=jan,N\=meli,N\=mije,N\=tan,N\=tenpo},
  adjectives(ADJ),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abcd('obj_p',OQ,Pre,No,ADJ,QW)}.

% A prepositional object for a question (when) can consists of an optional comma,
% the preposition "lon", a noun (except jan, meli, mije, tan tenpo), optional adjectives and the question word "seme".
% examples:
% sina moku e moku, lon tenpo seme?
% sina moku e moku, lon tenpo pona seme?
object_prepositional_when(OQ) -->
  comma_optional,
  preposition(Pre,lon),
  noun(N,tenpo),
  adjectives(ADJ),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abcd('obj_p',OQ,Pre,N,ADJ,QW)}.

% A prepositional object for a question (why) can consists of an optional comma,
% the preposition "tan" and the question word "seme".
% examples:
% sina pali e tomo, tan seme?
% ona li pakala e ijo tan, tan seme?
object_prepositional_why(OQ) -->
  comma_optional,
  preposition(Pre,tan),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_ab('obj_p',OQ,Pre,QW)}.

% A prepositional object for a question (how) can consists of an optional comma,
% the preposition "kepeken", the noun "nasin" and the question word "seme".
% examples:
% sina pali e ni, kepeken nasin seme?
% sina pali e ni, kepeken nasin ike seme?
object_prepositional_how(OQ) -->
  comma_optional,
  preposition(Pre,kepeken),
  noun(N,nasin),
  adjectives(ADJ),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abcd('obj_p',OQ,Pre,N,ADJ,QW)}.

% A direct object for a question (how many) can consists of the separator "e",
% a compound noun, the separator "pi", the noun "mute" and the question word "seme".
% examples:
% akesi li pakala e tomo e soweli pi mute seme?
% sina wile jo e mani seme?
% sina wile jo e mani pi mute seme, tan jan ni?
object_direct_how_many(OQ) -->
  separator(Sep1,e),
  noun_compound(NC),
  separator(Sep2,pi),
  noun(N,mute),
  question_word(QW,seme),
  {removing_extraneous_tree_nodes_pr_abcde('obj_d',OQ,Sep1,NC,Sep2,N,QW)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% conjunctions
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A optional conjunction can consist of a conjunction and an optional comma.
% The comma will be ignored because it is useless.
% examples:
% taso mi moku e moku.
% taso, mi moku e moku.
conjunction_optional(epsilon) --> [].

conjunction_optional(C) -->
  conjunction(C,_),
  comma_optional.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% interjection words
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (Optional) interjection words can be "a" or/and "o".
% examples:
% en moku a
% anu mi moku e moku a!
% o moku e telo a!
% en o moku e telo a.
% en seme a?
interjection_optional(epsilon) --> [].

interjection_optional(IJO) -->
  interjection_word(IW,a),
  {removing_extraneous_tree_nodes_a(IJO,IW)}.

interjection_optional(IJO) -->
  interjection_word(IW,o),
  {removing_extraneous_tree_nodes_a(IJO,IW)}.

interjection_optional(IJO) -->
  interjection_word(IW1,o),
  interjection_word(IW2,a),
  {removing_extraneous_tree_nodes_ab(IJO,IW1,IW2)}.

% examples:
% mi moku e moku a.
% anu mi moku e moku a.
interjections(IJS) -->
  interjection_word(IW,a),
  {removing_extraneous_tree_nodes_a(IJS,IW)}.

interjections(IJS) -->
  interjection_word(IW,o),
  {removing_extraneous_tree_nodes_a(IJS,IW)}.

interjections(IJS) -->
  interjection_word(IW1,o),
  interjection_word(IW2,a),
  {removing_extraneous_tree_nodes_ab(IJS,IW1,IW2)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% miscellaneous:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Optional comma
%
% An optional comma will be ignored.
comma_optional --> [].
comma_optional --> separator(_,',').


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% verbs
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% transitive verbs

% An transitive compound verb can be build of an optional auxiliary verb, optional adverbs., a transitive verb and optional adverbs.
% examples:
% mi moku e moku.
% mi wile moku e moku.
% mi wile kin moku e moku.
% mi wile moku kin e moku.
verb_transitive_compound(VC) -->
  verb_transitive(VT,_),
  adverbs(ADV2),
  {removing_extraneous_tree_nodes_ab(VC,VT,ADV2)}.

verb_transitive_compound(VC) -->
  verb_pre(VP,_),
  adverbs(ADV1),
  verb_transitive(VT,_),
  adverbs(ADV2),
  {removing_extraneous_tree_nodes_abcd(VC,VP,ADV1,VT,ADV2)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% intransitive verbs

% An intransitive compound verb can be build of an optional auxiliary verb, optional adverbs., a transitive verb and optional adverbs.
% examples:
% ona li kepeken.
% ona li wile kepeken.
% ona li wile mute kepeken.
% ona li wile mute kepeken mute.
verb_intransitive_compound(VC) -->
  verb_intransitive(VI,_),
  adverbs(ADV2),
  {removing_extraneous_tree_nodes_ab(VC,VI,ADV2)}.

verb_intransitive_compound(VC) -->
  verb_pre(VP,_),
  adverbs(ADV1),
  verb_intransitive(VI,_),
  adverbs(ADV2),
  {removing_extraneous_tree_nodes_abcd(VC,VP,ADV1,VI,ADV2)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% pronouns
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% pronoun with optional adjectives

% A compound pronoun consists of a pronoun and optional adjectives.
% examples:
% ona pona
% ona pona kin
pronoun_with_optional_adjectives(PNC) -->
  pronoun(PN,_),
  adjectives(ADJ),
  {removing_extraneous_tree_nodes_ab(PNC,PN,ADJ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% pronoun with at least one adjective

% A compound pronoun after "pi" consists of a pronoun, at least one adjective.
% examples:
% tomo pi ona kin
pronoun_with_at_least_one_adjectives(PNC) -->
  pronoun(PN,_),
  adjectives_at_least_one(ADJ),
  {removing_extraneous_tree_nodes_ab(PNC,PN,ADJ)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% An optional pronoun

% An optional pronoun can consists of an optional pronoun. ;-)
pronoun_optional(epsilon) --> [].
pronoun_optional(PNO) -->
  pronoun(PN,_),
  {removing_extraneous_tree_nodes_a(PNO,PN)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% compound nouns
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A compound noun can be build with a noun, optional adjectives and optional noun phrases with "pi".
% examples:
% jan li moku e moku.
% jan pi jan suli li moku e moku pona.
% jan pona pi jan suli li moku e moku.
noun_compound(NC) -->
  noun_with_optional_adjectives(NA),
  noun_pi_phrases(NPG),
  {removing_extraneous_tree_nodes_ab(NC,NA,NPG)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% noun pi phrases

% A compound noun can have up to three pi-phrases.
% examples:
% kulupu pi kalama musi pi ma Inli li kalama e kalama musi.
% kulupu pi kalama musi pi ma Inli pi meli pona li kalama e kalama musi.
noun_pi_phrases(epsilon) --> [].

noun_pi_phrases(NPGs) -->
  noun_pi_phrase(NPG1),
  {removing_extraneous_tree_nodes_a(NPGs,NPG1)}.

noun_pi_phrases(NPGs) -->
  noun_pi_phrase(NPG1),
  noun_pi_phrase(NPG2),
  {removing_extraneous_tree_nodes_ab(NPGs,NPG1,NPG2)}.

noun_pi_phrases(NPGs) -->
  noun_pi_phrase(NPG1),
  noun_pi_phrase(NPG2),
  noun_pi_phrase(NPG3),
  {removing_extraneous_tree_nodes_abc(NPGs,NPG1,NPG2,NPG3)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% noun pi phrase

% A noun pi phrase starts with the separator "pi".
% After "pi" have to be at least two words.
% The first has to be a noun or a pronoun.
% Mostly after the first word have to be one ore more adjectives.
% examples:
% meli pi pona lukin li moku e moku pi pona moku ni.
% jan pi ona pona li moku e moku.

noun_pi_phrase(NPG) -->
  separator(Sep,pi),
  noun_with_at_least_one_adjectives(NWA),
  {removing_extraneous_tree_nodes_ab(NPG,Sep,NWA)}.

noun_pi_phrase(NPG) -->
  separator(Sep,pi),
  pronoun_with_at_least_one_adjectives(PNC),
  {removing_extraneous_tree_nodes_ab(NPG,Sep,PNC)}.

% In a "pi" phrase it is possible to combine a (pro)noun with an "en" noun phrase.
% After the (pro)noun can be optional adjectives.
% examples:
% jan pona pi meli en mije li moku e moku.
% jan pona pi meli en ona li moku e moku.
% jan pona pi meli en ona pona li moku e moku.
% jan pona pi ona en mije li moku e moku.
% jan pona pi ona en mije suwi li moku e moku.
% jan pona pi ona en sina li moku e moku.
% jan pona pi ona pona, en sina li moku e moku.
% jan pona pi ona pona en sina li moku e moku.
% jan pona pi ona en sina pona li moku e moku.
noun_pi_phrase(NPG) -->
  separator(Sep,pi),
  noun_with_optional_adjectives(NC),
  noun_en_phrase(NSG),
  {removing_extraneous_tree_nodes_abc(NPG,Sep,NC,NSG)}.

noun_pi_phrase(NPG) -->
  separator(Sep,pi),
  pronoun_with_optional_adjectives(PNC),
  noun_en_phrase(NSG),
  {removing_extraneous_tree_nodes_abc(NPG,Sep,PNC,NSG)}.

% In a "pi" phrase it is possible to combine a (pro)nouns with two "en" noun phrases.
% After the (pro)noun can be optional adjectives.
% examples:
% jan pona pi ona en meli en mije li moku e moku.
% jan pona pi ona en meli, en mije li moku e moku.                 % different meaning
% jan pona pi meli pona en jan pona ni en ona li moku e moku.
noun_pi_phrase(NPG) -->
  separator(Sep,pi),
  noun_with_optional_adjectives(NC),
  noun_en_phrase(NSG1),
  noun_en_phrase(NSG2),
  {removing_extraneous_tree_nodes_abcd(NPG,Sep,NC,NSG1,NSG2)}.

noun_pi_phrase(NPG) -->
  separator(Sep,pi),
  pronoun_with_optional_adjectives(PNC),
  noun_en_phrase(NSG1),
  noun_en_phrase(NSG2),
  {removing_extraneous_tree_nodes_abcd(NPG,Sep,PNC,NSG1,NSG2)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% "en" noun phrase

% An "en" noun phrase consist of the conjuncion "en", a (pro)noun and optional adjectives.
% examples:
% tomo tawa pi ona en sina en ni ike li utala e ilo ni.
% tomo tawa pi ona en sina en ni li utala e ilo ni.
% tomo tawa pi jan pona mi en ona li utala e ilo ni.
% tomo tawa pi jan Lope en ona li utala e ilo ni.
noun_en_phrase(NSG) -->
  conjunction(Con,en),
  noun_with_optional_adjectives(NA),
  {removing_extraneous_tree_nodes_ab(NSG,Con,NA)}.

noun_en_phrase(NSG) -->
  conjunction(Con,en),
  pronoun_with_optional_adjectives(PNC),
  {removing_extraneous_tree_nodes_ab(NSG,Con,PNC)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% noun with adjectives
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% noun with optional adjectives

% After a noun can follow optional adjectives.
% Unofficial words are adjectives.
% The rule with unofficial words hase to be before the rule with "normal" adjectives.
% examples:
% jan Lope li moku e moku pona.
noun_with_optional_adjectives(NA) -->
  noun_with_optional_adjectives_and_an_unofficial_word(NA).

noun_with_optional_adjectives(NA) -->
  noun(N,_),
  adjectives(ADJ),
  {removing_extraneous_tree_nodes_ab(NA,N,ADJ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% noun with at least one adjective

% A noun after a "pi" need at least one adjcetive.
% examples:
% soweli pi jan Lope li moku e moku.
% soweli pi jan pona mi li moku e moku.
noun_with_at_least_one_adjectives(NA) -->
  noun_with_optional_adjectives_and_an_unofficial_word(NA).

noun_with_at_least_one_adjectives(NA) -->
  noun(N,_),
  adjectives_at_least_one(ADJ),
  {removing_extraneous_tree_nodes_ab(NA,N,ADJ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% special nouns with optional adjectives and an unofficial word

% A special compound noun can consist of a special noun, optional a special adjectiv,
% an inofficial word and optional some adjectives.
% examples:
% ma tomo suli ni pi ma suli Elopa li utala e kon.
% jan pi kulupu Neje, en jan pi ma suli Apika li pona e ilo nanpa.
% jan pi kulupu Neje, en jan pi ma suli Apika li pona e ilo nanpa.
% jan pi nasin sewi Patapali li musi e jan ni.
% meli pi jan Lope li pali e moku.
% akesi pi mije Mawen li utala e ijo ni.
% kepeken pi ilo MIRC li ' pona pi pilin pona, tawa ona.
% jan pi ma Sumi li moku e moku.
% jan pi ma Sumi lete ni li moku e moku.
% jan pi ma suli Elopa pona li moku e moku.
% jan pi ma tomo Pelin pona li moku e moku.
% kulupu pi kalama musi pi ma Inli li ' pona pi kalama musi.
% ma suli Elopa pi pona lukin li ' pona pi pali ni, tawa mi.
% kulupu pi ma Inli pi ma suli Elopa li moku e moku.
% toki Inli pi ma Inli li ' pona pi pona ni, tawa jan ali.
% nasin sewi Patapali pi monsuta waso li ' musi pi pilin mi.
% jan Lope pi ma suli Elopa li ' lon ma Tosi.
% kulupu Neje pi ilo nanpa li ' nasa pi ma ni.
% sitelen tawa X-Files li ' nasa pi nasa ni, tawa mi.
% ijo MIRC
% akesi pi jan Lope en jan Patala pona ni
noun_with_optional_adjectives_and_an_unofficial_word(NCG) -->
  noun(N,ma),
  adjective_country(ION,_), !,
  adjectives(ADJS),
  {removing_extraneous_tree_nodes_abc(NCG,N,ION,ADJS)}.
noun_with_optional_adjectives_and_an_unofficial_word(NCG) -->
  noun(N,ma),
  adjective_continent(ION,_), !,
  adjectives(ADJS),
  {removing_extraneous_tree_nodes_abc(NCG,N,ION,ADJS)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCG) -->
  noun(N,ma),
  adjectiv(ADJ,suli),
  adjective_continent(ION,_), !,
  adjectives(ADJS),
  {removing_extraneous_tree_nodes_abcd(NCG,N,ADJ,ION,ADJS)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCG) -->
  noun(N,ma),
  adjectiv(ADJ,tomo),
  adjective_city(ION,_), !,
  adjectives(ADJS),
  {removing_extraneous_tree_nodes_abcd(NCG,N,ADJ,ION,ADJS)}.

% examples:
% jan ni li toki e ni, kepeken toki Inli.
% jan ni li toki e ni, kepeken toki Inli pona.
% jan ni li toki e ni, kepeken toki luka Inli pona.
noun_with_optional_adjectives_and_an_unofficial_word(NCL) -->
  noun(N,toki),
  adjective_language(ION,_), !,
  adjectives(ADJS),
  {removing_extraneous_tree_nodes_abc(NCL,N,ION,ADJS)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCSL) -->
  noun(N,toki),
  adjectiv(ADJ,luka),
  adjective_sign_language(ION,_), !,
  adjectives(ADJS),
  {removing_extraneous_tree_nodes_abcd(NCSL,N,ADJ,ION,ADJS)}.

% examples:
% jan pi nasin sewi Patapali li moku e moku.
% jan pi nasin pona Patapali sewi li moku e moku.
noun_with_optional_adjectives_and_an_unofficial_word(NCI) -->
  noun(N,nasin),
  adjectiv(ADJ,sewi),
  adjective_ideology(ION,_), !,
  adjectives(ADJS),
  {removing_extraneous_tree_nodes_abcd(NCI,N,ADJ,ION,ADJS)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCI) -->
  noun(N,nasin),
  adjectiv(ADJ,pona),
  adjective_ideology(ION,_), !,
  adjectives(ADJS),
  {removing_extraneous_tree_nodes_abcd(NCI,N,ADJ,ION,ADJS)}.

% examples:
% jan pi kulupu Neje li pona e ilo.
noun_with_optional_adjectives_and_an_unofficial_word(NCC) -->
  noun(N,kulupu),
  adjective_community(ION,_), !,
  adjectives(ADJS),
  {removing_extraneous_tree_nodes_abc(NCC,N,ION,ADJS)}.

% examples:
% jan Mawija li moku e moku.
% jan pona Mawija ni li moku e moku.
% jan Santa li pana e pona.
% jan pona Santa ni li pana e pona.
% jan Lisa li moku e moku.
% jan pona Lisa ni li moku e moku.
% jan Nikita li toki e toki.
% jan pona Nikita suli ni li toki e toki.
% meli God li toki e toki.
% mije God li toki e toki.
% jan God li toki e toki.
% jan pona Mesiko ni li toki e toki.
% jan ike Devil wawa li ike e ni.
% jan Lalalalalala li toki e toki.
noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,jan),
  adjectives_pure_optional(ADJS1),
  adjective_female_prominent_personage(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,jan),
  adjectives_pure_optional(ADJS1),
  adjective_male_prominent_personage(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,jan),
  adjectives_pure_optional(ADJS1),
  adjective_female_name(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,jan),
  adjectives_pure_optional(ADJS1),
  adjective_male_name(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,jan),
  adjectives_pure_optional(ADJS1),
  adjective_resident(ION,_),  !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,jan),
  adjectives_pure_optional(ADJS1),
  adjective_person_name(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,meli),
  adjectives_pure_optional(ADJS1),
  adjective_person_name(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,mije),
  adjectives_pure_optional(ADJS1),
  adjective_person_name(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,jan),
  adjectives_pure_optional(ADJS1),
  adjective_person_name_unknown(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

% examples:
% meli Mawija li moku e moku.
% meli pona Mawija ni li moku e moku.
% meli Lisa li moku e moku.
% meli pona Lisa ni li moku e moku.
% meli pona Mesiko suli li toki e toki.
% meli Lalalalalala li toki e toki.
noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,meli),
  adjectives_pure_optional(ADJS1),
  adjective_female_prominent_personage(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,meli),
  adjectives_pure_optional(ADJS1),
  adjective_female_name(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,meli),
  adjectives_pure_optional(ADJS1),
  adjective_female_resident(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,meli),
  adjectives_pure_optional(ADJS1),
  adjective_female_name_unknown(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

% examples:
% mije Santa li pana e pona.
% mije pona Santa ni li pana e pona.
% mije Nikita li toki e toki.
% mije pona Nikita suli li toki e toki.
% mije pona Mesiko kin li toki e toki.
% mije Lalalalalala li toki e toki.
noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,mije),
  adjectives_pure_optional(ADJS1),
  adjective_male_prominent_personage(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,mije),
  adjectives_pure_optional(ADJS1),
  adjective_male_name(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,mije),
  adjectives_pure_optional(ADJS1),
  adjective_male_resident(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

noun_with_optional_adjectives_and_an_unofficial_word(NCP) -->
  noun(N,mije),
  adjectives_pure_optional(ADJS1),
  adjective_male_name_unknown(ION,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCP,N,ADJS1,ION,ADJS2)}.

% examples:
% sitelen tawa X-Files
% sitelen tawa X-Files ni kin
noun_with_optional_adjectives_and_an_unofficial_word(NCM) -->
  noun(N,sitelen),
  adjectiv(ADJ,tawa),
  adjective_movie(ION,_), !,
  adjectives(ADJS),
  {removing_extraneous_tree_nodes_abcd(NCM,N,ADJ,ION,ADJS)}.

% examples:
% sona Palala li pona e ilo.
% sona pona Palala suli kin li pana e ilo.
noun_with_optional_adjectives_and_an_unofficial_word(NCT) -->
  noun(N,X),   {X\=jan,X\=meli,X\=mije,X\=ma,X\=toki,X\=nasin,X\=kulupu,X\=sitelen},
  adjectives_pure_optional(ADJS1),
  adjective_unofficial_words_miscellaneous(IOW,_), !,
  adjectives(ADJS2),
  {removing_extraneous_tree_nodes_abcd(NCT,N,ADJS1,IOW,ADJS2)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% adverbs
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Adverbs are quite simple in Toki Pona.
% Optional up to 4 different adverbs are possible.
% examples:
% mi pali pona e ilo.
% mi pali pona mute e ilo.
% mi pona pona mute ala e ilo.
% mi pona pona musi sama mute e ilo.
adverbs(epsilon) --> [].

adverbs(ADVs) -->
  adverb(ADV,_),
  {removing_extraneous_tree_nodes_a(ADVs,ADV)}.

adverbs(ADVs) -->
  adverb(ADV1,A),
  adverb(ADV2,B),
  {A\=B},
  {removing_extraneous_tree_nodes_ab(ADVs,ADV1,ADV2)}.

adverbs(ADVs) -->
  adverb(ADV1,A),
  adverb(ADV2,B),
  adverb(ADV3,C),
  {A\=B,A\=C,B\=C},
  {removing_extraneous_tree_nodes_abc(ADVs,ADV1,ADV2,ADV3)}.

adverbs(ADVs) -->
  adverb(ADV1,A),
  adverb(ADV2,B),
  adverb(ADV3,C),
  adverb(ADV4,D),
  {A\=B,A\=C,A\=D,B\=C,B\=D,C\=D},
  {removing_extraneous_tree_nodes_abcd(ADVs,ADV1,ADV2,ADV3,ADV4)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% adjectives
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Adjectives in Toki Pona are much more complicated than adverbs.
% Adjectives can be optional.
adjectives(epsilon) --> [].

% Compund adjectives can be build of optional pure adjectives and an optional pronoun.
% examples:
% akesi kin li moku e moku.
% akesi mi li moku e moku.
% akesi suli mi li moku e moku.
% akesi suli ike li moku e moku.
% akesi suli ike mi li moku e moku.
% akesi suli jelo mi li moku e moku.
adjectives(ADJs) -->
  adjectives_pure_optional(ADJp),
  pronoun_optional(PNo),
  {removing_extraneous_tree_nodes_ab(ADJs,ADJp,PNo)}.

% Compund adjectives can be build of optional pure adjectives and a pronoun and a final adjective.
% examples:
% akesi mi kin li moku e moku.
% akesi suli mi kin li moku e moku.
adjectives(ADJs) -->
  adjectives_pure_optional(ADJp1),
  pronoun(PNo,_),
  adjective_final(ADJf),
  {removing_extraneous_tree_nodes_abc(ADJs,ADJp1,PNo,ADJf)}.

% Compund adjectives can be build of optional pure adjectives, an optional optional pronoun,
% numbers and an optional special final adjective.
% examples:
% akesi kin, tu kin li moku e moku.
% akesi mi, tu li moku e moku.
% akesi mi tu taso li moku e moku.
% akesi pona kin, tu kin li moku e moku.
% akesi pona, tu kin li moku e moku.
% akesi pona tu li moku e moku.
% akesi suli jelo mi, tu wan li moku e moku.
adjectives(ADJs) -->
  adjectives_pure_optional(ADJ),
  pronoun_optional(PNo),
  numbers(NUMo),
  adjective_final_optional(ADJf),
  {removing_extraneous_tree_nodes_abcd(ADJs,ADJ,PNo,NUMo,ADJf)}.

% Compund adjectives can be build of optional pure adjectives, numbers,
% an pronoun and an optional special final adjective.
% examples:
% akesi kin, tu mi kin li moku e moku.
% akesi pona kin, tu mi kin li moku e moku.
% akesi pona, tu mi kin li moku e moku.
% akesi pona tu mi li moku e moku.
% akesi suli jelo, tu wan mi kin li moku e moku.
% akesi suli jelo, tu wan mi li moku e moku.
adjectives(ADJs) -->
  adjectives_pure_optional(ADJ),
  numbers(NUMo),
  pronoun(PNo,_),
  adjective_final_optional(ADJf),
  {removing_extraneous_tree_nodes_abcd(ADJs,ADJ,NUMo,PNo,ADJf)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% pure adjectives

% Optional up to three pure, different adjectives are possible.
% examples:
% akesi suli li moku e moku.
% akesi suli ike li moku e moku.
% akesi suli jelo ike li moku e moku.
adjectives_pure_optional(epsilon) --> [].

adjectives_pure_optional(ADJPs) -->
  adjectiv(ADJ,_),
  {removing_extraneous_tree_nodes_a(ADJPs,ADJ)}.

adjectives_pure_optional(ADJPs) -->
  adjectiv(ADJ1,A),
  adjectiv(ADJ2,B),
  {A\=B},
  {removing_extraneous_tree_nodes_ab(ADJPs,ADJ1,ADJ2)}.

adjectives_pure_optional(ADJPs) -->
  adjectiv(ADJ1,A),
  adjectiv(ADJ2,B),
  adjectiv(ADJ3,C),
  {A\=B,A\=C,B\=C},
  {removing_extraneous_tree_nodes_abc(ADJPs,ADJ1,ADJ2,ADJ3)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% at least one adjective

% One required adjective can be an adjevtive or an numeral.
% examples:
% tomo tawa pi jan pona li tawa e mi.
% tomo tawa pi jan wan li tawa e mi.
adjectives_at_least_one(ADJPs) -->
  adjectives(ADJs),
  {ADJs\=""},
  {removing_extraneous_tree_nodes_a(ADJPs,ADJs)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% final adjectives after a pronoun or number

% An final adjective can be "taso" or "kin".
% examples:
% tomo tawa, wan kin li tawa e ni.
% tomo tawa, wan taso li tawa e ni.
adjective_final_optional(epsilon) --> [].

adjective_final_optional(ADJF) --> adjective_final(ADJF).

adjective_final(ADJF) -->
  adjectiv(ADJ,taso),
  {removing_extraneous_tree_nodes_a(ADJF,ADJ)}.

adjective_final(ADJF) -->
  adjectiv(ADJ,kin),
  {removing_extraneous_tree_nodes_a(ADJF,ADJ)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Special adjectives - unofficial words
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% First search the unofficial in a corresponding catalog.
% The "!" stop the search after find something in the catalog.
% If nothing was found in the catalog, only the spelling of the unofficial word will be checked (word_unofficial).
% examples:
% ma Kana
% ma Lapalapa
% ma suli Elopa
% ma tomo Pelin
% ma tomo Lapalapa
adjective_country(UW,X) -->
  country_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_country',UW,ADJ)}.

adjective_country(UW,X) -->
  word_unofficial(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_country',UW,ADJ)}.

adjective_continent(UW,X) -->
  continent_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_continent',UW,ADJ)}.

adjective_city(UW,X) -->
  city_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_city',UW,ADJ)}.

adjective_city(UW,X) -->
  word_unofficial(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_city',UW,ADJ)}.

% examples:
% toki Epelanto
% toki Lapalapa
% toki luka Inli
% toki luka Lapalapala
adjective_language(UW,X) -->
  language_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_language',UW,ADJ)}.

adjective_language(UW,X) -->
  word_unofficial(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_language',UW,ADJ)}.

adjective_sign_language(UW,X) -->
  language_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_sign_language',UW,ADJ)}.

adjective_sign_language(UW,X) -->
  word_unofficial(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_sign_language',UW,ADJ)}.

% examples:
% nasin sewi Patapali
% nasin sewi Lapalapala
adjective_ideology(UW,X) -->
  ideology_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_ideology',UW,ADJ)}.

adjective_ideology(UW,X) -->
  word_unofficial(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_ideology',UW,ADJ)}.

% examples:
% kulupu Neje
% kulupu Lapalapala
adjective_community(UW,X) -->
  community_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_community',UW,ADJ)}.

adjective_community(UW,X) -->
  word_unofficial(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_community',UW,ADJ)}.

% examples:
% meli Mawija
% mije Santa
% meli Susan
% jan Susan
% mije Pepe
% jan Pepe
% meli Mesiko
% mije Mesiko
% jan Mesiko
% meli Elopa
% mije Elopa
% jan Elopa
% meli Osaka
% mije Osaka
% jan Osaka
% meli Lapalapala
% mije Lapalapala
% jan Lapalapala
adjective_female_prominent_personage(UW,X) -->
  female_prominent_personage_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_famous_woman',UW,ADJ)}.

adjective_male_prominent_personage(UW,X) -->
  male_prominent_personage_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_famous_man',UW,ADJ)}.

adjective_female_name(UW,X) -->
  female_name_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_female_name',UW,ADJ)}.

adjective_male_name(UW,X) -->
  male_name_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_male_name',UW,ADJ)}.

adjective_female_resident(UW,X) -->
  country_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_female_resident',UW,ADJ)}.

adjective_female_resident(UW,X) -->
  continent_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_female_resident',UW,ADJ)}.

adjective_female_resident(UW,X) -->
  city_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_female_resident',UW,ADJ)}.

adjective_male_resident(UW,X) -->
  country_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_male_resident',UW,ADJ)}.

adjective_male_resident(UW,X) -->
  continent_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_male_resident',UW,ADJ)}.

adjective_male_resident(UW,X) -->
  city_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_male_resident',UW,ADJ)}.

adjective_resident(UW,X) -->
  country_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_resident',UW,ADJ)}.

adjective_resident(UW,X) -->
  continent_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_resident',UW,ADJ)}.

adjective_resident(UW,X) -->
  city_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_resident',UW,ADJ)}.

adjective_person_name(UW,X) -->
  person_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_person_name',UW,ADJ)}.

adjective_female_name_unknown(UW,X) -->
  word_unofficial(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_female_name',UW,ADJ)}.

adjective_male_name_unknown(UW,X) -->
  word_unofficial(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_male_name',UW,ADJ)}.

adjective_person_name_unknown(UW,X) -->
  word_unofficial(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_person_name',UW,ADJ)}.

% examples:
% sitelen tawa X-Files
% sitelen tawa Lapalapala
adjective_movie(UW,X) -->
  movies_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_movie',UW,ADJ)}.

adjective_movie(UW,X) -->
  word_unofficial(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_movie',UW,ADJ)}.

% examples:
% ijo MIRC
% ijo Lapalapala
adjective_unofficial_words_miscellaneous(UW,X) -->
  unofficial_words_miscellaneous_catalog(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_thing',UW,ADJ)}.

adjective_unofficial_words_miscellaneous(UW,X) -->
  word_unofficial(ADJ,X),  !,
  {removing_extraneous_tree_nodes_pr_a('unofficial_thing',UW,ADJ)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Special adjectives - check spelling of unkwown unofficial words

% This pure prolog rule make it possible to use DCG for spell check.
% Get the lenght of the unofficial word.
% An unofficial word can have 2 to 15 characters.
% atom_chars() convert an Atom (Word) in a list of character codes (CL).
% The cut operator (!) mean: Don't try more than one true solution.
word_unofficial(unknown(Word),Word,[Word|T],T) :-
     atom_length(Word,L),
     (L > 1, L =< 15),
     atom_chars(Word,CL),
     word_unofficial_list(CL,[]), !.

% An unofficial word can consist of a special first syllable and optional syllables.
% examples:
% jan Lo
% jan Lomonopo
word_unofficial_list    --> syllable_first, syllables.

syllables               --> [].
syllables               --> syllable, syllables.
% Each syllable consists of a consonant plus a vowel, plus an optional "n".
% examples:
% akesi Kondo
syllable                --> consonant_small(Cs),
                            vowel_small(Vs),
                            { not(invalid_letter_combination(Cs,Vs)) },
                            optional_n.
syllable_first          --> consonant_capital(Cs),
                            vowel_small(Vs),
                            { not(invalid_letter_combination(Cs,Vs)) },
                            optional_n.
% The first syllable of a word does not need to beginn with a consonant.
% examples:
% ilo Alikali
syllable_first          --> vowel_capital(_),  consonant_small(_).
syllable_first          --> vowel_capital(_),  consonant_small(_),  vowel_small(_), optional_n.
% examples:
% akesi Lolo
% akesi Lonlon
optional_n              --> [].
optional_n              --> consonant_small('n').
% The syllables "ti" and "tin" become "si" and "sin".
% The consonant "w" cannot appear before "o" or "u".
% The consonant "j" cannot appear before "i".
invalid_letter_combination('T','i').
invalid_letter_combination('t','i').
invalid_letter_combination('W','o').
invalid_letter_combination('w','o').
invalid_letter_combination('W','u').
invalid_letter_combination('w','u').
invalid_letter_combination('J','i').
invalid_letter_combination('j','i').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Possible letters for unofficial words.

% The most frequently used letter is on the first position.
consonant_capital(Consonant_capital) -->
  [Consonant_capital], { member(Consonant_capital, [ 'P', 'S', 'K', 'L', 'M', 'T', 'N', 'W', 'J' ])}.
consonant_small(Consonant_small)     -->
  [Consonant_small],   { member(Consonant_small,   [ 'p', 's', 'k', 'l', 'm', 't', 'n', 'w', 'j' ])}.
vowel_capital(Vowel_capital) -->
  [Vowel_capital],     { member(Vowel_capital,     [ 'A', 'E', 'I', 'U', 'O' ])}.
vowel_small(Vowel_small) -->
  [Vowel_small],       { member(Vowel_small,       [ 'a', 'e', 'i', 'u', 'o' ])}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Special adjectives - numbers
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% An unofficial Toki Pona rule: Numbers can start with an optional number sign '#'.
% examples:
% jan lili                    (little person, some persons)
% jan # lili                  (some persons)
number_sign_optional --> [].
number_sign_optional --> separator(_,'#').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Cardinal ans ordinal numbers.

% Cardinal numbers:  1,   2,   3, ...
% Optional can start and end cardinal numbers with commas.
% examples:
% jan, tu li moku e moku.
% jan nanpa, tu li moku e moku.
numbers(NUMC) -->
  comma_optional,
  number_sign_optional,
  number(NUMs),
  {removing_extraneous_tree_nodes_pr_a('card',NUMC,NUMs)}.

% Ordinal numbers: 1th, 2th, 3th, ...
% Optional can start and end ordinal numbers with commas.
% Ordinal numbers have "nanpa" before the numbers.
% examples:
% jan, nanpa tu wan li moku e moku.
% jan nanpa, nanpa tu tu
numbers(NUMO) -->
  comma_optional,
  number_sign_optional,
  adjectiv(ADJ,nanpa),
  number(NUMs),
  {removing_extraneous_tree_nodes_pr_ab('ord',NUMO,ADJ,NUMs)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% The different count systems of Toki Pona.

% Zero (0) is "ala".
% examples:
% jan, ala
% jan, nanpa ala
number(CS) -->
  numeral(NUM,ala),
  {removing_extraneous_tree_nodes_a(CS,NUM)}.

% The "standard" count system with "ala", "wan", "tu" and "luka".
% examples:
% jan, luka tu wan
% jan, nanpa luka tu wan
number(CS) -->
  count_system_1_2_5(NUM),
  {removing_extraneous_tree_nodes_a(CS,NUM)}.

% The old count system with "ala", "wan" and "tu".
% examples:
% jan, tu tu wan
% jan, nanpa tu tu wan
number(CS) -->
  count_system_1_2(NUM),
  {removing_extraneous_tree_nodes_a(CS,NUM)}.

% The count system of "pu" with "ala", "wan", "tu", "luka", "mute" and "ali".
% examples:
% jan, ale mute luka tu wan
% jan, nanpa ale mute luka tu wan
number(CS) -->
  count_system_pu(NUM),
  {removing_extraneous_tree_nodes_a(CS,NUM)}.

% The vague count system with "mute mute mute" and "lili lili lili".
% examples:
% jan, mute mute mute li moku e moku.
% jan, nanpa mute mute mute li moku e moku.
number(CS) -->
  count_system_vague(NUM),
  {removing_extraneous_tree_nodes_a(CS,NUM)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% The "standard" count system with "ala", "wan", "tu" and "luka".

% The "standard" count system starts with:
% 1: "wan"
% 2: "tu"
% 3: "tu wan"
% 4: "tu tu"
% 5: "luka"
% examples:
% jan, wan
% jan, tu
% jan, tu wan
% jan, tu tu
count_system_1_2_5(CS) -->
  numeral(NMR,wan),
  {removing_extraneous_tree_nodes_a(CS,NMR)}.

count_system_1_2_5(CS) -->
  numeral(NMR,tu),
  {removing_extraneous_tree_nodes_a(CS,NMR)}.

count_system_1_2_5(CS) -->
  numeral(NMR1,tu),
  numeral(NMR2,wan),
  {removing_extraneous_tree_nodes_ab(CS,NMR1,NMR2)}.

count_system_1_2_5(CS) -->
  numeral(NMR1,tu),
  numeral(NMR2,tu),
  {removing_extraneous_tree_nodes_ab(CS,NMR1,NMR2)}.

count_system_1_2_5(CS) -->
  numeral(NMR,luka),
  number_radix_5(RAD),
  number_digits_5(DIG),
  {removing_extraneous_tree_nodes_abc(CS,NMR,RAD,DIG)}.

% The base of this system (radix) is "luka" (5).
number_radix_5(epsilon) --> [].

number_radix_5(RADIX) -->
  numeral(NMR,luka),
  number_radix_5(RAD),
  {removing_extraneous_tree_nodes_ab(RADIX,NMR,RAD)}.

% The digits are
% + 1: "wan"
% + 2: "tu"
% + 3: "tu wan"
% + 4: "tu tu"
% examples:
% jan, luka
% jan, luka wan
% jan, luka tu
% jan, luka tu wan
% jan, luka tu tu
% jan, luka luka
% jan, luka luka wan
number_digits_5(epsilon) --> [].

number_digits_5(DIG) -->
  numeral(NMR,wan),
  {removing_extraneous_tree_nodes_a(DIG,NMR)}.

number_digits_5(DIG) -->
  numeral(NMR,tu),
  {removing_extraneous_tree_nodes_a(DIG,NMR)}.

number_digits_5(DIG) -->
  numeral(NMR1,tu),
  numeral(NMR2,wan),
  {removing_extraneous_tree_nodes_ab(DIG,NMR1,NMR2)}.

number_digits_5(DIG) -->
  numeral(NMR1,tu),
  numeral(NMR2,tu),
  {removing_extraneous_tree_nodes_ab(DIG,NMR1,NMR2)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% The old count system with "ala", "wan" and "tu".

% We need no definitions for the start of the old count system,
% because 1,2,3,4 are the same as in the other count systems.
% Instead of 5 ("luka") this system use "tu tu wan" for 5.
% "tu tu tu" is for 6.
% examples:
% jan, tu tu wan
% jan, tu tu tu
% jan, tu tu tu wan
count_system_1_2(CS) -->
  numeral(NMR1,tu),
  numeral(NMR2,tu),
  numeral(NMR3,wan),
  {removing_extraneous_tree_nodes_abc(CS,NMR1,NMR2,NMR3)}.

count_system_1_2(CS) -->
  numeral(NMR1,tu),
  numeral(NMR2,tu),
  numeral(NMR3,tu),
  number_radix_2(RAD),
  number_digits_2(DIG),
  {removing_extraneous_tree_nodes_abcde(CS,NMR1,NMR2,NMR3,RAD,DIG)}.

% The base of this system (radix) is "tu" (2).
number_radix_2(epsilon) --> [].

number_radix_2(RADIX) -->
  numeral(NMR,tu),
  number_radix_2(RAD),
  {removing_extraneous_tree_nodes_ab(RADIX,NMR,RAD)}.

% The digit is
% + 1: "wan"
number_digits_2(epsilon) --> [].

number_digits_2(DIG) -->
  numeral(NMR,wan),
  {removing_extraneous_tree_nodes_a(DIG,NMR)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% The count system of "pu" with "ala", "wan", "tu", "luka", "mute" and "ali".

% The count system of "pu" is an addition to the "standard" count system.
% It uses additionally "mute" (20) and "ale" (100).
% Oh yes, I know this definition is ugly inaccurate.
% examples:
% jan, mute
% jan, mute tu wan
% jan, mute mute luka tu wan
count_system_pu(CS) -->
  numeral(NMR,mute),
  {removing_extraneous_tree_nodes_a(CS,NMR)}.

count_system_pu(CS) -->
  numeral(NMR,mute),
  number_radix_20(RAD),
  count_system_1_2_5(CSS),
  {removing_extraneous_tree_nodes_abc(CS,NMR,RAD,CSS)}.

% examples:
% jan, ale
% jan, ale tu tu
% jan, ale luka tu
% jan, ale ale luka wan
% jan, ale mute
% jan, ale mute mute luka tu wan
% jan, ale ale mute mute luka tu wan
count_system_pu(CS) -->
  numeral(NMR,ale),
  {removing_extraneous_tree_nodes_a(CS,NMR)}.

count_system_pu(CS) -->
  numeral(NMR,ale),
  number_radix_20(RAD2),
  {removing_extraneous_tree_nodes_ab(CS,NMR,RAD2)}.

count_system_pu(CS) -->
  numeral(NMR,ale),
  number_radix_100(RAD1),
  number_radix_20(RAD2),
  count_system_1_2_5(CSS),
  {removing_extraneous_tree_nodes_abcd(CS,NMR,RAD1,RAD2,CSS)}.

% The second base of this system (radix) is "mute" (20).
number_radix_20(epsilon) --> [].

number_radix_20(RADIX) -->
  numeral(NMR,mute),
  number_radix_20(RAD),
  {removing_extraneous_tree_nodes_ab(RADIX,NMR,RAD)}.

% The third base of this system (radix) is "ale" (100).
number_radix_100(epsilon) --> [].

number_radix_100(RADIX) -->
  numeral(NMR,ale),
  number_radix_100(RAD),
  {removing_extraneous_tree_nodes_ab(RADIX,NMR,RAD)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% The vague count system with "mute mute mute" and "lili lili lili".

% The vague count system is not a real count system.
% It describe relative amounts: "many", "very much", "little", ...
% many: "mute"
% very much": "mute kin",
% very much": "mute mute"
% very, very much": "mute mute mute"
% little: "lili"
% very little: "lili kin"
% very little: "lili kin"
% very little: "lili lili"
% very, very little: "lili lili lili"
% some: "mute lili"
% some: "lili mute"
% examples:
% jan, mute lili
% jan, mute kin
% jan, lili kin
% jan, mute mute mute
% jan, lili lili lili
count_system_vague(CSV) -->
  adjectiv(ADJ,mute),
  {removing_extraneous_tree_nodes_a(CSV,ADJ)}.

count_system_vague(CSV) -->
  adjectiv(ADJ1,mute),
  adjectiv(ADJ2,kin),
  {removing_extraneous_tree_nodes_ab(CSV,ADJ1,ADJ2)}.

count_system_vague(CSV) -->
  adjectiv(ADJ1,mute),
  adjectiv(ADJ2,mute),
  {removing_extraneous_tree_nodes_ab(CSV,ADJ1,ADJ2)}.

count_system_vague(CSV) -->
  adjectiv(ADJ1,mute),
  adjectiv(ADJ2,mute),
  adjectiv(ADJ3,mute),
  {removing_extraneous_tree_nodes_abc(CSV,ADJ1,ADJ2,ADJ3)}.

count_system_vague(CSV) -->
  adjectiv(ADJ,lili),
  {removing_extraneous_tree_nodes_a(CSV,ADJ)}.

count_system_vague(CSV) -->
  adjectiv(ADJ1,lili),
  adjectiv(ADJ2,kin),
  {removing_extraneous_tree_nodes_ab(CSV,ADJ1,ADJ2)}.

count_system_vague(CSV) -->
  adjectiv(ADJ1,lili),
  adjectiv(ADJ2,lili),
  {removing_extraneous_tree_nodes_ab(CSV,ADJ1,ADJ2)}.

count_system_vague(CSV) -->
  adjectiv(ADJ1,lili),
  adjectiv(ADJ2,lili),
  adjectiv(ADJ3,lili),
  {removing_extraneous_tree_nodes_abc(CSV,ADJ1,ADJ2,ADJ3)}.

count_system_vague(CSV) -->
  adjectiv(ADJ1,mute),
  adjectiv(ADJ2,lili),
  {removing_extraneous_tree_nodes_ab(CSV,ADJ1,ADJ2)}.

count_system_vague(CSV) -->
  adjectiv(ADJ1,ili),
  adjectiv(ADJ2,mute),
  {removing_extraneous_tree_nodes_ab(CSV,ADJ1,ADJ2)}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Removing extraneous tree nodes (pure prolog rules)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Without prefix

% 1 parameter + result: r a - Not really necessary. It is for a consistent design.
removing_extraneous_tree_nodes_a(R,      A      )                                         :-  A\=epsilon,                                                              R=(A),           !.

% 2 parameters + result: r ab
removing_extraneous_tree_nodes_ab(R,     A,      B)                                       :-  A\=epsilon, B\=epsilon,                                                  R=(A,B),         !.
removing_extraneous_tree_nodes_ab(R,     A,      epsilon)                                 :-  A\=epsilon,                                                              R=A  ,           !.
removing_extraneous_tree_nodes_ab(R,     epsilon,B)                                       :-              B\=epsilon,                                                  R=  B,           !.

% 3 parameters + result: r abc
removing_extraneous_tree_nodes_abc(R,    A,      B,      C)                               :-  A\=epsilon, B\=epsilon,  C\=epsilon,                                     R=(A,B,C),       !.
removing_extraneous_tree_nodes_abc(R,    A,      B,      epsilon)                         :-  A\=epsilon, B\=epsilon,                                                  R=(A,B  ),       !.
removing_extraneous_tree_nodes_abc(R,    A,      epsilon,C)                               :-  A\=epsilon,              C\=epsilon,                                     R=(A,  C),       !.
removing_extraneous_tree_nodes_abc(R,    A,      epsilon,epsilon)                         :-  A\=epsilon,                                                              R=(A    ),       !.
removing_extraneous_tree_nodes_abc(R,    epsilon,B,      C)                               :-              B\=epsilon,  C\=epsilon,                                     R=(  B,C),       !.
removing_extraneous_tree_nodes_abc(R,    epsilon,B,      epsilon)                         :-              B\=epsilon,                                                  R=(  B  ),       !.
removing_extraneous_tree_nodes_abc(R,    epsilon,epsilon,C)                               :-                           C\=epsilon,                                     R=(    C),       !.

% 4 parameters + result: r abcd
removing_extraneous_tree_nodes_abcd(R,   A,      B,      C,      D)                       :-  A\=epsilon, B\=epsilon,  C\=epsilon, D\=epsilon,                         R=(A,B,C,D),     !.
removing_extraneous_tree_nodes_abcd(R,   A,      B,      C,      epsilon)                 :-  A\=epsilon, B\=epsilon,  C\=epsilon,                                     R=(A,B,C  ),     !.
removing_extraneous_tree_nodes_abcd(R,   A,      B,      epsilon,D)                       :-  A\=epsilon, B\=epsilon,              D\=epsilon,                         R=(A,B,  D),     !.
removing_extraneous_tree_nodes_abcd(R,   A,      B,      epsilon,epsilon)                 :-  A\=epsilon, B\=epsilon,                                                  R=(A,B    ),     !.
removing_extraneous_tree_nodes_abcd(R,   A,      epsilon,C,      D)                       :-  A\=epsilon,              C\=epsilon, D\=epsilon,                         R=(A,  C,D),     !.
removing_extraneous_tree_nodes_abcd(R,   A,      epsilon,C,      epsilon)                 :-  A\=epsilon,              C\=epsilon,                                     R=(A,  C  ),     !.
removing_extraneous_tree_nodes_abcd(R,   A,      epsilon,epsilon,D)                       :-  A\=epsilon,                          D\=epsilon,                         R=(A,    D),     !.
removing_extraneous_tree_nodes_abcd(R,   A,      epsilon,epsilon,epsilon)                 :-  A\=epsilon,                                                              R=(A      ),     !.
removing_extraneous_tree_nodes_abcd(R,   epsilon,B,      C,      D)                       :-              B\=epsilon,  C\=epsilon, D\=epsilon,                         R=(  B,C,D),     !.
removing_extraneous_tree_nodes_abcd(R,   epsilon,B,      C,      epsilon)                 :-              B\=epsilon,  C\=epsilon,                                     R=(  B,C  ),     !.
removing_extraneous_tree_nodes_abcd(R,   epsilon,B,      epsilon,D)                       :-              B\=epsilon,              D\=epsilon,                         R=(  B,  D),     !.
removing_extraneous_tree_nodes_abcd(R,   epsilon,B,      epsilon,epsilon)                 :-              B\=epsilon,                                                  R=(  B    ),     !.
removing_extraneous_tree_nodes_abcd(R,   epsilon,epsilon,C,      D)                       :-                           C\=epsilon, D\=epsilon,                         R=(    C,D),     !.
removing_extraneous_tree_nodes_abcd(R,   epsilon,epsilon,C,      epsilon)                 :-                           C\=epsilon,                                     R=(    C  ),     !.
removing_extraneous_tree_nodes_abcd(R,   epsilon,epsilon,epsilon,D)                       :-                                       D\=epsilon,                         R=(      D),     !.

% 5 parameters + result: r abcde
removing_extraneous_tree_nodes_abcde(R,  A,      B,      C,      D,      E)               :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon,             R=(A,B,C,D,E),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      B,      C,      D,      epsilon)         :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon,                         R=(A,B,C,D  ),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      B,      C,      epsilon,E)               :- A\=epsilon, B\=epsilon,  C\=epsilon,              E\=epsilon,             R=(A,B,C,  E),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      B,      C,      epsilon,epsilon)         :- A\=epsilon, B\=epsilon,  C\=epsilon,                                      R=(A,B,C    ),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      B,      epsilon,D,      E)               :- A\=epsilon, B\=epsilon,               D\=epsilon, E\=epsilon,             R=(A,B,  D,E),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      B,      epsilon,D,      epsilon)         :- A\=epsilon, B\=epsilon,               D\=epsilon,                         R=(A,B,  D  ),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      B,      epsilon,epsilon,E)               :- A\=epsilon, B\=epsilon,                           E\=epsilon,             R=(A,B,    E),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      B,      epsilon,epsilon,epsilon)         :- A\=epsilon, B\=epsilon,                                                   R=(A,B      ),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      epsilon,C,      D,      E)               :- A\=epsilon,              C\=epsilon,  D\=epsilon, E\=epsilon,             R=(A,  C,D,E),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      epsilon,C,      D,      epsilon)         :- A\=epsilon,              C\=epsilon,  D\=epsilon,                         R=(A,  C,D  ),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      epsilon,C,      epsilon,E)               :- A\=epsilon,              C\=epsilon,              E\=epsilon,             R=(A,  C,  E),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      epsilon,C,      epsilon,epsilon)         :- A\=epsilon,              C\=epsilon,                                      R=(A,  C    ),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      epsilon,epsilon,D,      E)               :- A\=epsilon,                           D\=epsilon, E\=epsilon,             R=(A,    D,E),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      epsilon,epsilon,D,      epsilon)         :- A\=epsilon,                           D\=epsilon,                         R=(A,    D  ),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      epsilon,epsilon,epsilon,E)               :- A\=epsilon,                                       E\=epsilon,             R=(A,      E),   !.
removing_extraneous_tree_nodes_abcde(R,  A,      epsilon,epsilon,epsilon,epsilon)         :- A\=epsilon,                                                               R=(A        ),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,B,      C,      D,      E)               :-             B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon,             R=(  B,C,D,E),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,B,      C,      D,      epsilon)         :-             B\=epsilon,  C\=epsilon,  D\=epsilon,                         R=(  B,C,D  ),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,B,      C,      epsilon,E)               :-             B\=epsilon,  C\=epsilon,              E\=epsilon,             R=(  B,C,  E),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,B,      C,      epsilon,epsilon)         :-             B\=epsilon,  C\=epsilon,                                      R=(  B,C    ),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,B,      epsilon,D,      E)               :-             B\=epsilon,               D\=epsilon, E\=epsilon,             R=(  B,  D,E),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,B,      epsilon,D,      epsilon)         :-             B\=epsilon,               D\=epsilon,                         R=(  B,  D  ),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,B,      epsilon,epsilon,E)               :-             B\=epsilon,                           E\=epsilon,             R=(  B,    E),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,B,      epsilon,epsilon,epsilon)         :-             B\=epsilon,                                                   R=(  B      ),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,epsilon,C,      D,      E)               :-                          C\=epsilon,  D\=epsilon, E\=epsilon,             R=(    C,D,E),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,epsilon,C,      D,      epsilon)         :-                          C\=epsilon,  D\=epsilon,                         R=(    C,D  ),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,epsilon,C,      epsilon,E)               :-                          C\=epsilon,              E\=epsilon,             R=(    C,  E),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,epsilon,C,      epsilon,epsilon)         :-                          C\=epsilon,                                      R=(    C    ),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,epsilon,epsilon,D,      E)               :-                                       D\=epsilon, E\=epsilon,             R=(      D,E),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,epsilon,epsilon,D,      epsilon)         :-                                       D\=epsilon,                         R=(      D  ),   !.
removing_extraneous_tree_nodes_abcde(R,  epsilon,epsilon,epsilon,epsilon,E)               :-                                                   E\=epsilon,             R=(        E),   !.

% 6 parameters + result: r abcdef
removing_extraneous_tree_nodes_abcdef(R, A,      B,      C,      D,      E,      F)       :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon, F\=epsilon, R=(A,B,C,D,E,F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      C,      D,      E,      epsilon) :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon,             R=(A,B,C,D,E  ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      C,      D,      epsilon,F)       :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon,             F\=epsilon, R=(A,B,C,D,  F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      C,      D,      epsilon,epsilon) :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon,                         R=(A,B,C,D    ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      C,      epsilon,E,      F)       :- A\=epsilon, B\=epsilon,  C\=epsilon,              E\=epsilon, F\=epsilon, R=(A,B,C,  E,F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      C,      epsilon,E,      epsilon) :- A\=epsilon, B\=epsilon,  C\=epsilon,              E\=epsilon,             R=(A,B,C,  E  ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      C,      epsilon,epsilon,F)       :- A\=epsilon, B\=epsilon,  C\=epsilon,                          F\=epsilon, R=(A,B,C,    F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      C,      epsilon,epsilon,epsilon) :- A\=epsilon, B\=epsilon,  C\=epsilon,                                      R=(A,B,C      ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      epsilon,D,      E,      F)       :- A\=epsilon, B\=epsilon,               D\=epsilon, E\=epsilon, F\=epsilon, R=(A,B,  D,E,F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      epsilon,D,      E,      epsilon) :- A\=epsilon, B\=epsilon,               D\=epsilon, E\=epsilon,             R=(A,B,  D,E  ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      epsilon,D,      epsilon,F)       :- A\=epsilon, B\=epsilon,               D\=epsilon,             F\=epsilon, R=(A,B,  D,  F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      epsilon,D,      epsilon,epsilon) :- A\=epsilon, B\=epsilon,               D\=epsilon,                         R=(A,B,  D    ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      epsilon,epsilon,E,      F)       :- A\=epsilon, B\=epsilon,                           E\=epsilon, F\=epsilon, R=(A,B,    E,F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      epsilon,epsilon,E,      epsilon) :- A\=epsilon, B\=epsilon,                           E\=epsilon,             R=(A,B,    E  ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      epsilon,epsilon,epsilon,F)       :- A\=epsilon, B\=epsilon,                                       F\=epsilon, R=(A,B,      F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      B,      epsilon,epsilon,epsilon,epsilon) :- A\=epsilon, B\=epsilon,                                                   R=(A,B        ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,C,      D,      E,      F)       :- A\=epsilon,              C\=epsilon,  D\=epsilon, E\=epsilon, F\=epsilon, R=(A,  C,D,E,F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,C,      D,      E,      epsilon) :- A\=epsilon,              C\=epsilon,  D\=epsilon, E\=epsilon,             R=(A,  C,D,E  ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,C,      D,      epsilon,F)       :- A\=epsilon,              C\=epsilon,  D\=epsilon,             F\=epsilon, R=(A,  C,D,  F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,C,      D,      epsilon,epsilon) :- A\=epsilon,              C\=epsilon,  D\=epsilon,                         R=(A,  C,D    ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,C,      epsilon,E,      F)       :- A\=epsilon,              C\=epsilon,              E\=epsilon, F\=epsilon, R=(A,  C,  E,F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,C,      epsilon,E,      epsilon) :- A\=epsilon,              C\=epsilon,              E\=epsilon,             R=(A,  C,  E  ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,C,      epsilon,epsilon,F)       :- A\=epsilon,              C\=epsilon,                          F\=epsilon, R=(A,  C,    F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,C,      epsilon,epsilon,epsilon) :- A\=epsilon,              C\=epsilon,                                      R=(A,  C      ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,epsilon,D,      E,      F)       :- A\=epsilon,                           D\=epsilon, E\=epsilon, F\=epsilon, R=(A,    D,E,F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,epsilon,D,      E,      epsilon) :- A\=epsilon,                           D\=epsilon, E\=epsilon,             R=(A,    D,E  ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,epsilon,D,      epsilon,F)       :- A\=epsilon,                           D\=epsilon,             F\=epsilon, R=(A,    D,  F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,epsilon,D,      epsilon,epsilon) :- A\=epsilon,                           D\=epsilon,                         R=(A,    D    ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,epsilon,epsilon,E,      F)       :- A\=epsilon,                                       E\=epsilon, F\=epsilon, R=(A,      E,F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,epsilon,epsilon,E,      epsilon) :- A\=epsilon,                                       E\=epsilon,             R=(A,      E  ), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,epsilon,epsilon,epsilon,F)       :- A\=epsilon,                                                   F\=epsilon, R=(A,        F), !.
removing_extraneous_tree_nodes_abcdef(R, A,      epsilon,epsilon,epsilon,epsilon,epsilon) :- A\=epsilon,                                                               R=(A          ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      C,      D,      E,      F)       :-             B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon, F\=epsilon, R=(  B,C,D,E,F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      C,      D,      E,      epsilon) :-             B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon,             R=(  B,C,D,E  ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      C,      D,      epsilon,F)       :-             B\=epsilon,  C\=epsilon,  D\=epsilon,             F\=epsilon, R=(  B,C,D,  F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      C,      D,      epsilon,epsilon) :-             B\=epsilon,  C\=epsilon,  D\=epsilon,                         R=(  B,C,D    ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      C,      epsilon,E,      F)       :-             B\=epsilon,  C\=epsilon,              E\=epsilon, F\=epsilon, R=(  B,C,  E,F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      C,      epsilon,E,      epsilon) :-             B\=epsilon,  C\=epsilon,              E\=epsilon,             R=(  B,C,  E  ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      C,      epsilon,epsilon,F)       :-             B\=epsilon,  C\=epsilon,                          F\=epsilon, R=(  B,C,    F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      C,      epsilon,epsilon,epsilon) :-             B\=epsilon,  C\=epsilon,                                      R=(  B,C      ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      epsilon,D,      E,      F)       :-             B\=epsilon,               D\=epsilon, E\=epsilon, F\=epsilon, R=(  B,  D,E,F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      epsilon,D,      E,      epsilon) :-             B\=epsilon,               D\=epsilon, E\=epsilon,             R=(  B,  D,E  ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      epsilon,D,      epsilon,F)       :-             B\=epsilon,               D\=epsilon,             F\=epsilon, R=(  B,  D,  F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      epsilon,D,      epsilon,epsilon) :-             B\=epsilon,               D\=epsilon,                         R=(  B,  D    ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      epsilon,epsilon,E,      F)       :-             B\=epsilon,                           E\=epsilon, F\=epsilon, R=(  B,    E,F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      epsilon,epsilon,E,      epsilon) :-             B\=epsilon,                           E\=epsilon,             R=(  B,    E  ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      epsilon,epsilon,epsilon,F)       :-             B\=epsilon,                                       F\=epsilon, R=(  B,      F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,B,      epsilon,epsilon,epsilon,epsilon) :-             B\=epsilon,                                                   R=(  B        ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,C,      D,      E,      F)       :-                          C\=epsilon,  D\=epsilon, E\=epsilon, F\=epsilon, R=(    C,D,E,F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,C,      D,      E,      epsilon) :-                          C\=epsilon,  D\=epsilon, E\=epsilon,             R=(    C,D,E  ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,C,      D,      epsilon,F)       :-                          C\=epsilon,  D\=epsilon,             F\=epsilon, R=(    C,D,  F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,C,      D,      epsilon,epsilon) :-                          C\=epsilon,  D\=epsilon,                         R=(    C,D    ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,C,      epsilon,E,      F)       :-                          C\=epsilon,              E\=epsilon, F\=epsilon, R=(    C,  E,F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,C,      epsilon,E,      epsilon) :-                          C\=epsilon,              E\=epsilon,             R=(    C,  E  ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,C,      epsilon,epsilon,F)       :-                          C\=epsilon,                          F\=epsilon, R=(    C,    F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,C,      epsilon,epsilon,epsilon) :-                          C\=epsilon,                                      R=(    C      ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,epsilon,D,      E,      F)       :-                                       D\=epsilon, E\=epsilon, F\=epsilon, R=(      D,E,F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,epsilon,D,      E,      epsilon) :-                                       D\=epsilon, E\=epsilon,             R=(      D,E  ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,epsilon,D,      epsilon,F)       :-                                       D\=epsilon,             F\=epsilon, R=(      D,  F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,epsilon,D,      epsilon,epsilon) :-                                       D\=epsilon,                         R=(      D    ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,epsilon,epsilon,E,      F)       :-                                                   E\=epsilon, F\=epsilon, R=(        E,F), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,epsilon,epsilon,E,      epsilon) :-                                                   E\=epsilon,             R=(        E  ), !.
removing_extraneous_tree_nodes_abcdef(R, epsilon,epsilon,epsilon,epsilon,epsilon,F)       :-                                                               F\=epsilon, R=(          F), !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% With prefix

% 1 parameter + prefix + result: pre r a - Not really necessary. It is for a consistent design.
removing_extraneous_tree_nodes_pr_a(Pre,R,      A      )                                         :-  A\=epsilon,                                                              R=..[Pre,A],           !.
% removing_extraneous_tree_nodes_pr_a(Pre,R,      epsilon)                                         :-                                                                           R=..[Pre,error],       !.


% 2 parameters + prefix + result: pre r ab
removing_extraneous_tree_nodes_pr_ab(Pre,R,     A,      B)                                       :-  A\=epsilon, B\=epsilon,                                                  R=..[Pre,A,B],         !.
removing_extraneous_tree_nodes_pr_ab(Pre,R,     A,      epsilon)                                 :-  A\=epsilon,                                                              R=..[Pre,A  ],         !.
removing_extraneous_tree_nodes_pr_ab(Pre,R,     epsilon,B)                                       :-              B\=epsilon,                                                  R=..[Pre,  B],         !.

% 3 parameters + prefix + result: pre r abc
removing_extraneous_tree_nodes_pr_abc(Pre,R,    A,      B,      C)                               :-  A\=epsilon, B\=epsilon,  C\=epsilon,                                     R=..[Pre,A,B,C],       !.
removing_extraneous_tree_nodes_pr_abc(Pre,R,    A,      B,      epsilon)                         :-  A\=epsilon, B\=epsilon,                                                  R=..[Pre,A,B  ],       !.
removing_extraneous_tree_nodes_pr_abc(Pre,R,    A,      epsilon,C)                               :-  A\=epsilon,              C\=epsilon,                                     R=..[Pre,A,  C],       !.
removing_extraneous_tree_nodes_pr_abc(Pre,R,    A,      epsilon,epsilon)                         :-  A\=epsilon,                                                              R=..[Pre,A    ],       !.
removing_extraneous_tree_nodes_pr_abc(Pre,R,    epsilon,B,      C)                               :-              B\=epsilon,  C\=epsilon,                                     R=..[Pre,  B,C],       !.
removing_extraneous_tree_nodes_pr_abc(Pre,R,    epsilon,B,      epsilon)                         :-              B\=epsilon,                                                  R=..[Pre,  B  ],       !.
removing_extraneous_tree_nodes_pr_abc(Pre,R,    epsilon,epsilon,C)                               :-                           C\=epsilon,                                     R=..[Pre,    C],       !.

% 4 parameters + prefix + result: pre r abcd
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   A,      B,      C,      D)                       :-  A\=epsilon, B\=epsilon,  C\=epsilon, D\=epsilon,                         R=..[Pre,A,B,C,D],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   A,      B,      C,      epsilon)                 :-  A\=epsilon, B\=epsilon,  C\=epsilon,                                     R=..[Pre,A,B,C  ],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   A,      B,      epsilon,D)                       :-  A\=epsilon, B\=epsilon,              D\=epsilon,                         R=..[Pre,A,B,  D],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   A,      B,      epsilon,epsilon)                 :-  A\=epsilon, B\=epsilon,                                                  R=..[Pre,A,B    ],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   A,      epsilon,C,      D)                       :-  A\=epsilon,              C\=epsilon, D\=epsilon,                         R=..[Pre,A,  C,D],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   A,      epsilon,C,      epsilon)                 :-  A\=epsilon,              C\=epsilon,                                     R=..[Pre,A,  C  ],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   A,      epsilon,epsilon,D)                       :-  A\=epsilon,                          D\=epsilon,                         R=..[Pre,A,    D],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   A,      epsilon,epsilon,epsilon)                 :-  A\=epsilon,                                                              R=..[Pre,A      ],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   epsilon,B,      C,      D)                       :-              B\=epsilon,  C\=epsilon, D\=epsilon,                         R=..[Pre,  B,C,D],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   epsilon,B,      C,      epsilon)                 :-              B\=epsilon,  C\=epsilon,                                     R=..[Pre,  B,C  ],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   epsilon,B,      epsilon,D)                       :-              B\=epsilon,              D\=epsilon,                         R=..[Pre,  B,  D],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   epsilon,B,      epsilon,epsilon)                 :-              B\=epsilon,                                                  R=..[Pre,  B    ],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   epsilon,epsilon,C,      D)                       :-                           C\=epsilon, D\=epsilon,                         R=..[Pre,    C,D],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   epsilon,epsilon,C,      epsilon)                 :-                           C\=epsilon,                                     R=..[Pre,    C  ],     !.
removing_extraneous_tree_nodes_pr_abcd(Pre,R,   epsilon,epsilon,epsilon,D)                       :-                                       D\=epsilon,                         R=..[Pre,      D],     !.

% 5 parameters + prefix + result: pre r abcde
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      B,      C,      D,      E)               :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon,             R=..[Pre,A,B,C,D,E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      B,      C,      D,      epsilon)         :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon,                         R=..[Pre,A,B,C,D  ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      B,      C,      epsilon,E)               :- A\=epsilon, B\=epsilon,  C\=epsilon,              E\=epsilon,             R=..[Pre,A,B,C,  E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      B,      C,      epsilon,epsilon)         :- A\=epsilon, B\=epsilon,  C\=epsilon,                                      R=..[Pre,A,B,C    ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      B,      epsilon,D,      E)               :- A\=epsilon, B\=epsilon,               D\=epsilon, E\=epsilon,             R=..[Pre,A,B,  D,E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      B,      epsilon,D,      epsilon)         :- A\=epsilon, B\=epsilon,               D\=epsilon,                         R=..[Pre,A,B,  D  ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      B,      epsilon,epsilon,E)               :- A\=epsilon, B\=epsilon,                           E\=epsilon,             R=..[Pre,A,B,    E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      B,      epsilon,epsilon,epsilon)         :- A\=epsilon, B\=epsilon,                                                   R=..[Pre,A,B      ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      epsilon,C,      D,      E)               :- A\=epsilon,              C\=epsilon,  D\=epsilon, E\=epsilon,             R=..[Pre,A,  C,D,E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      epsilon,C,      D,      epsilon)         :- A\=epsilon,              C\=epsilon,  D\=epsilon,                         R=..[Pre,A,  C,D  ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      epsilon,C,      epsilon,E)               :- A\=epsilon,              C\=epsilon,              E\=epsilon,             R=..[Pre,A,  C,  E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      epsilon,C,      epsilon,epsilon)         :- A\=epsilon,              C\=epsilon,                                      R=..[Pre,A,  C    ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      epsilon,epsilon,D,      E)               :- A\=epsilon,                           D\=epsilon, E\=epsilon,             R=..[Pre,A,    D,E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      epsilon,epsilon,D,      epsilon)         :- A\=epsilon,                           D\=epsilon,                         R=..[Pre,A,    D  ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      epsilon,epsilon,epsilon,E)               :- A\=epsilon,                                       E\=epsilon,             R=..[Pre,A,      E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  A,      epsilon,epsilon,epsilon,epsilon)         :- A\=epsilon,                                                               R=..[Pre,A        ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,B,      C,      D,      E)               :-             B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon,             R=..[Pre,  B,C,D,E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,B,      C,      D,      epsilon)         :-             B\=epsilon,  C\=epsilon,  D\=epsilon,                         R=..[Pre,  B,C,D  ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,B,      C,      epsilon,E)               :-             B\=epsilon,  C\=epsilon,              E\=epsilon,             R=..[Pre,  B,C,  E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,B,      C,      epsilon,epsilon)         :-             B\=epsilon,  C\=epsilon,                                      R=..[Pre,  B,C    ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,B,      epsilon,D,      E)               :-             B\=epsilon,               D\=epsilon, E\=epsilon,             R=..[Pre,  B,  D,E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,B,      epsilon,D,      epsilon)         :-             B\=epsilon,               D\=epsilon,                         R=..[Pre,  B,  D  ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,B,      epsilon,epsilon,E)               :-             B\=epsilon,                           E\=epsilon,             R=..[Pre,  B,    E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,B,      epsilon,epsilon,epsilon)         :-             B\=epsilon,                                                   R=..[Pre,  B      ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,epsilon,C,      D,      E)               :-                          C\=epsilon,  D\=epsilon, E\=epsilon,             R=..[Pre,    C,D,E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,epsilon,C,      D,      epsilon)         :-                          C\=epsilon,  D\=epsilon,                         R=..[Pre,    C,D  ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,epsilon,C,      epsilon,E)               :-                          C\=epsilon,              E\=epsilon,             R=..[Pre,    C,  E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,epsilon,C,      epsilon,epsilon)         :-                          C\=epsilon,                                      R=..[Pre,    C    ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,epsilon,epsilon,D,      E)               :-                                       D\=epsilon, E\=epsilon,             R=..[Pre,      D,E],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,epsilon,epsilon,D,      epsilon)         :-                                       D\=epsilon,                         R=..[Pre,      D  ],   !.
removing_extraneous_tree_nodes_pr_abcde(Pre,R,  epsilon,epsilon,epsilon,epsilon,E)               :-                                                   E\=epsilon,             R=..[Pre,        E],   !.

% 6 parameters + prefix + result: pre r abcdef
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      C,      D,      E,      F)       :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon, F\=epsilon, R=..[Pre,A,B,C,D,E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      C,      D,      E,      epsilon) :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon,             R=..[Pre,A,B,C,D,E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      C,      D,      epsilon,F)       :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon,             F\=epsilon, R=..[Pre,A,B,C,D,  F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      C,      D,      epsilon,epsilon) :- A\=epsilon, B\=epsilon,  C\=epsilon,  D\=epsilon,                         R=..[Pre,A,B,C,D    ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      C,      epsilon,E,      F)       :- A\=epsilon, B\=epsilon,  C\=epsilon,              E\=epsilon, F\=epsilon, R=..[Pre,A,B,C,  E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      C,      epsilon,E,      epsilon) :- A\=epsilon, B\=epsilon,  C\=epsilon,              E\=epsilon,             R=..[Pre,A,B,C,  E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      C,      epsilon,epsilon,F)       :- A\=epsilon, B\=epsilon,  C\=epsilon,                          F\=epsilon, R=..[Pre,A,B,C,    F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      C,      epsilon,epsilon,epsilon) :- A\=epsilon, B\=epsilon,  C\=epsilon,                                      R=..[Pre,A,B,C      ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      epsilon,D,      E,      F)       :- A\=epsilon, B\=epsilon,               D\=epsilon, E\=epsilon, F\=epsilon, R=..[Pre,A,B,  D,E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      epsilon,D,      E,      epsilon) :- A\=epsilon, B\=epsilon,               D\=epsilon, E\=epsilon,             R=..[Pre,A,B,  D,E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      epsilon,D,      epsilon,F)       :- A\=epsilon, B\=epsilon,               D\=epsilon,             F\=epsilon, R=..[Pre,A,B,  D,  F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      epsilon,D,      epsilon,epsilon) :- A\=epsilon, B\=epsilon,               D\=epsilon,                         R=..[Pre,A,B,  D    ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      epsilon,epsilon,E,      F)       :- A\=epsilon, B\=epsilon,                           E\=epsilon, F\=epsilon, R=..[Pre,A,B,    E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      epsilon,epsilon,E,      epsilon) :- A\=epsilon, B\=epsilon,                           E\=epsilon,             R=..[Pre,A,B,    E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      epsilon,epsilon,epsilon,F)       :- A\=epsilon, B\=epsilon,                                       F\=epsilon, R=..[Pre,A,B,      F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      B,      epsilon,epsilon,epsilon,epsilon) :- A\=epsilon, B\=epsilon,                                                   R=..[Pre,A,B        ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,C,      D,      E,      F)       :- A\=epsilon,              C\=epsilon,  D\=epsilon, E\=epsilon, F\=epsilon, R=..[Pre,A,  C,D,E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,C,      D,      E,      epsilon) :- A\=epsilon,              C\=epsilon,  D\=epsilon, E\=epsilon,             R=..[Pre,A,  C,D,E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,C,      D,      epsilon,F)       :- A\=epsilon,              C\=epsilon,  D\=epsilon,             F\=epsilon, R=..[Pre,A,  C,D,  F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,C,      D,      epsilon,epsilon) :- A\=epsilon,              C\=epsilon,  D\=epsilon,                         R=..[Pre,A,  C,D    ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,C,      epsilon,E,      F)       :- A\=epsilon,              C\=epsilon,              E\=epsilon, F\=epsilon, R=..[Pre,A,  C,  E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,C,      epsilon,E,      epsilon) :- A\=epsilon,              C\=epsilon,              E\=epsilon,             R=..[Pre,A,  C,  E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,C,      epsilon,epsilon,F)       :- A\=epsilon,              C\=epsilon,                          F\=epsilon, R=..[Pre,A,  C,    F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,C,      epsilon,epsilon,epsilon) :- A\=epsilon,              C\=epsilon,                                      R=..[Pre,A,  C      ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,epsilon,D,      E,      F)       :- A\=epsilon,                           D\=epsilon, E\=epsilon, F\=epsilon, R=..[Pre,A,    D,E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,epsilon,D,      E,      epsilon) :- A\=epsilon,                           D\=epsilon, E\=epsilon,             R=..[Pre,A,    D,E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,epsilon,D,      epsilon,F)       :- A\=epsilon,                           D\=epsilon,             F\=epsilon, R=..[Pre,A,    D,  F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,epsilon,D,      epsilon,epsilon) :- A\=epsilon,                           D\=epsilon,                         R=..[Pre,A,    D    ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,epsilon,epsilon,E,      F)       :- A\=epsilon,                                       E\=epsilon, F\=epsilon, R=..[Pre,A,      E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,epsilon,epsilon,E,      epsilon) :- A\=epsilon,                                       E\=epsilon,             R=..[Pre,A,      E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,epsilon,epsilon,epsilon,F)       :- A\=epsilon,                                                   F\=epsilon, R=..[Pre,A,        F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, A,      epsilon,epsilon,epsilon,epsilon,epsilon) :- A\=epsilon,                                                               R=..[Pre,A          ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      C,      D,      E,      F)       :-             B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon, F\=epsilon, R=..[Pre,  B,C,D,E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      C,      D,      E,      epsilon) :-             B\=epsilon,  C\=epsilon,  D\=epsilon, E\=epsilon,             R=..[Pre,  B,C,D,E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      C,      D,      epsilon,F)       :-             B\=epsilon,  C\=epsilon,  D\=epsilon,             F\=epsilon, R=..[Pre,  B,C,D,  F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      C,      D,      epsilon,epsilon) :-             B\=epsilon,  C\=epsilon,  D\=epsilon,                         R=..[Pre,  B,C,D    ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      C,      epsilon,E,      F)       :-             B\=epsilon,  C\=epsilon,              E\=epsilon, F\=epsilon, R=..[Pre,  B,C,  E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      C,      epsilon,E,      epsilon) :-             B\=epsilon,  C\=epsilon,              E\=epsilon,             R=..[Pre,  B,C,  E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      C,      epsilon,epsilon,F)       :-             B\=epsilon,  C\=epsilon,                          F\=epsilon, R=..[Pre,  B,C,    F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      C,      epsilon,epsilon,epsilon) :-             B\=epsilon,  C\=epsilon,                                      R=..[Pre,  B,C      ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      epsilon,D,      E,      F)       :-             B\=epsilon,               D\=epsilon, E\=epsilon, F\=epsilon, R=..[Pre,  B,  D,E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      epsilon,D,      E,      epsilon) :-             B\=epsilon,               D\=epsilon, E\=epsilon,             R=..[Pre,  B,  D,E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      epsilon,D,      epsilon,F)       :-             B\=epsilon,               D\=epsilon,             F\=epsilon, R=..[Pre,  B,  D,  F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      epsilon,D,      epsilon,epsilon) :-             B\=epsilon,               D\=epsilon,                         R=..[Pre,  B,  D    ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      epsilon,epsilon,E,      F)       :-             B\=epsilon,                           E\=epsilon, F\=epsilon, R=..[Pre,  B,    E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      epsilon,epsilon,E,      epsilon) :-             B\=epsilon,                           E\=epsilon,             R=..[Pre,  B,    E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      epsilon,epsilon,epsilon,F)       :-             B\=epsilon,                                       F\=epsilon, R=..[Pre,  B,      F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,B,      epsilon,epsilon,epsilon,epsilon) :-             B\=epsilon,                                                   R=..[Pre,  B        ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,C,      D,      E,      F)       :-                          C\=epsilon,  D\=epsilon, E\=epsilon, F\=epsilon, R=..[Pre,    C,D,E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,C,      D,      E,      epsilon) :-                          C\=epsilon,  D\=epsilon, E\=epsilon,             R=..[Pre,    C,D,E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,C,      D,      epsilon,F)       :-                          C\=epsilon,  D\=epsilon,             F\=epsilon, R=..[Pre,    C,D,  F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,C,      D,      epsilon,epsilon) :-                          C\=epsilon,  D\=epsilon,                         R=..[Pre,    C,D    ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,C,      epsilon,E,      F)       :-                          C\=epsilon,              E\=epsilon, F\=epsilon, R=..[Pre,    C,  E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,C,      epsilon,E,      epsilon) :-                          C\=epsilon,              E\=epsilon,             R=..[Pre,    C,  E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,C,      epsilon,epsilon,F)       :-                          C\=epsilon,                          F\=epsilon, R=..[Pre,    C,    F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,C,      epsilon,epsilon,epsilon) :-                          C\=epsilon,                                      R=..[Pre,    C      ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,epsilon,D,      E,      F)       :-                                       D\=epsilon, E\=epsilon, F\=epsilon, R=..[Pre,      D,E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,epsilon,D,      E,      epsilon) :-                                       D\=epsilon, E\=epsilon,             R=..[Pre,      D,E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,epsilon,D,      epsilon,F)       :-                                       D\=epsilon,             F\=epsilon, R=..[Pre,      D,  F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,epsilon,D,      epsilon,epsilon) :-                                       D\=epsilon,                         R=..[Pre,      D    ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,epsilon,epsilon,E,      F)       :-                                                   E\=epsilon, F\=epsilon, R=..[Pre,        E,F], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,epsilon,epsilon,E,      epsilon) :-                                                   E\=epsilon,             R=..[Pre,        E  ], !.
removing_extraneous_tree_nodes_pr_abcdef(Pre,R, epsilon,epsilon,epsilon,epsilon,epsilon,F)       :-                                                               F\=epsilon, R=..[Pre,          F], !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eof
