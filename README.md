# Toki Pona Parser - A Tool for Spelling, Grammar Check and Ambiguity Check of Toki Pona Sentences

Toki Pona is a constructed, minimal language, designed by the translator and linguist Sonja Lang.
Toki Pona favors simplicity over clarity, and touts itself as "the language of good. The simple way of life."

By virtue of Toki Pona's extremely small vocabulary, and order-independent syntax, the language is good at talking about feelings and simple relationships, but not about the finer points of politics or silicon-on-insulator microchip fabrication techniques. Tokiponists believe this is exactly as it should be.

Whether you accept the philosophy or not, Toki Pona is fun to speak. 


## About

This parser analyzes Toki Pona sentences. It ckecks the spelling and grammar. 
Furthermore, it finds possible grammatical variants. That is, it finds grammatical ambiguities. 
It helps you to form correct and clear Toki Pona sentences.

This parser is written in SWI-Prolog. SWI-Prolog is a free implementation of the programming language Prolog. 
Prolog is a general-purpose logic programming language associated with artificial intelligence and computational linguistics. 
SWI-Prolog supported the Definite Clause Grammar (DCG). 
DCG is a logic way of expressing grammar, either for natural or formal languages. 
These scripts contain DCG rules for describing the Toki Pona grammar.

In short: This tool analyzes Toki Pona sentences based on logic and not on "maybe" or "could be". 

It based on the offical Toki Pona book of Sonja Lang ( [tokipona.org](http://tokipona.org) ), 
the lessons of jan Pije ( [tokipona.net/tp/janpije](http://tokipona.net/tp/janpije/) ),
the lessons of jan Lope ( [jan-lope.github.io](https://jan-lope.github.io) ) and many text examples.

## Installation

### MS Windows
First you have to download SWI-Prolog for Windows: [http://www.swi-prolog.org/download/stable](http://www.swi-prolog.org/download/stable)   

Install SWI-Prolog:

    Select type of install: Typical
    Destination Folder: C:\Program Files\swipl
    Extension for Prolog files: pro

After this you have to download the Toki Pona parser from this link [https://github.com/jan-Lope/Toki_Pona-Parser](https://github.com/jan-Lope/Toki_Pona-Parser). 
Use the button "Clone or download" and then "Download ZIP". 
Unzip the file "Toki_Pona-Parser-master.zip". 
Change to the new folder "Toki_Pona-Parser-master" and doppel click the file "Toki_Pona.pro". 
A new window opens. After the prompt |: you can type Toki Pona sentences.

    |: 


![swi-prolog-windows](swi-prolog-windows.gif?raw=true "ding")


### Linux
First you have to install swi-prolog. Here are the command for Ubuntu/Debian: 

    $ sudo apt-get install swi-prolog  

After this you have to download the Toki Pona parser from this link [https://github.com/jan-Lope/Toki_Pona-Parser](https://github.com/jan-Lope/Toki_Pona-Parser). 
Use the button "Clone or download" and then "Download ZIP". 

Unzip the file "Toki_Pona-Parser-master.zip" and changed to the new directory.

    $ unzip Toki_Pona-Parser-master.zip
    $ cd Toki_Pona-Parser-master

Under Linux you can start the script directly.

    $ ./Toki_Pona.pro  
    |: 


### Mac OS X 10.7 and later
First you have to download and install install swi-prolog: [http://www.swi-prolog.org/download/stable](http://www.swi-prolog.org/download/stable)   

After this you have to download the Toki Pona parser from this link [https://github.com/jan-Lope/Toki_Pona-Parser](https://github.com/jan-Lope/Toki_Pona-Parser). 
Use the button "Clone or download" and then "Download ZIP". 

Unzip the file "Toki_Pona-Parser-master.zip". 
Change to the new folder "Toki_Pona-Parser-master" and doppel click the file "Toki_Pona.pro". 
At the first time you will be asked for the program to open this file. 
Please select "SWI-Prolog".
A new window opens. After the prompt |: you can type Toki Pona sentences.

    |: 
  
    
## Usage

Now you can check the grammar of a Toki Pona sentence.
After the prompt |: you can type a Toki Pona sentence. 
Use neither a space before the sentence nor doppel spaces.
In this example it is the sentence "mi moku.".

    |: mi moku.  
    s(dec(sim(sp(sub(pronoun(mi))),pp(verb_tra(moku)))),sep(.))
    s(dec(sim(sp(sub(pronoun(mi))),pp(be,predicate(adjective(moku))))),sep(.))
    s(dec(sim(sp(sub(pronoun(mi))),pp(be,predicate(noun(moku))))),sep(.))    s(dec(sim(sp(sub(pronoun(mi))), pp(verb_tra(moku)))), sep('.')) 
    |: 

You can see this sentence has three grammar variants and at least three meanings. Here can "moku" be a transitive verb (verb_tra), an predicate adjective or a predicate noun.

Let's check the next sentence. 

    |: mi moku e moku.  
    s(dec(sim(sp(sub(pronoun(mi))),pp(verb_tra(moku),obj_d(sep(e),noun(moku))))),sep(.))

The grammar of the sentence "mi moku e moku." is unambiguously. The first "moku" can only be a transitive verb and the second "moku" is a noun.
This sentence (s) is a declarative (dec), simple (sim) sentence. It has a subject phrase (sp) with a subject (sub) and a predicate phrase (pp) with a direct object (obj_d). Here are the abbreviations:

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
  
    sp           subject phrase  
    pp           predicate phrase  
    cond         conditional phrase ("la")  
    vocp         vocativ phrase  
    salutp       salutation phrase  
  
    subj         subject  
  
    obj_d        object direct after transitive verb  
    obj_i        object after intransitive verb  
    obj_p        object after prepositiion  
    obj_a        object after "anu"  
  
    unofficial_  unofficial word (adjective)  
  
    card         cardinal number  
    ord          ordinal number  
  
    conj         conjunction  
    verb_int     verb_intransitive  
    verb_tra     verb transitive  
    be           The missing "be", "am", "are", "is" in Toki Pona.  

Avoid ambiguous grammar as much as possible! Keep in mind if a sentence is clear for you it could be not clear for other people!

Next example: "ona li pakala e tomo tan jan seme?" This question has two grammar variants (whom, which_object).

    |: ona li pakala e tomo tan jan seme?  
    s(int(whom(sp(sub(pronoun(ona))), (pp(verb_tra(pakala),obj_d(noun(tomo))),obj_p(preposition(tan),noun(jan),question_word(seme))))))
    s(int(which_object(sp(sub(pronoun(ona))),pp(verb_tra(pakala),obj_d(noun(tomo), (adjective(tan),adjective(jan)),question_word(seme))))))

A comma before "tan" make the sentence to a whom question only, because "tan" can only be a preposition here.

    |: ona li pakala e tomo, tan jan seme?  
    s(int(whom(sp(sub(pronoun(ona))), (pp(verb_tra(pakala),obj_d(noun(tomo))),obj_p(preposition(tan),noun(jan),question_word(seme))))))

In the next example a comma can make the grammar unambiguous. But maybe this is not what you mean.

    |: jan pona pi meli mi en mi li moku e moku.  
    s(dec(sim(sp(sub(((noun(jan),adjective(pona)), (noun(meli),pronoun(mi)),conj(en),pronoun(mi)))),pp(verb_tra(moku),obj_d(noun(moku))))))
    s(dec(sim(sp((sub(((noun(jan),adjective(pona)),noun(meli),pronoun(mi))),conj(en),sub(pronoun(mi)))),pp(verb_tra(moku),obj_d(noun(moku))))))

    |: jan pona pi meli mi, en mi li moku e moku.  
    s(dec(sim(sp((sub(((noun(jan),adjective(pona)),noun(meli),pronoun(mi))),conj(en),sub(pronoun(mi)))),pp(verb_tra(moku),obj_d(noun(moku))))))


If you would like to mark the missing "be" you can use an apostrophe for the grammar check. This is not an official Toki Pona rule, but it avoid ambiguous.

    |: ni li ' moku.  
    s(dec(sim(sp(sub(pronoun(ni))),pp(be,predicate(adjective(moku))))))
    s(dec(sim(sp(sub(pronoun(ni))),pp(be,predicate(noun(moku))))))

To reduce the object variants to a noun you can use "pi".  

    |: ni li ' moku pi jan pona.  
    s(dec(sim(sp(sub(pronoun(ni))),pp(be,predicate((noun(moku),noun(jan),adjective(pona)))))))

To mark numbers you can use a comma or a "#" (unofficial).

    |:  jan lili li moku e moku.  
    s(dec(sim(sp(sub((noun(jan),adjective(lili)))),pp(verb_tra(moku),obj_d(noun(moku))))))
    s(dec(sim(sp(sub((noun(jan),card(adjective(lili))))),pp(verb_tra(moku),obj_d(noun(moku))))))

    |:  jan, lili li moku e moku.  
    s(dec(sim(sp(sub((noun(jan),card(adjective(lili))))),pp(verb_tra(moku),obj_d(noun(moku))))))

    |:  jan # lili li moku e moku.  
    s(dec(sim(sp(sub((noun(jan),card(adjective(lili))))),pp(verb_tra(moku),obj_d(noun(moku))))))

These scripts can help you to better understand Toki Pona sentences. 
For example the sentence “sina pona ala pona?” can not mean “Are you ok or not ok?”
The verb "are" (or "be") doesn't exist in Toki Pona. 
"pona" can only be a transitive verb here. 

    |: sina pona ala pona?
    s(int(yes_no(sp(sub(pronoun(sina))),pp(verb_tra(pona),adverb(ala),verb_tra(pona)))),sep(?))

This example make it more clear.

    |: sina pona ala pona e ni?
    s(int(yes_no(sp(sub(pronoun(sina))),pp(verb_tra(pona),adverb(ala),verb_tra(pona),obj_d(sep(e),pronoun(ni))))),sep(?))

To say “Are you ok or not ok?” use "sina ' pona anu seme?":

    |: sina ' pona anu seme?
    s(int(or_what(sp(sub(pronoun(sina))), (pp(be,predicate(adjective(pona))),conj(anu),question_word(seme)))))
    s(int(or_what(sp(sub(pronoun(sina))), (pp(be,predicate(noun(pona))),conj(anu),question_word(seme)))))

This sentence is clearer.

    |: sina ' pona pi pilin en sijelo anu seme?
    s(int(or_what(sp(sub(pronoun(sina))), (pp(be,predicate((noun(pona),noun(pilin),conj(en),noun(sijelo)))),conj(anu),question_word(seme)))))

An other example is the sentence "ona li mama ala mama?" can not mean "Is she a mother?"

    |: ona li mama ala mama?
    s(int(yes_no(sp(sub(pronoun(ona))),pp(verb_tra(mama),adverb(ala),verb_tra(mama)))))

"mama" is a transitive verb here and not a noun. This sentence means "Does she mother (somebody)?" or "Does she wet-nurse (somebody)?".

The sentence "ona li ' mama anu seme?" could mean "Is she a mother?". But it can also mean "Is she maternal?".

    |: ona li ' mama anu seme?  
    s(int(or_what(sp(sub(pronoun(ona))), (pp(be,predicate(adjective(mama))),conj(anu),question_word(seme)))))
    s(int(or_what(sp(sub(pronoun(ona))), (pp(be,predicate(noun(mama))),conj(anu),question_word(seme)))))

A "pi" make it more clear. "mama" can only be a noun here.

    |: ona li ' mama pi jan ni anu seme?  
    s(int(or_what(sp(sub(pronoun(ona))), (pp(be,predicate((noun(mama),noun(jan),pronoun(ni)))),conj(anu),question_word(seme)))))

You can check more complicated sentences also.

    |: ken la jan Lope li wile e ni: sina kama sona e toki pona!  
    s(exc(cond(sub(noun(ken))),sim(sp(sub((noun(jan),unofficial_male_name(known_male_name(Lope))))),pp(verb_tra(wile),obj_d(pronoun(ni)))),
    sim(sp(sub(pronoun(sina))),pp((verb_pre(kama),verb_tra(sona)),obj_d((noun(toki),adjective(pona)))))))

You can check a paragraph with an optional headline and several sentences. But if you use sentences with ambiguity grammar you will get many results.
At the end of a headline you have to type the sign "/" because you can't use a new line in this version of the script. For example:

en moku  
sina moku e moku.  
mi moku e moku.  
ni li ' pona pi sijelo mi.  

    |: en moku / sina moku e moku. mi moku e moku. ni li ' pona pi sijelo mi.  


If you type a wrong sentence you see no results. 
If you type the key "enter" only the script will stop.


Questions, suggestions, ... Please write to me via [twitter](https://twitter.com/jan__Lope).

Here an [introduction to definite clause grammars (DCG)](http://cmsmcq.com/2004/lgintro.html).

For edit the source code you can use the [atom editor](https://atom.io) with the prolog plugin. 
On MS Windows you can use the the [swi-prolog editor](http://arbeitsplattform.bildung.hessen.de/fach/informatik/swiprolog/indexe.html) also.



## To Do

Several unofficial Names, for example "jan Eliku Kulaputon li jan sewi."

Quotation marks for Quotes and unofficial names.





[jan Lope](https://jan-lope.github.io)
