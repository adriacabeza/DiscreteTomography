% it can last about 10 minutes
% we only need to delete from here the cells to avoid 
w(0,0). w(0,1). w(0,2). w(0,3). w(0,4). w(0,5). 								 w(0, 8).
w(1,0). w(1,1). w(1,2). w(1,3). w(1,4). 												 w(1, 8).
w(2,0). w(2,1). w(2,2). w(2,3). w(2,4). 				 								 w(2, 8).
w(3,0). 				w(3,2). w(3,3). w(3,4). w(3,5). w(3,6). w(3, 7). w(3, 8).
w(4,0). w(4,1). w(4,2). w(4,3). w(4,4). w(4,5). w(4,6). w(4, 7). w(4, 8).
w(5,0). w(5,1). w(5,2). w(5,3). w(5,4).					w(5,6). w(5, 7). w(5, 8).
w(6,0). w(6,1). w(6,2). w(6,3). w(6,4). w(6,5). w(6,6). 				 w(6, 8).
w(7,0). w(7,1). w(7,2). w(7,3). w(7,4). w(7,5). w(7,6).					 w(7, 8).
w(8,0). w(8,1). w(8,2). w(8,3). w(8,4). w(8,5). w(8,6). w(8, 7). w(8, 8).



limitX([6,4,2,4,8,5,7,7]).
limitY([6,7,8,7,5,5,4,1]).


d(X0,Y0,X,Y) :- next_w(X0,Y0,X,Y), w(X,Y).
next_w(X0,Y0,X0,Y) :- Y is Y0+1.
next_w(X0,Y0,X,Y0) :- X is X0+1.
next_w(X0,Y0,X0,Y) :- Y is Y0-1.
next_w(X0,Y0,X,Y0) :- X is X0-1.


replace(I, L, E, K) :-
        nth0(I, L, _, R),
        nth0(I, K, E, R).


go(X,Y,X,Y,Path,Path, AuxX, AuxY):-
        
        limitX(X_list),
        limitY(Y_list),
        X_list = AuxX,
        Y_list = AuxY,
        write('Final path:'), reverse(Path,R), write(R).


go(X0,Y0,X,Y,SoFar,Path, AuxX, AuxY) :-
        d(X0,Y0,X1,Y1), % we make next step
        \+ memberchk( w(X1,Y1), SoFar), % we check if we have already been there
        nth0(X1, AuxX, OldX), 
        nth0(Y1, AuxY, OldY),
        NewY is 1 + OldY,
        NewX is 1 + OldX,
        replace(X1, AuxX, NewX, AuxX1),
        replace(Y1, AuxY, NewY, AuxY1),
        limitX(X_list),
        limitY(Y_list),
        nth0(X1, X_list,X_lim), % take the limit of this row
        nth0(Y1, Y_list,Y_lim), % take the limit of this columns
        NewX =< X_lim, 
        NewY =< Y_lim,
        go(X1,Y1,X,Y,[w(X1,Y1)|SoFar],Path, AuxX1,AuxY1), !.


