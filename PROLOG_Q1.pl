%FACTS
   is_male(robert).
   is_male(jake).
   is_male(tom).
   is_male(andy).
   is_male(tristan).
   is_male(andrew).
   is_male(william).
   is_male(jack).
   is_male(sam).
   is_male(john).
   is_male(michael).
   is_male(caleb).
 
   %female:
   is_female(rose).
   is_female(amy).
   is_female(rachel).
   is_female(ella).
   is_female(mary).
   is_female(jane).
   is_female(lauren).
   is_female(eve).
   is_female(annie).
   is_female(karen).
   is_female(sarah).
   is_female(betty).
   is_female(jill).
 
   %parents:
   is_parent_of(robert, jake).
   is_parent_of(robert, tom).
   is_parent_of(robert, ella).
   is_parent_of(rose, jake).
   is_parent_of(rose, tom).
   is_parent_of(rose, ella).
 
   is_parent_of(jake, tristan).
   is_parent_of(jake, andrew).
   is_parent_of(jake, mary).
   is_parent_of(amy, tristan).
   is_parent_of(amy, andrew).
   is_parent_of(amy, mary).
 
   is_parent_of(tom, william).
   is_parent_of(tom, jane).
   is_parent_of(rachel, william).
   is_parent_of(rachel, jane).
  
   is_parent_of(tom, jill).
   is_parent_of(betty, jill).
 
   is_parent_of(ella, lauren).
   is_parent_of(ella, eve).
   is_parent_of(ella, jack).
   is_parent_of(andy, lauren).
   is_parent_of(andy, eve).
   is_parent_of(andy, jack).
 
   is_parent_of(william, annie).
   is_parent_of(william, karen).
   is_parent_of(william, sam).
   is_parent_of(william, john).
   is_parent_of(sarah, annie).
   is_parent_of(sarah, karen).
   is_parent_of(sarah, sam).
   is_parent_of(sarah, john).
 
   is_parent_of(sarah, caleb).
   is_parent_of(michael, caleb).
 
%rules:
   mother(MOTHER, CHILD) :- is_female(MOTHER), is_parent_of(MOTHER, CHILD).
   father(FATHER, CHILD) :- is_male(FATHER), is_parent_of(FATHER, CHILD).
 
   %1 parent in common
   sibling1(NAME1, NAME2) :- is_parent_of(PARENT1, NAME1), is_parent_of(PARENT1, NAME2), is_parent_of(PARENT2, NAME1), is_parent_of(PARENT3, NAME2), PARENT1 \= PARENT2, PARENT1 \= PARENT3, PARENT2 \= PARENT3, NAME1 \= NAME2.
   brother1(NAME1, NAME2) :- sibling1(NAME1, NAME2), is_male(NAME2).
   sister1(NAME1, NAME2) :-  sibling1(NAME1, NAME2), is_female(NAME2).
 
   %2 parent in common
   sibling2(NAME1, NAME2)  :- father(PARENT1, NAME1), mother(PARENT2, NAME1), father(PARENT1, NAME2), mother(PARENT2, NAME2), NAME1 \= NAME2, PARENT1 \= PARENT2.
   brother2(NAME1, NAME2) :- sibling2(NAME1, NAME2), is_male(NAME2).
   sister2(NAME1, NAME2) :- sibling2(NAME1, NAME2), is_female(NAME2).
 
   cousin(NAME1, NAME2) :- is_parent_of(PARENT1, NAME1), is_parent_of(PARENT2, NAME2), sibling2(PARENT1, PARENT2).
   uncle(UNCLE, CHILDNAME) :- brother2(CHILDPARENT, UNCLE), is_parent_of(CHILDPARENT, CHILDNAME).
   aunt(AUNT, CHILDNAME) :- sister2(CHILDPARENT, AUNT), is_parent_of(CHILDPARENT, CHILDNAME).
 
   grandparent(GRANDPARENT, GRANDCHILD) :- is_parent_of(PARENT, GRANDCHILD), is_parent_of(GRANDPARENT, PARENT).
   grandmother(GRANDMOTHER, GRANDCHILD) :- grandparent(GRANDMOTHER, GRANDCHILD), is_female(GRANDMOTHER).
   grandfather(GRANDFATHER, GRANDCHILD) :- grandparent(GRANDFATHER, GRANDCHILD) , is_male(GRANDFATHER).
   grandchild(GRANDCHILD, GRANDPARENT) :- grandparent(GRANDPARENT, GRANDCHILD).
 
   greatgrandparent(GREATGRANDPARENT, GREATGRANDCHILD) :-  is_parent_of(GREATGRANDPARENT, GRANDPARENT), grandparent(GRANDPARENT, GREATGRANDCHILD).
 
   ancestor(ANCESTOR, CHILDNAME) :- is_parent_of(ANCESTOR, CHILDNAME); grandparent(ANCESTOR, CHILDNAME); greatgrandparent(ANCESTOR, CHILDNAME).
