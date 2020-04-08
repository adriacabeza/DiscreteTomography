w(0,0). w(0,1). w(0,2). w(0,3). w(0,4). w(0,5).  
w(1,0). w(1,1). w(1,2). w(1,3). w(1,4). w(1,5). 
w(2,0). w(2,1). w(2,2). w(2,3). w(2,4). w(2,5). 
w(3,0). w(3,1). w(3,2). w(3,3). w(3,4). w(3,5). 
w(4,0). w(4,1). w(4,2). w(4,3). w(4,4). w(4,5). 
w(5,0). w(5,1). w(5,2). w(5,3). w(5,4). w(5,5). 


limitX([5,3,3,4,3,5]).
limitY([5,3,5,1,5,4]).


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
        d(X0,Y0,X1,Y1), 
        \+ memberchk( w(X1,Y1), SoFar), 
        nth0(X1, AuxX, OldX), 
        nth0(Y1, AuxY, OldY),
        NewY is 1 + OldY,
        NewX is 1 + OldX,
        replace(X1, AuxX, NewX, AuxX1),
        replace(Y1, AuxY, NewY, AuxY1),
        limitX(X_list),
        limitY(Y_list),
        nth0(X1, X_list,X_lim),
        nth0(Y1, Y_list,Y_lim), 
        NewX =< X_lim, 
        NewY =< Y_lim,
        go(X1,Y1,X,Y,[w(X1,Y1)|SoFar],Path, AuxX1,AuxY1), !.

%go(0,5,1,0,[w(0,5)],Path,[1,0,0,0,0,0], [0,0,0,0,0,1]).
