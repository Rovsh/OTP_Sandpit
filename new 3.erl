-module(q3).
-export([prime_factor/3, start/1]).

start(CurrentValue) ->
	prime_factor(CurrentValue,2,1).

prime_factor(Value,X,Max_prime_factor) ->
if
	Value < X ->
		io:format("Max_prime_factor -> ~p~n", [Max_prime_factor]),
		exit;
	Value rem X == 0 -> 
		io:format("Prime factor -> ~p~n", [X]),
		if 
			Max_prime_factor < X ->
				Y = X;
			true ->	
				Y = Max_prime_factor
		end,	
		io:format("Next value to test -> ~p~n", [trunc(Value/X)]),
		prime_factor(trunc(Value/X),2,Y);
	Value rem X > 0 -> 
		prime_factor(Value,X+1,Max_prime_factor)
end.