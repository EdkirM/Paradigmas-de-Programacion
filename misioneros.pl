% --- Estados inválidos: cuando hay más caníbales que misioneros en alguna orilla (si hay misioneros)
invalido(estado(MI, CI, _)) :-
    MI > 0, CI > MI.  % En la izquierda

invalido(estado(MI, CI, _)) :-
    MD is 3 - MI, CD is 3 - CI,
    MD > 0, CD > MD.  % En la derecha

% --- Posibles movimientos (cantidad de misioneros, cantidad de caníbales, dirección)
mover(1,0, izquierda).
mover(1,0, derecha).
mover(0,1, izquierda).
mover(0,1, derecha).
mover(2,0, izquierda).
mover(2,0, derecha).
mover(0,2, izquierda).
mover(0,2, derecha).
mover(1,1, izquierda).
mover(1,1, derecha).

% --- Movimiento de derecha a izquierda
movimiento(mover(M, C, izquierda), estado(MI, CI, derecha), estado(MI2, CI2, izquierda)) :-
    mover(M, C, izquierda),
    MD is 3 - MI, CD is 3 - CI,    % Cantidad actual en la derecha
    MD >= M, CD >= C,              % Hay suficientes para mover
    MI2 is MI + M, CI2 is CI + C.  % Se suman al lado izquierdo

% --- Movimiento de izquierda a derecha
movimiento(mover(M, C, derecha), estado(MI, CI, izquierda), estado(MI2, CI2, derecha)) :-
    mover(M, C, derecha),
    MI >= M, CI >= C,              % Hay suficientes para mover desde la izquierda
    MI2 is MI - M, CI2 is CI - C.  % Se restan del lado izquierdo

% --- Caso base: cuando ya se ha llegado al estado final
camino(Estado, Estado, _, []).

% --- Caso recursivo: buscar una secuencia de movimientos válida
camino(EstadoInicial, EstadoFinal, Visitados, [mover(M,C,Dir)|Camino]) :-
    movimiento(mover(M,C,Dir), EstadoInicial, NuevoEstado),
    \+ invalido(NuevoEstado),                    % Estado debe ser válido
    \+ member(NuevoEstado, Visitados),           % Evitar ciclos
    camino(NuevoEstado, EstadoFinal, [NuevoEstado|Visitados], Camino).

% --- Llamada principal
solucion(Camino) :-
    camino(estado(3,3,izquierda), estado(0,0,derecha), [], Camino).
