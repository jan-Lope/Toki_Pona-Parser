%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unofficial words - Continents
% Include File
% by Robert Warnke https://jan-lope.github.io
% released under the GNU General Public License 
%
% These scripts are based on the offical Toki Pona book (first English edition 2014) of Sonja Lang (http://tokipona.org ), 
% the lessons (2015) of jan Pije ( http://tokipona.net/tp/janpije/ ) and
% the lessons of jan Lope ( https://jan-lope.github.io ).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

continent_catalog(known_continent(Continent_catalog),Continent_catalog) --> [Continent_catalog], { member(Continent_catalog, [
     'Amelika',       % Americas, North America: 'Amelika lete', South America: 'Amelika seli'
     'Antasika',      % Antarctica
     'Apika',         % Africa
     'Asija',         % Asia
     'Elopa',         % Europe
     'Osejanija'      % Oceania
 ])
}.

/*
?- continent_catalog(X,_,_).
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eof
