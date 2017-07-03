%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unofficial words - Ideologies, Religions
% Include File
% by Robert Warnke http://rowa.giso.de
% released under the GNU General Public License 
%
% These scripts are based on the offical Toki Pona book of Sonja Lang (http://tokipona.org ), 
% the lessons of jan Pije ( http://tokipona.net/tp/janpije/ ) and
% the lessons of jan Lope ( https://jan-lope.github.io ).
% These scripts do not support Toki Pona slangs!
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ideology_catalog(known_ideology(Ideology_catalog),Ideology_catalog) --> [Ideology_catalog], { member(Ideology_catalog, [  
     'Jawatu',      % Judaism
     'Juju',        % Universalism  
     'Kolisu',      % Christianity     
     'Latapali',    % Rastafarianism 
     'Patapali',    % Pastafarianism
     'Puta',        % Buddhism 
     'Silami'       % Islam 
 ])
}.

/*
?- ideology_catalog(X,_,_).
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eof
