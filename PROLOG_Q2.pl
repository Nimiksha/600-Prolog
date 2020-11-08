mm([robert, jake, tom, andy, tristan, andrew, william, jack, sam, john, michael, caleb]).
f([rose, amy, rachel, ella, mary, jane, lauren, eve, annie, karen, sarah, betty, jill]).
family( [robert, rose, [jake, tom, ella]]). 
family( [jake, amy, [tristan, andrew, mary]]). 
family( [tom, rachel, [william, jane]]). 
family( [tom, betty, [jill]]). 
family( [andy, ella, [lauren, eve, jack]]). 
family( [william, sarah, [annie, karen, sam, john]]). 
family( [michael, sarah, [caleb]]).

male(X) :- mm(L), member(X, L).
female(X) :- f(L), member(X, L).
parent(PARENT, CHILD) :- family([PARENT, _, L]), member(CHILD, L).
parent(PARENT, CHILD) :- family([_, PARENT, L]), member(CHILD, L).
father(PARENT, CHILD) :- male(PARENT), parent(PARENT, CHILD).
mother(PARENT, CHILD) :- female(PARENT), parent(PARENT, CHILD).

sibling1(NAME1, NAME2) :- parent(PARENT1, NAME1), parent(PARENT1, NAME2), parent(PARENT2, NAME1), parent(PARENT3, NAME2), PARENT1 \= PARENT2, PARENT1 \= PARENT3, PARENT2 \= PARENT3, NAME1 \= NAME2.
sibling2(NAME1, NAME2)  :- family([_, _, L]), member(NAME1, L), member(NAME2, L), NAME1 \= NAME2.

brother1(NAME1, NAME2) :- sibling1(NAME1, NAME2), male(NAME1).
brother2(NAME1, NAME2) :- sibling2(NAME1, NAME2), male(NAME1).

sister1(NAME1, NAME2) :-  sibling1(NAME1, NAME2), female(NAME1).
sister2(NAME1, NAME2) :- sibling2(NAME1, NAME2), female(NAME1).

cousin(NAME1, NAME2) :- parent(PARENT1, NAME1), parent(PARENT2, NAME2), sibling2(PARENT1, PARENT2).	
uncle(UNCLE, CHILDNAME) :- brother2(UNCLE, CHILDPARENT), parent(CHILDPARENT, CHILDNAME). 
aunt(AUNT, CHILDNAME) :- sister2(AUNT, CHILDPARENT), parent(CHILDPARENT, CHILDNAME). 

grandchild(GRANDCHILD, GRANDPARENT)  :- parent(GRANDPARENT, PARENT), parent(PARENT, GRANDCHILD). 
grandson(GRANDSON, GRANDPARENT) :- grandchild(GRANDSON, GRANDPARENT), male(GRANDSON).
granddaughter(GRANDDAUGHTER, GRANDPARENT) :- grandchild(GRANDDAUGHTER, GRANDPARENT) , female(GRANDDAUGHTER).

greatgrandparent(GREATGRANDPARENT, GREATGRANDCHILD) :-  parent(GREATGRANDPARENT, GRANDPARENT), grandchild(GREATGRANDCHILD, GRANDPARENT).

ancestor(ANCESTOR, CHILDNAME) :- parent(ANCESTOR, CHILDNAME); grandchild(CHILDNAME, ANCESTOR); greatgrandparent(ANCESTOR, CHILDNAME).