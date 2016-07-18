%6. The following iterative sequence is defined for the set of positive integers:
%
%n → n/2 (n is even)
%n → 3n + 1 (n is odd)
%
%Using the rule above and starting with 13, we generate the following sequence:
%13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
%It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
%Which starting number, under one million, produces the longest chain?
%NOTE: Once the chain starts the terms are allowed to go above one million.

-module(q6).
-export([longest_chain/5, start/1]).

start(MaxNumber) ->
	io:format("Start:~s~n",[print_time:format_utc_timestamp()]),
	longest_chain(MaxNumber,MaxNumber,0,MaxNumber,0),
	io:format("Finish:~s~n",[print_time:format_utc_timestamp()]).

longest_chain(0,CurrentNumber,CurrentChain,MaxNumber,MaxChain) ->
	io:format("Max Chain quantity -> ~p  started from ~p ~n", [MaxChain,MaxNumber]);
longest_chain(X,CurrentNumber,CurrentChain,MaxNumber,MaxChain) ->
if
	X == 1 ->
		if CurrentChain > MaxChain ->
			Y = CurrentChain,
			N = CurrentNumber;
		true -> 
			Y = MaxChain,
			N = MaxNumber
		end,
%		io:format("Ok Number ~p was processed through ~p steps, Next Number -> ~p~n", [CurrentNumber,CurrentChain, CurrentNumber-1]),
		longest_chain(CurrentNumber-1,CurrentNumber-1,0,N,Y);
	X rem 2 == 0 ->
%		io:format("Even -> ~p~n", [X]),
		longest_chain(X div 2, CurrentNumber, CurrentChain+1, MaxNumber, MaxChain);
	true ->
%		io:format("Odd -> ~p~n", [X]),
		longest_chain(X * 3 + 1, CurrentNumber, CurrentChain + 1, MaxNumber, MaxChain)
end.