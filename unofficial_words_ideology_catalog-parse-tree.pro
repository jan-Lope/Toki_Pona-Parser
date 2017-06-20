%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unofficial words - Ideologies, Religions
% Include File
% by Robert Warnke http://rowa.giso.de
% released under the GNU General Public License 
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
