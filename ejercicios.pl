%Ejercicios con listas

longitud([],0).
longitud([Cab|Cola],T):-longitud(Cola,T1),T is T1+1.

insertar([],Y,[Y]).
insertar([Cab|Cola],Y,L):-insertar(Cola,Y,LS),L=[Cab|LS].

ultimo([X],X).
ultimo([Cab|Cola],Y):-ultimo(Cola,Y).

pertenece([Cab|Cola],Cab).
pertenece([Cab|Cola],X):-pertenece(Cola,X).

concatenar([],L,R):-R=L.
concatenar([Cab|Cola],L,R):-concatenar(Cola,L,R1),R=[Cab|R1].

obtenerPrimerElemento([],[]).
obtenerPrimerElemento([Cab|Cola],Cab).

resto([],[]).
resto([Cab|Cola],Cola).

primeros([X],[]).
primeros([],[]).
primeros([Cab|Cola],R):-primeros(Cola,R1),R=[Cab|R1].

invertir([],[]).
invertir([Cab|Cola],R):-invertir(Cola,R1),append(R1,[Cab],R).

obtenerEnesimo([Cab|Cola],0,Cab).
obtenerEnesimo([Cab|Cola],N,X):-S is N-1,obtenerEnesimo(Cola,S,X).

eliminarOcurrencia([Cab|Cola],Cab,R):-R=Cola.
eliminarOcurrencia([Cab|Cola],X,R):-eliminarOcurrencia(Cola,X,R1),R=[Cab|R1].

ocurrencias([],X,0).
ocurrencias([Cab|Cola],Cab,N):-ocurrencias(Cola,Cab,N1),N is N1+1.
ocurrencias([Cab|Cola],X,N):-ocurrencias(Cola,X,N).

nElementosLista([Cab|Cola],1,R):-R=[Cab].
nElementosLista([Cab|Cola],N,R):-S is N-1,nElementosLista(Cola,S,R1),R=[Cab|R1].

eliminarDuplicados([],[]).
eliminarDuplicados([Cab|Cola],R):-eliminarDuplicados(Cola,R1),(member(Cab,R1)->R=R1;R=[Cab|R1]).

eliminarDuplicados2([],[]).
eliminarDuplicados2([Cab|Cola],R):-
    (member(Cab,Cola)->eliminarDuplicados2(Cola,R);
     eliminarDuplicados2(Cola,R1),R=[Cab|R1]).

dividir([Cab|Cola],1,[Cab],Cola).
dividir([Cab|Cola],N,S,R):-P is N-1,dividir(Cola,P,K,R),S=[Cab|K].

palindromo(L):-invertir(L,S),L==S.

factorial(0,1).
factorial(1,1).
factorial(N,X):-S is N-1,factorial(S,X1),X is N*X1.

fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,X):-N1 is N-1,N2 is N-2,fibonacci(N1,R1),fibonacci(N2,R2),X is R1+R2.



%Ejercicio de sintomas y padecimiento de enfermedades

padece(pedro, gripe).
padece(pedro, hepatitis).
padece(juan, hepatitis).
padece(maria, gripe).
padece(carlos, intoxicacion).

sintoma(gripe, fiebre).
sintoma(gripe, cansancio).
sintoma(hepatitis, cansancio).
sintoma(intoxicacion, diarrea).

suprime(aspirina, fiebre).
suprime(lomotil, diarrea).

efecto_secundario(aspirina, dolor_estomago).
efecto_secundario(lomotil, somnolencia).

tiene_sintoma(P, Sintoma) :- padece(P, Enfermedad), sintoma(Enfermedad, Sintoma).

tratamiento(P, Medicamento) :- tiene_sintoma(P, Sintoma), suprime(Medicamento, Sintoma).

alivia(Farmaco, Enfermedad) :- sintoma(Enfermedad, Sintoma), suprime(Farmaco, Sintoma).

deberiaTomar(X):-padece(X,E),alivia(M,E),write(M),nl.
efectoSecundario(X,M):-padece(X,E),alivia(M,E),efecto_secundario(M,S),write(M),write(' = '),write(S),nl.

tratamientoPedro:-tratamiento(pedro,M),(efecto_secundario(M,_)->fail;write(M),!).

noEfectoSecundario(M):-efecto_secundario(M,_),!,fail.
noEfectoSecundario(_).

tratamientoPedro2:-tratamiento(pedro,M),noEfectoSecundario(M),write(M),fail.