%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unofficial words - Movies
% Include File
% by Robert Warnke https://jan-lope.github.io
% released under the GNU General Public License 
%
% These scripts are based on the offical Toki Pona book (first English edition 2014) of Sonja Lang (http://tokipona.org ), 
% the lessons (2015) of jan Pije ( http://tokipona.net/tp/janpije/ ) and
% the lessons of jan Lope ( https://jan-lope.github.io ).
%
% http://tokipona.net/tp/Transliterate.aspx
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

movies_catalog(known_movie(Movies_catalog),Movies_catalog) --> [Movies_catalog], { member(Movies_catalog, [  
     'Fahrenheit 9/11',
     'Bowling for Columbine',
     'X-Files'
 ])
}.

/*
?- movies_catalog(X,_,_).
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eof
