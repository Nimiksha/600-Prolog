is_member_of_list(X, [X|_]).
is_member_of_list(X, [_|T]) :- is_member_of_list(X, T).

first_element(X, [X|_]).

last_element(X, [X]).
last_element(X, [_|T]) :- last_element(X, T).

two_adjacent_elements(X, Y, [X,Y|_]).
two_adjacent_elements(X, Y, [_|T]) :- two_adjacent_elements(X, Y, T).

three_adjacent_elements(X, Y, Z, [X,Y,Z|_]).
three_adjacent_elements(X, Y, Z, [_|T]) :- three_adjacent_elements(X, Y, Z, T).

append_lists([], L, L).
append_lists([X|T1], L2, [X|T3]) :- append_lists(T1, L2, T3).

delete_element(X, [X|T], T).
delete_element(X, [H|T], [H|T1]) :- delete_element(X, T, T1).

append_element(E, [], [E]).
append_element(E, [X|T], [X|T1]) :- append_element(E, T, T1).

insert_in_list(X, L, XL) :- delete_element(X, XL, L).

length_of_list([],0).
length_of_list([_|T], N) :- length_of_list(T, N1), N is 1 + N1.

reverse_list([], L, L).
reverse_list([H|T], L, X1) :- reverse_list(T, L, [H|X1]).

palindrome_check(L) :- reverse_list(L, X, []), L == X.

display_list([]).
display_list([H|T]) :- write(H), display_list(T).