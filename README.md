# Toki Pona Parser
Toki Pona is a constructed, minimal language. This parser based on swi-prolog and definite clause grammars (dcg) and supports spelling, grammar check and ambiguity check of Toki Pona sentences.

## The Tool for Spelling, Grammar Check and Ambiguity Check of Toki Pona Sentences

First you have to install swi-prolog.

    Windows, Mac OS X: http://www.swi-prolog.org/download/stable  
    Ubuntu/Debian: sudo apt-get install swi-prolog  

Download and decompress these [scripts](https://github.com/jan-Lope/Toki_Pona-Parser). 

Alternatively you can get the scripts per git on the command line.  

    $ git clone https://github.com/jan-Lope/Toki_Pona-Parser.git  
    $ cd Toki_Pona-Parser  

Start swi-prolog in the directory where the scripts are. For example in Ubuntu you type swipl. You will see the Prolog prompt ?-

    $ swipl  
    ?-  

Now you can load the main script in the Prolog system.

    ?- ['Toki_Pona.pro'].  

Alternatively you start swi-prolog with the main script by one command.  

    $ swipl -s Toki_Pona.pro
    ?-

Under Linux you can start the script directly.

    ./Toki_Pona.pro  


Now you can check the grammar of a Toki Pona sentence with the command check_grammar(P). Don't forget the dot.
After the new prompt |: you can type the sentence. Use neither a space before the sentence nor doppel spaces.
In this example it is the sentence "mi moku.".
To get all possible variants you have to type semicolons until "false" or "no" is printed. "false" or "no" means no (more) variants can be found.

    ?- check_grammar(P).  
    |: mi moku.  
    P = s(dec(sim(np(sub(pronoun(mi))), vp(verb_tra(moku)))), sep('.')) ;  
    P = s(dec(sim(np(sub(pronoun(mi))), vp(be, obj_be(adjective(moku))))), sep('.')) ;  
    P = s(dec(sim(np(sub(pronoun(mi))), vp(be, obj_be(noun(moku))))), sep('.')) ;  
    false.  

You can see this sentence has three grammar variants and at least three meanings. Here can "moku" be a transitive verb (verb_tra), an adjective or a noun.

Let's check the next sentence. With the arrow key up you can get the last command. You don't need to type check_grammar(P). again.

    ?- check_grammar(P).  
    |: mi moku e moku.  
    P = s(dec(sim(np(sub(pronoun(mi))), vp(verb_tra(moku), obj_d(sep(e), noun(moku))))), sep('.')) ;  
    false.  

The grammar of the sentence "mi moku e moku." is unambiguously. The first "moku" can only be a transitive verb and the second "moku" is a noun.
This sentence (s) is a declarative (dec), simple (sim) sentence. It has a noun phrase (np) with a subject (sub) and a verb phrase (vp) with a direct object (obj_d). Here are the abbreviations:

    s            sentence  
  
    dec          declarative sentence  
    exc          exclamatory sentence  
    imp          imperative sentence  
    int          interrogative sentence  
    hdl          headline  
  
    sim          simple sentence  
    voc          vocativ sentence  
    inj          interjection sentence  
    salut        salutation sentence  
    com          command sentence  
    des          designate sentence  
  
    np           noun phrase  
    vp           verb phrase  
    lp           "la" phrase  
    vocp         vocativ phrase  
    salutp       salutation phrase  
  
    subj         subject  
  
    obj_d        object direct after transitive verb  
    obj_i        object after intransitive verb  
    obj_be       object after missing "be"  
    obj_p        object after prepositiion  
    obj_a        object after "anu"  
  
    unofficial_  unofficial word (adjective)  
  
    card         cardinal number  
    ord          ordinal number  
  
    conj         conjunction  
    sep          separator  
    verb_int     verb_intransitive  
    verb_tra     verb transitive  
    be           The missing "be", "am", "are", "is" in Toki Pona.  

Avoid ambiguous grammar as much as possible! Keep in mind if a sentence is clear for you it could be not clear for other people!

Next example: "ona li pakala e tomo tan jan seme?" This question has two grammar variants (whom, which_object).

    ?- check_grammar(P).  
    |: ona li pakala e tomo tan jan seme?  
    P = s(int(whom(np(sub(pronoun(ona)), sep(li)), (vp(verb_tra(pakala), obj_d(sep(e), noun(tomo))), obj_p(preposition(tan), noun(jan), question_word(seme))))), sep(?)) ;  
    P = s(int(which_object(np(sub(pronoun(ona)), sep(li)), vp(verb_tra(pakala), obj_d(sep(e), noun(tomo), (adjective(tan), adjective(jan)), question_word(seme))))), sep(?)) ;  
    false.  

A comma before "tan" make the sentence to a whom question only, because "tan" can only be a preposition here.

    ?- check_grammar(P).  
    |: ona li pakala e tomo, tan jan seme?  
    P = s(int(whom(np(sub(pronoun(ona)), sep(li)), (vp(verb_tra(pakala), obj_d(sep(e), noun(tomo))), obj_p(preposition(tan), noun(jan), question_word(seme))))), sep(?)) ;  
    false.  

In the next example a comma can make the grammar unambiguous. But maybe this is not what you mean.

    ?- check_grammar(P).  
    |: jan pona pi meli mi en mi li moku e moku.  
    P = s(dec(sim(np(sub(((noun(jan), adjective(pona)), sep(pi), (noun(...), pronoun(...)), conj(...), pronoun(...))), 
        sep(li)), vp(verb_tra(moku), obj_d(sep(e), noun(moku))))), sep('.')) ;  
    P = s(dec(sim(np((sub(((noun(jan), adjective(pona)), sep(pi), noun(...), pronoun(...))), sub(conj(en), sub(pronoun(mi)))), 
        sep(li)), vp(verb_tra(moku), obj_d(sep(e), noun(moku))))), sep('.')) ;  
    false.  
    ?- check_grammar(P).  
    |: jan pona pi meli mi, en mi li moku e moku.  
    P = s(dec(sim(np((sub(((noun(jan), adjective(pona)), sep(pi), noun(...), pronoun(...))), sub(conj(en), sub(pronoun(mi)))), 
        sep(li)), vp(verb_tra(moku), obj_d(sep(e), noun(moku))))), sep('.')) ;  
    false.  

If you would like to mark the missing "be" you can use an apostrophe for the grammar check. This is not an official Toki Pona rule, but it avoid ambiguous.

    ?- check_grammar(P).  
    |: ni li ' moku.  
    P = s(dec(sim(np(sub(pronoun(ni)), sep(li)), vp(be, obj_be(adjective(moku))))), sep('.')) ;  
    P = s(dec(sim(np(sub(pronoun(ni)), sep(li)), vp(be, obj_be(noun(moku))))), sep('.')) ;  
    false.  

To reduce the object variants to a noun you can use "pi".  

    ?- check_grammar(P).  
    |: ni li ' moku pi jan pona.  
    P = s(dec(sim(np(sub(pronoun(ni)), sep(li)), vp(be, obj_be((noun(moku), sep(pi), noun(jan), adjective(pona)))))), sep('.')) ;  
    false.  

To mark numbers you can use a comma or a "#" (unofficial).

    ?- check_grammar(P).  
    |:  jan lili li moku e moku.  
    P = s(dec(sim(np(sub((noun(jan), adjective(lili))), sep(li)), vp(verb_tra(moku), obj_d(sep(e), noun(moku))))), sep('.')) ;  
    P = s(dec(sim(np(sub((noun(jan), card(adjective(lili)))), sep(li)), vp(verb_tra(moku), obj_d(sep(e), noun(moku))))), sep('.')) ;  
    false.  
    ?- check_grammar(P).  
    |:  jan, lili li moku e moku.  
    P = s(dec(sim(np(sub((noun(jan), card(adjective(lili)))), sep(li)), vp(verb_tra(moku), obj_d(sep(e), noun(moku))))), sep('.')) ;  
    false.  
    ?- check_grammar(P).  
    |:  jan # lili li moku e moku.  
    P = s(dec(sim(np(sub((noun(jan), card(adjective(lili)))), sep(li)), vp(verb_tra(moku), obj_d(sep(e), noun(moku))))), sep('.')) ;  
    false.  

These scripts can help you to understand Toki Pona sentences. For example the sentence "ona li mama ala mama?" can not mean "Is she a mother?"

    ?- check_grammar(P).  
    |: ona li mama ala mama?  
    P = s(int(yes_no(np(sub(pronoun(ona)), sep(li)), vp(verb_tra(mama), adverb(ala), verb_tra(mama)))), sep(?)) ;  
    false.  

"mama" is a transitive verb here and not a noun. This sentence means "Does she mother (somebody)?" or "Does she wet-nurse (somebody)?".

The sentence "ona li ' mama anu seme?" could mean "Is she a mother?". But it can also mean "Is she maternal?".

    ?- check_grammar(P).  
    |: ona li ' mama anu seme?  
    P = s(int(or_what(np(sub(pronoun(ona)), sep(li)), (vp(be, obj_be(adjective(mama))), conj(anu), question_word(seme)))), sep(?)) ;  
    P = s(int(or_what(np(sub(pronoun(ona)), sep(li)), (vp(be, obj_be(noun(mama))), conj(anu), question_word(seme)))), sep(?)) ;  
    false.  

A "pi" make it more clear. "mama" can only be a noun here.

    ?- check_grammar(P).  
    |: ona li ' mama pi jan ni anu seme?  
    P = s(int(or_what(np(sub(pronoun(ona)), sep(li)), (vp(be, obj_be((noun(mama), sep(pi), noun(...), pronoun(...)))), conj(anu), question_word(seme)))), sep(?)) ;  
    false.  

You can check more complicated sentences also.

    ?- check_grammar(P).  
    |: ken la jan Lope li wile e ni: sina kama sona e toki pona!  
    P = s(exc(lp(sub(noun(ken)), sep(la)), 
        sim(np(sub((noun(jan), unofficial_male_name(known_male_name('Lope')))), sep(li)), vp(verb_tra(wile), obj_d(sep(e), pronoun(ni)))), sep(:),   
        sim(np(sub(pronoun(sina))), vp((verb_pre(kama), verb_tra(sona)), obj_d(sep(e), (noun(toki), adjective(pona)))))), sep(!)) ;  
    false.  

You can check a paragraph with an optional headline and several sentences. But if you use sentences with ambiguity grammar you will get many results.

At the end of a headline you have to type the sign "/" because you can't use a new line in this version of the script. For example:

en moku  
sina moku e moku.  
mi moku e moku.  
ni li ' pona pi sijelo mi.  

    ?- check_grammar(P).  
    |: en moku / sina moku e moku. mi moku e moku. ni li ' pona pi sijelo mi.  
    P = (headline(conj(en), obj_i(noun(moku))),   
        s(dec(sim(np(sub(pronoun(sina))), vp(verb_tra(moku), obj_d(sep(e), noun(moku))))), sep('.')),   
        s(dec(sim(np(sub(pronoun(mi))), vp(verb_tra(moku), obj_d(sep(e), noun(moku))))), sep('.')),   
        s(dec(sim(np(sub(pronoun(ni)), sep(li)), vp(be, obj_be((noun(...), ..., ...))))), sep('.'))) ;  

For more example sentences please see the source code of toki-pona-parser.pro.

Questions, suggestions, ... Please write to me via [twitter](https://twitter.com/jan__Lope) or this [contact form](http://rowa.giso.de/languages/toki-pona/english/contact.php)

Here an [introduction to definite clause grammars (DCG)](http://cmsmcq.com/2004/lgintro.html).

For edit the source code you can use the [atom editor](https://atom.io) with the prolog plugin. 
On MS Windows you can use the the [swi-prolog editor](http://arbeitsplattform.bildung.hessen.de/fach/informatik/swiprolog/indexe.html) also.



## In Progress

Linux user can use the generated [Toki_Pona.out](https://github.com/jan-Lope/Toki_Pona-Parser/blob/gh-pages/Toki_Pona.out) without installing swi-prolog. 
It is generated automatically by [travis-ci.org](https://travis-ci.org/jan-Lope/Toki_Pona-Parser).

Download this file and start it.


    ./Toki_Pona.out




[jan Lope](https://jan-lope.github.io)
