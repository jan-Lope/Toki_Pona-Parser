%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unofficial words - Ideologies, Religions
% Include File
% by Robert Warnke https://jan-lope.github.io
% released under the GNU General Public License 
%
% These scripts are based on the offical Toki Pona book (first English edition 2014) of Sonja Lang (http://tokipona.org ), 
% the lessons (2015) of jan Pije ( http://tokipona.net/tp/janpije/ ) and
% the lessons of jan Lope ( https://jan-lope.github.io ).
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
