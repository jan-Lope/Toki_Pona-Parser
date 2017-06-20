%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unofficial words - Communities
% Include File
% by Robert Warnke http://rowa.giso.de
% released under the GNU General Public License 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

community_catalog(known_community(Community_catalog),Community_catalog) --> [Community_catalog], { member(Community_catalog, [  
     'Neje'       % Nerds     
 ])
}.

/*
?- community_catalog(X,_,_).
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eof
