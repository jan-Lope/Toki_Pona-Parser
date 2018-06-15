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
Use neither a space before the sentence nor double spaces.

In this example it is the sentence "mi moku.".

    |: mi moku.
    s(dec(subj_p(pronoun(mi)),pred_p(verb_t(moku))))
    s(dec(subj_p(pronoun(mi)),pred_p(verb_int(be),adjective(moku))))
    s(dec(subj_p(pronoun(mi)),pred_p(verb_int(be),noun(moku))))
    |:

You can see this sentence has three grammatical interpretations and at least three meanings. Here "moku" can be a transitive verb (verb_tra), a predicate adjective, or a predicate noun.

Let's check the next sentence.

    |: mi moku e moku.  
    s(dec(subj_p(pronoun(mi)),pred_p(verb_t(moku),obj_d(noun(moku)))))

The grammar of the sentence "mi moku e moku." is unambiguous. The first "moku" can only be a transitive verb and the second "moku" is a noun.
This sentence (s) is a declarative (dec), simple (sim) sentence. It has a subject phrase (sp) with a subject (sub) and a predicate phrase (pp) with a direct object (obj_d). Here are the abbreviations:

    s            sentence  

    dec          declarative sentence  
    exc          exclamatory sentence  
    imp          imperative sentence  
    int          interrogative sentence  
    hdl          headline  

    voc          vocativ sentence  
    inj          interjection sentence  
    salut        salutation sentence  
    com          command sentence  
    des          designate sentence  

    subj_p       subject phrase  
    pred_p       predicate phrase  
    cond_p       conditional phrase ("la")  
    voca_p       vocativ phrase  
    salu_p       salutation phrase  

    obj_d        object direct after a transitive verb  
    obj_i        object after a intransitive verb  
    obj_p        object after a prepositiion  
    obj_a        object after "anu"  

    unofficial_  unofficial word (adjective)  

    card         cardinal number  
    ord          ordinal number  

    conj         conjunction  
    verb_i       verb_intransitive  
    verb_t       verb transitive
    verb_p       verb pre
    be           The missing "be", "am", "are", "is" in Toki Pona.  

Avoid ambiguous grammar as much as possible! Keep in mind that if a sentence is clear to you, it could still not be clear to other people!

Next example: "ona li pakala e tomo tan jan seme?" This question has two grammatical readings (whom, which_object).

    |: ona li pakala e tomo tan jan seme?  
    s(int(whom(subj_p(pronoun(ona)), (pred_p(verb_t(pakala),obj_d(noun(tomo))),obj_p(preposition(tan),noun(jan),pronoun_question(seme))))))
    s(int(which_object(subj_p(pronoun(ona)),pred_p(verb_t(pakala),obj_d(noun(tomo), (adjective(tan),adjective(jan)),pronoun_question(seme))))))


A comma before "tan" turns the sentence into a whom question, because "tan" can only be a preposition here.

    |: ona li pakala e tomo, tan jan seme?  
    s(int(whom(subj_p(pronoun(ona)), (pred_p(verb_t(pakala),obj_d(noun(tomo))),obj_p(preposition(tan),noun(jan),pronoun_question(seme))))))

In the next example a comma can make the grammatical structure unambiguous. But maybe this is not what you mean.

    |: jan pona pi meli mi en mi li moku e moku.  
    s(dec(subj_p(((noun(jan),adjective(pona)), (noun(meli),pronoun(mi)),conj(en),pronoun(mi))),pred_p(verb_t(moku),obj_d(noun(moku)))))
    s(dec(subj_p((((noun(jan),adjective(pona)),noun(meli),pronoun(mi)),conj(en),pronoun(mi))),pred_p(verb_t(moku),obj_d(noun(moku)))))

    |: jan pona pi meli mi, en mi li moku e moku.
   s(dec(subj_p((((noun(jan),adjective(pona)),noun(meli),pronoun(mi)),conj(en),pronoun(mi))),pred_p(verb_t(moku),obj_d(noun(moku)))))

If you would like to mark the missing "be", you can use an apostrophe for the grammar check. This is not an official Toki Pona rule, but it avoids ambiguity.

    |: ni li ' moku.  
    s(dec(subj_p(pronoun(ni)),pred_p(verb_int(be),adjective(moku))))
    s(dec(subj_p(pronoun(ni)),pred_p(verb_int(be),noun(moku))))

To reduce the object variants to a noun, you can use "pi".  

    |: ni li ' moku pi jan pona.  
    s(dec(subj_p(pronoun(ni)),pred_p(verb_int(be), (noun(moku),noun(jan),adjective(pona)))))

To mark numbers, you can use a comma or a "#" (unofficial).

    |:  jan lili li moku e moku.  
    s(dec(subj_p((noun(jan),adjective(lili))),pred_p(verb_t(moku),obj_d(noun(moku)))))
    s(dec(subj_p((noun(jan),card(adjective(lili)))),pred_p(verb_t(moku),obj_d(noun(moku)))))

    |:  jan, lili li moku e moku.  
    s(dec(subj_p((noun(jan),card(adjective(lili)))),pred_p(verb_t(moku),obj_d(noun(moku)))))

    |:  jan # lili li moku e moku.  
    s(dec(subj_p((noun(jan),card(adjective(lili)))),pred_p(verb_t(moku),obj_d(noun(moku)))))

These scripts can help you to better understand Toki Pona sentences.
For example the sentence “sina pona ala pona?” can not mean “Are you ok or not ok?”
The verb "are" (or "be") doesn't exist in Toki Pona.
"pona" can only be a transitive verb here.

    |: sina pona ala pona?
    s(int(yes_no(subj_p(pronoun(sina)),pred_p(verb_t(pona),adverb(ala),verb_t(pona)))))

This example makes it clearer:

    |: sina pona ala pona e ni?
    s(int(yes_no(subj_p(pronoun(sina)),pred_p(verb_t(pona),adverb(ala),verb_t(pona),obj_d(pronoun(ni))))))

To say “Are you ok or not ok?” use "sina ' pona anu seme?":

    |: sina ' pona anu seme?
    s(int(or_what(subj_p(pronoun(sina)), (pred_p(verb_int(be),adjective(pona)),conj(anu),pronoun_question(seme)))))
    s(int(or_what(subj_p(pronoun(sina)), (pred_p(verb_int(be),noun(pona)),conj(anu),pronoun_question(seme)))))

This sentence is clearer.

    |: sina ' pona pi pilin en sijelo anu seme?
    s(int(or_what(subj_p(pronoun(sina)), (pred_p(verb_int(be), (noun(pona),noun(pilin),conj(en),noun(sijelo))),conj(anu),pronoun_question(seme)))))

An other example is the sentence "ona li mama ala mama?", which cannot mean "Is she a mother?"

    |: ona li mama ala mama?
    s(int(yes_no(subj_p(pronoun(ona)),pred_p(verb_t(mama),adverb(ala),verb_t(mama)))))

"mama" is a transitive verb here and not a noun. This sentence means "Does she mother (somebody)?" or "Does she wet-nurse (somebody)?".

The sentence "ona li ' mama anu seme?" could mean "Is she a mother?". But it can also mean "Is she maternal?".

    |: ona li ' mama anu seme?
    s(int(or_what(subj_p(pronoun(ona)), (pred_p(verb_int(be),adjective(mama)),conj(anu),pronoun_question(seme)))))
    s(int(or_what(subj_p(pronoun(ona)), (pred_p(verb_int(be),noun(mama)),conj(anu),pronoun_question(seme)))))

A "pi" make it clearer. "mama" can only be a noun here.

    |: ona li ' mama pi jan ni anu seme?  
    s(int(or_what(subj_p(pronoun(ona)), (pred_p(verb_int(be), (noun(mama),noun(jan),pronoun(ni))),conj(anu),pronoun_question(seme)))))

You can check more complicated sentences also.

    |: ken la jan Lope li wile e ni: sina kama sona e toki pona!
    s(exc(cond_p(noun(ken)),subj_p((noun(jan),unofficial_male_name(known_male_name(Lope)))),pred_p(verb_t(wile),obj_d(pronoun(ni))),
      subj_p(pronoun(sina)),
      pred_p((verb_p(kama),verb_t(sona)),obj_d((noun(toki),adjective(pona))))))

You can check a paragraph with an optional heading and several sentences. But if you use sentences with ambiguous structure, you will get many results.
At the end of a heading you have to type the sign "/", because you can't use a new line in this version of the script. For example:

en moku  
sina moku e moku.  
mi moku e moku.  
ni li ' pona pi sijelo mi.  

    |: en moku / sina moku e moku. mi moku e moku. ni li ' pona pi sijelo mi.  

If you type a wrong sentence, you will get no results. 
If you press the "enter" key only, the script will stop.


Questions, suggestions, ... Please write to me via [twitter](https://twitter.com/jan__Lope).

Here an [introduction to definite clause grammars (DCG)](http://cmsmcq.com/2004/lgintro.html).

For edit the source code you can use the [atom editor](https://atom.io) with the prolog plugin.
On MS Windows you can use the the [swi-prolog editor](http://arbeitsplattform.bildung.hessen.de/fach/informatik/swiprolog/indexe.html) also.



## To Do

Several unofficial Names, for example "jan Eliku Kulaputon li jan sewi."

Quotation marks for quotes and unofficial names.





[jan Lope](https://jan-lope.github.io)
