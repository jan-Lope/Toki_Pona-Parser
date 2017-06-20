%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unofficial words - Continents
% Include File
% by Robert Warnke http://rowa.giso.de
% released under the GNU General Public License 
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
