-module(queuers).
-export([new/0, add/2, fetch/1, len/1]).

new() -> 
  {[],[]}.

add(Item, {X,Y}) -> % Faster addition of elements
  {[Item|X], Y}.

fetch({X, [H|T]}) -> 
  {ok, H, {X,T}}; 

fetch({[], []}) -> 
  empty; 

fetch({X, []}) -> 
  % Perform this heavy computation only sometimes.
  fetch({[],lists:reverse(X)}).

len({X,Y}) -> 
  length(X) + length(Y).