%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Official words - Toki Pona
% Include File
% by Robert Warnke https://jan-lope.github.io
% released under the GNU General Public License
%
% These scripts are based on the offical Toki Pona book (first English edition 2014) of Sonja Lang (http://tokipona.org ),
% the lessons (2015) of jan Pije ( http://tokipona.net/tp/janpije/ ) and
% the lessons of jan Lope ( https://jan-lope.github.io ).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

adjectiv(adjective(Adjectiv),Adjectiv) --> [Adjectiv], { member(Adjectiv, [
     akesi,        % amphibian-, reptilian-, slimy
     ala,          % no, not, none, un-
     alasa,        % hunting-, -hunting, hunting ...
     ale,          % all, every, complete, whole  (ale = ali), (depreciated)
     ali,          % all, every, complete, whole  (ale = ali)
     anpa,         % low, lower, bottom, down
     ante,  	   % different, dissimilar, altered, changed, other, unequal, differential, variant
     awen,         % remaining, stationary, permanent, sedentary
     esun,         % commercial, trade, marketable, for sale, salable, deductible
     ijo,          % of something
     ike,          % bad, negative, wrong, evil, overly complex, (figuratively) unhealthy
     ilo,          % useful
     insa,         % inner, internal
     jaki,         % dirty, gross, filthy, obscene
     jan,          % human, somebody's, personal, of people
     jelo,         % yellowish, yellowy
     jo,           % private, personal
     kala,         % fish-
     kalama,       % noisy
     kama,         % coming, future
     kasi,         % vegetable, vegetal, biological, biologic, leafy
     kili,         % fruity
     kin,          % indeed, still, too; in can be the very last word in an adjective group.
     kiwen,        % hard, solid, stone-like, made of stone or metal
     kon,          % air-like, ethereal, gaseous
     kule,         % colourful, pigmented, painted
     kulupu,       % communal, shared, public, of the society
     kute,         % auditory, hearing
     lape,         % sleeping, of sleep, dormant
     laso,         % bluish, bluey
     lawa,         % main, leading, in charge
     len,          % dressed, clothed, costumed, dressed up
     lete,         % cold, cool, uncooked, raw, perishing
     lili,         % small, little, young, a bit, short, few, less
     linja,        % elongated, oblong, long
     lipu,         % book-, paper-, card-, ticket-, sheet-, page,-
     loje,         % reddish, ruddy, pink, pinkish, gingery
     lon,          % real, true, existing, correct, genuine
     luka,         % tactile
     lukin,        % visual(ly)
     lupa,         % hole-, holey, full of holes
     ma,           % countrified, outdoor, alfresco, open-air
     mama,         % of the parent, parental, maternal, fatherly, maternal, motherly, mumsy
     mani,         % financial, financially, monetary, pecuniary
     meli,         % female, feminine, womanly
     mije,         % male, masculine, manly
     moku,         % eating
     moli,         % dead, dying, fatal, deadly, lethal, mortal, deathly, killing
     monsi,        % back, rear
     monsuta,      % fearful, afraid
     mu,           % animal nois-
     mun,          % lunar
     musi,         % artful, fun, recreational
     mute,         % many, very, much, several, a lot, abundant, numerous, more
     namako,       % spicy, piquant
     nanpa,        % ... th, To build ordinal numbers.
     nasa,         % silly, crazy, foolish, drunk, strange, stupid, weird
     nasin,        % systematic, habitual, customary, doctrinal, doctrinaire
     nena,         % hilly, undulating, mountainous, hunchbacked, humpbacked, bumpy
     noka,         % lower, bottom, pertaining to legs or feet
     oko,          % optical, eye-
     olin,         % love
     open,         % initial, starting, opening
     pakala,       % destroyed, ruined, demolished, shattered, wrecked
     pali,         % active, work-related, operating, working
     palisa,       % long,
     pana,         % generous, radioactive, contagious
     pilin,        % sensitive, feeling, empathic
     pimeja,       % black, dark
     pini,         % completed, finished, past, done
     poka,         % neighbouring
     pona,         % good, simple, positive, nice, correct, right
     pu,           % buying and interacting with the official Toki Pona book
     sama,         % same, similar, equal, of equal status or position
     seli,         % hot, warm, cooked
     sewi,         % superior, elevated, religious, formal
     sijelo,       % physical, bodily, corporal, corporeal, material, carnal
     sike,         % round, cyclical, of one year
     sin,          % new, fresh, another, more
     sinpin,       % facial, frontal, anterior, vertical
     sitelen,      % figurative, pictorial, metaphorical, metaphorisch
     sona,         % knowing, cognizant, shrewd
     soweli,       % animal
     suli,         % big, tall, long, adult, important
     suno,         % sunny, sunnily
     supa,         % flat, shallow, flat-bottomed, horizontal
     suwi,         % sweet, cute
     tan,          % causal,
     taso,         % only, sole
     tawa,         % moving, mobile
     telo,         % wett, slobbery, moist, damp, humid, sticky, sweaty, dewy, drizzly
     tenpo,        % temporal, chronological, chronologic
     toki,         % speaking, eloquent, linguistic, verbal, grammatical
     tomo,         % urban, domestic, household
     unpa,         % erotic, sexual
     uta,          % oral
     utala,        % fighting
     walo,         % white, whitish, light-coloured, pale
     waso,         % bird-
     wawa,         % energetic, strong, fierce, intense, sure, confident
     weka          % absent, away, ignored
%     wile          % necessary
 ])
}.

adverb(adverb(Adverb),Adverb) --> [Adverb], { member(Adverb, [
     ala,          % don't
     ale,          % always, forever, evermore, eternally (ale = ali), (depreciated)
     ali,          % always, forever, evermore, eternally (ale = ali)
     anpa,         % downstairs, below, deep, low, deeply
     awen,         % still, yet
     ijo,          % of something
     ike,          % bad, negative, wrong, evil, overly complex, (figuratively) unhealthy
     ilo,          % usefully
     jaki,         % dirty, gross, filthy
     jan,          % human, somebody's, personal, of people
     kama,         % coming, future
     kili,         % fruity
     kin,          % actually, indeed, in fact, really, objectively, as a matter of fact; kin can be the very last word in an adverb group.
     kiwen,        % hard, solid, stone-like, made of stone or metal
     kon,          % air-like, ethereal, gaseous
     lape,         % asleep
     lawa,         % main, leading, in charge
     lete,         % bleakly
     lili,         % small, little, young, a bit, short, few, less
     lukin,        % visual(ly)
     mani,         % financially
     moku,         % eating
     moli,         % mortally
     mu,           % animal nois-
     musi,         % cheerfully
     mute,         % many, very, much, several, a lot, abundant, numerous, more
     nasa,         % silly, crazy, foolish, drunk, strange, stupid, weird
     noka,         % on foot
     pakala,       % destroyed, ruined, demolished, shattered, wrecked
     pali,         % actively, briskly
     pilin,        % perceptively
     pini,         % ago, past, perfectly
     pona,         % good, simple, positive, nice, correct, right
     sama,         % just as, equally, exactly the same, just the same, similarly
     seli,         % hot, warm, cooked
     sewi,         % superior, elevated, religious, formal
     sijelo,       % physically, bodily
     sike,         % rotated
     sin,          % afresh, anew, in turn,
     sitelen,      % pictorially
     suli,         % big, tall, long, adult, important
     suno,         % sunny, sunnily
     taso,         % only, just, merely, simply, solely, singly
     tawa,         % moving, mobile
     telo,         % wett, slobbery, moist, damp, humid, sticky, sweaty, dewy, drizzly
     tenpo,        % chronologically
     toki,         % speaking, eloquent, linguistic, verbal, grammatical
     tomo,         % urban, domestic, household
     unpa,         % erotic, sexual
     uta,          % orally
     utala,        % fighting
     wawa,         % strongly, powerfully
     weka          % away
%     wile          % necessary
 ])
}.

conjunction(conj(Conjunction),Conjunction) --> [Conjunction], { member(Conjunction, [
%     ante,         % otherwise, on the other hand
     anu,          % or (used for decision questions)
     en,           % and (used to coordinate head nouns)
%     ike,          % unfortunately
%     kin,          % moreover, in addition, likewise
%     open,         % firstly, in the beginning
%     pona,         % luckily
     taso          % but, however
 ])
}.

% interjection_word(Interjection_word) --> [Interjection_word], { member(Interjection_word, [
interjection_word(interjection(Interjection_word),Interjection_word) --> [Interjection_word], { member(Interjection_word, [
     a,            % ah, ha, uh, oh, ooh, aw, well (emotion word)
     mu,           % woof! meow! moo! etc. (cute animal noise)
     o             % hey! (calling somebody's attention)
 ])
}.

noun(noun(Noun),Noun) --> [Noun], { member(Noun, [
     akesi,        % reptile, amphibian; non-cute animal
     ala,          % nothing, negation, zero
     alasa,        % hunting
     ale,          % everything, anything, life, the universe, (depreciated)
     ali,          % everything, anything, life, the universe
     anpa,         % bottom, lower part, under, below, floor, beneath
     ante,         % difference, distinction, differential, variation, variance, disagreement
     awen,         % inertia, continuity, continuum, stay
     esun,         % market, shop, fair, bazaar, business, transaction
     ijo,          % thing, something, stuff, anything, object
     ike,          % negativity, badness, evil
     ilo,          % tool, device, machine, thing used for a specific purpose
     insa,         % inside, inner world, centre, stomach
     jaki,         % dirt, pollution, garbage, filth, feces
     jan,          % person, people, human, being, somebody, anybody
     jelo,         % yellow, light green
     jo,           % having, possessions, content
     kala,         % fish, marine animal, sea creature
     kalama,       % sound, noise, voice
     kama,         % event, happening, chance, arrival, beginning
     kasi,         % plant, vegetation, herb, leaf
     ken,          % possibility, ability, power to do things, permission
     kepeken,      % use, usage, tool
     kili,         % fruit, pulpy vegetable, mushroom
     kin,          % reality, fact,
     kipisi,       % section, fragment, slice
     kiwen,        % hard thing, rock, stone, metal, mineral, clay
     ko,           % semi-solid or squishy substance; clay, clinging form, dough, glue, paste, powder, gum
     kon,          % air, wind, smell, soul
     kule,         % color, colour, paint, ink, dye, hue
     kulupu,       % group, community, society, company, people
     kute,         % hearing, ear
     lape,         % sleep, rest
     laso,         % blue, blue-green
     lawa,         % head, mind
     len,          % clothing, cloth, fabric, network, internet
     lete,         % cold, chill, bleakness
     lili,         % smallness, youth, immaturity
     linja,        % long and flexible thing; string, rope, hair, thread, cord, chain, line, yarn
     lipu,         % paper, card, ticket, sheet, page, flat and bendable thing, book, webpage, blog, list
     loje,         % red
     lon,          % existence, being, presence
     luka,         % arm, hand, tacticle organ
     lukin,        % view, look, glance, sight, gaze, glimpse, seeing, vision, sight, attention
     lupa,         % hole, orifice, door, window
     ma,           % land, earth, country, (outdoor) area
     mama,         % parent, mother, father
     mani,         % money, material wealth, currency, dollar, capital
     meli,         % woman, female, girl, wife, girlfriend
     mije,         % man, male, husband, boyfriend
     moku,         % food, meal
     moli,         % death, decease
     monsi,        % back, rear end, butt, behind
     monsuta,      % monster, monstrosity, fearful thing, fright, mythical creatures, fear
     mu,           % animal noise
     mun,          % moon, lunar, night sky object, star
     musi,         % fun, playing, game, recreation, art, entertainment
     mute,         % amount, quantity
     namako,       % spice, something extra, food additive, accessory
     nanpa,        % number
     nasa,         % stupidity, foolishness, silliness, nonsense, idiocy, inanity, obtuseness, ninny, muddler
     nasin,        % way, manner, custom, road, path, doctrine, system, method
     nena,         % bump, hill, extrusion, button, mountain, nose, protuberance
     nimi,         % word, name
     noka,         % leg, foot; organ of locomotion; bottom, lower part
     oko,          % eye
     olin,         % love
     open,         % start, beginning, opening
     pakala,       % blunder, accident, mistake, destruction, damage, breaking
     pali,         % activity, work, deed, project
     palisa,       % long hard thing; branch, rod, stick, pointy thing
     pan,          % cereal, grain; barley, corn, oat, rice, wheat; bread, pasta
     pana,         % giving, transfer, exchange
     pilin,        % feelings, emotion, feel, think, sense, touch, heart (physical or emotional)
     pimeja,       % darkness, shadows
     pini,         % end, tip
     pipi,         % bug, insect, spider
     poka,         % side, hip, next to
     poki,         % container, box, bowl, cup, glass
     pona,         % good, simplicity, positivity
     pu,           % buying and interacting with the official Toki Pona book
     sama,         % equality, parity, equity, identity, par, sameness
     seli,         % fire, warmth, heat
     selo,         % skin, external surface of something, outer form, outer layer, outside, bark, peel, shell, skin, boundary, shape
     sewi,         % high, up, above, top, over, on
     sijelo,       % body (of person or animal), physical state, torso
     sike,         % circle, ball, cycle, sphere, wheel; round or circular thing
     sin,          % news, novelty, innovation, newness, new release
     sinpin,       % face, foremost, front, wall, chest, torso
     sitelen,      % picture, image, representation, symbol, mark, writing
     sona,         % knowledge, wisdom, intelligence, understanding
     soweli,       % animal, especially land mammal, lovable animal, beast
     suli,         % size
     suno,         % sun, light
     supa,         % horizontal surface, e.g furniture, table, chair, pillow, floor
     suwi,         % candy, sweet food
     tan,          % origin, cause
     tawa,         % movement, transportation
     telo,         % water, liquid, juice, sauce
     tenpo,        % time, period of time, moment, duration, situation, occasion
     toki,         % language, speech, tongue, lingo, jargon,
     tomo,         % indoor constructed space, e.g. house, home, room, building
     tu,           % duo, pair
     unpa,         % sex, sexuality
     uta,          % mouth, lips, oral cavity, jaw, beak
     utala,        % conflict, disharmony, competition, fight, war, battle, attack, blow, argument, physical or verbal violence
     walo,         % white thing or part, whiteness, lightness
     wan,          % unit, element, particle, part, piece
     waso,         % bird, bat; flying creature, winged animal
     wawa,         % energy, strength, power
     weka,         % absence
     wile          % desire, need, will
 ])
}.

numeral(numeral(Numeral),Numeral) --> [Numeral], { member(Numeral, [
     ala,          %   0
     wan,          %   1
     tu,           %   2
     luka,         %   5
%     ten,         %  10 (suggestion of jan Lope)
     mute,         %  20 (official Toki Pona book)
     ale           % 100 (official Toki Pona book)
 ])
}.

preposition(preposition(Preposition),Preposition) --> [Preposition], { member(Preposition, [
     kepeken,      % with, using
     lon,          % be (located) in/at/on
%     poka,         % in the accompaniment of, with
     sama,         % like, as, seem
     tan,          % from, by, because of, since
     tawa          % to, in order to, towards, for, until
 ])
}.

pronoun(pronoun(Pronoun),Pronoun) --> [Pronoun], { member(Pronoun, [
     mi,           % I, we (pronoun 1. person)
     sina,         % you (pronoun 2. person)
     ona,          % she, he, it, they (pronoun 3. person)
     ni            % this, that (pronoun determiner)
 ])
}.

question_word(question_word(Question_word),Question_word) --> [Question_word], { member(Question_word, [
	seme           % what, which, wh- (question word)
 ])
}.

% separator(sep(Separator),Separator) --> [Separator], { member(Separator, [
separator(Separator) --> [Separator], { member(Separator, [
     e,            % introduces a direct object
     la,           % between the context phrase and the main sentence
     li,           % between any subject except mi and sina and its verb
     o,            % O (vocative or imperative)
     pi,           % separates a noun from another noun that has at least one adjective
     '.',          % At the end of a sentence.
     '!',          % At the end of an interjection.
     '?',          % At the end of a question.
     ':',          % Between an hint sentences and a sentences.
     ',',          % comma
     '"',          % quotation mark
     "''",         % apostrophe
     '#',          % unofficial number sign
     '/'           % unofficial headline end. Because a new line is not possible in "check_grammar"
 ])
}.

verb_intransitive(verb_int(Verb_intransitive),Verb_intransitive) --> [Verb_intransitive], { member(Verb_intransitive, [
     anpa,         % to prostrate oneself
     awen,         % to stay, to wait,to remain
     ike,          % to be bad, to suck
     kalama,       % to make noise
     kama,         % to come, to become, to arrive, to happen, manage to, start to
     kasi,         % to grow
     ken,          % can, is able to, is allowed to, may, is possible
     kepeken,      % to use
     kon,          % to breathe
     lape,         % to sleep, to rest
     lon,          % to be there, to be present, to be real/true, to exist, to be awake
     lukin,        % to look, to watch out, to pay attention
     moli,         % to die, to be dead
     mu,           % to communicate animally
     musi,         % to play, to have fun
     pakala,       % to screw up, to fall apart, to break
     pali,         % to act, to work, to function
     pilin,        % to feel, to sense
     pu,           % to read (the official Toki Pona book)
     sewi,         % to get up
     sona,         % to know, to understand
     tan,          % to come from, to originate from, to stem from, to be descended from, to emerge, to follow, to come out of
     tawa,         % go to, walk, travel, move, leave
     toki,         % to talk, to chat, to communicate
     unpa          % to have sex
 ])
}.

verb_transitive(verb_tra(Verb_transitive),Verb_transitive) --> [Verb_transitive], { member(Verb_transitive, [
     alasa,        % to hunt, to forage
     anpa,         % to defeat, to beat, to vanquish, to conquer, to enslave
     ante,         % to change, to alter, to modify
     awen,         % to keep
     esun,         % to buy, to sell, to barter, to swap
     ijo,          % to objectify
     ike,          % to make bad, to worsen, to have a negative effect upon
%     ilo,          % to work on with tools, to work with machines
     jaki,         % to pollute, to dirty
     jan,          % to personify, to humanize, to personalize
%     jelo,         % to color yellow, to turn yellow
     jo,           % to have, to contain
     kalama,       % to sound, to ring, to play (an instrument)
     kama,         % to bring about, to summon
     kasi,         % to plant, to grow
     ken,          % to make possible, to enable, to allow, to permit
     kipisi,       % to cut
     kiwen,        % to solidify, to harden, to petrify, to fossilize
     ko,           % to squash, to pulverize
     kon,          % to blow away something, to puff away something
     kule,         % to paint, to color
     kulupu,       % to assemble, to call together, to convene
     kute,         % to hear, to listen,
     lape,         % to knock out
     lawa,         % to lead, to control, to rule, to steer
     len,          % to wear, to be dressed, to dress
     lete,         % to cool down, to chill
     lili,         % to reduce, to shorten, to shrink, to lessen
     lukin,        % to see, to look at, to watch, to read
     lupa,         % to pierce, to stab, to perforate
     mama,         % to mother sb., to wet-nurse, mothering
     moku,         % to eat, to drink, to swallow, to ingest, to consume
     moli,         % to kill
     mu,           % to make animal nois
     musi,         % to amuse, to entertain
     mute,         % to make many or much
     namako,       % to spice, to flavor, to decorate
     nanpa,        % to count
     nasa,         % to drive crazy, to make weird
     nimi,         % to name
     olin,         % to love (a person)
     open,         % to open, to start, to begin, to turn on
     pakala,       % to screw up, to fuck up, to botch, to ruin, to break, to hurt, to injure, to damage, to spoil, to ruin
     pali,         % to do, to make, to build, to create
     palisa,       % to stretch, to beat, to poke, to stab, to poke, to prod, to sexually arouse
     pan,          % to sow
     pana,         % to give, to put, to send, to place, to release, to emit, to cause, to transmit
     pilin,        % to feel, to think, to sense, to touch, to handle, to finger, to fumble, to grope, to fiddle, to pet, to caress, to fondle
     pimeja,       % to darken
     pini,         % to end, to stop, to turn off, to finish, to close
     poki,         % to box up, to put in, to can
     pona,         % to improve, to fix, to repair, to make good
     pu,           % to apply (the official Toki Pona book) to
     sama,         % to equate, to make equal, to make similar to
     seli,         % to heat, to warm up, to cook
     selo,         % to shelter, to protect, to guard
     sewi,         % to lift
     sike,         % to orbit, to circle, to revolve, to circle around, to rotate
     sin,          % to renew, to renovate, to freshen
     sijelo,       % to heal, to heal up, to cure
     sitelen,      % to draw, to write
     sona,         % to know, to understand, to know how to
     suli,         % to enlarge, to lengthen
     suno,         % to light, to illumine
%     supa,         % to bury
     suwi,         % to sweeten
     tawa,         % to move, to displace
     telo,         % to water, to wash with water, to put water to, to melt, to liquify
     toki,         % to speak, to talk, to say, to pronounce, to discourse
     tomo,         % to build, to construct, to engineer
     tu,           % to divide, to double, to separate, to cut in two
     unpa,         % to have sex with, to sleep with, to fuck
     uta,          % to kiss, to osculate, to oral stimulate, to suck
     utala,        % to hit, to strike, to attack, to compete against
     walo,         % to whiten, to whitewash
     wan,          % to unite, to make one
     wawa,         % to strengthen, to energize, to empower
     weka,         % to remove, to eliminate, to throw away, to remove, to get rid of
     wile          % to want, need, wish, have to, must, will, should
 ])
}.

verb_pre(verb_pre(Verb_pre),Verb_pre) --> [Verb_pre], { member(Verb_pre, [
     kama,         % to become, to mange to
     ken,          % to can, may
     kepeken,      % to use
     lukin,        % to seek to, try to, look for
     open,         % to begin, to start
     pini,         % to stop, to finish, to end, to interrupt
     pu,           % buying and interacting with the official Toki Pona book
     sona,         % to know how to
     wile          % to want, need, wish, have to, must, will, should
 ])
}.

verb_be(be) --> [].     % In Toki Pona is no verb "to be".
verb_be(be) --> ['''']. % Inofficial: You can use an apostrophe instead of "to be".
                        % In prolog you have to quote an apostrophe with an second apostrophe.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eof
