%
%  Fact base for CS 531
%

person(joe,instructor).
person(darren,student).
person(jeff,student).
person(seema,student).
person(michael,student).
person(joe,student).

%
%  clause
%

doesboth(X) :- person(X,student), person(X,instructor).


