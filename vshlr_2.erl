-module(vshlr_2).
-copyright('Copyright (c) 1991-97 Ericsson Telecom AB').
-vsn('$Revision: /main/release/2 $').

-export([start/0, start_link/0, stop/0, i_am_at/2, find/1]).

-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

%% These are the interface routines 

start() -> gen_server:start({local, xx2}, vshlr_2, [], []).
start_link() -> gen_server:start_link({local, xx2}, vshlr_2, [], []).

stop()  -> gen_server:call(xx2, die, 10000).

i_am_at(Person, Location) -> 
    gen_server:call(xx2, {i_am_at, Person, Location}, 10000).

find(Person)  -> 
    gen_server:call(xx2, {find, Person}, 10000).

add(Message)  -> 
    gen_server:call(xx2, {add, Message}, 10000).

	
%% These Routine MUST be exported since they are called by gen_server

init(_) -> 
	
	{ok, []}.

handle_call({i_am_at, Person, Location}, _, State) ->
    State1 = update_location(Person, Location, State),
    {reply, ok, State1};
handle_call({find, Person}, _, State) ->
    Location = lookup(Person, State),
    {reply, Location, State};
handle_call({add, Message}, _, State) ->
    State1 = add_message(Message, State),
    {reply, ok, State1};
handle_call(die, _, State) ->
    %% ok goes back to the user and terminate(normal, State)
    %% will be called
    {stop,  normal, ok, State}.

handle_cast(Request, State) -> {noreply, State}.
handle_info(Request, State) -> {noreply, State}.
terminate(Reason, State) -> 
    ok.

%% sub-functions

update_location(Key, Value, [{Key, _}|T]) -> [{Key, Value}|T];
update_location(Key, Value, [H|T])        -> [H|update_location(Key, Value, T)];
update_location(Key, Value, [])           -> [{Key,Value}].

lookup(Key, [{Key, Value}|_]) -> {at, Value};
lookup(Key, [_|T])            -> lookup(Key, T);
lookup(Key, [])               -> lost.

add_message(Message, State) ->
,
