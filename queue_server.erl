-module(queue_server).
-revision('Revision: 1.01 ').
-created('Date: 2016/07/14 16:21:11 ').
-created_by('ravshan.sharipov@gmail.com').


%% user interface
%-export([help/0, start/0, stop/0, info/1]).
-export([start/0, stop/0, info/1]).

%% intermodule exports
%-export([make_pid/1, make_pid/3]).
%-export([process_abbrevs/0, print_info/5]).

%% exports for use within module only
-export([init/0]).
-export([new/0, add/2, fetch/1, len/1]).

%%% Client API
start() -> spawn_link(fun init/0).

%%% Server functions
init() -> loop().

loop() ->
  receive
    {msg1, Msg1} -> 
       loop();
    stop ->
      io:format("Server going down");
    Other ->
      error_logger:log({error, {process_got_other, self(), Other}}),
      loop()
  end. % This is tail-recursive

stop() ->
      io:format("Server going down").

  

new() -> 
  {[],[]}.

add(Item, {X,Y}) -> 
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
  
  
start(Name, F, State) ->
    register(Name, spawn(server, loop, [Name, F, State])).

stop(Name) ->
    exit(whereis(Name), kill).

call(Name, Query) ->
    Name ! {self(), Query},
    receive
        {Name, Reply} ->
            Reply
    end.

loop(Name, F, State) ->
    receive
        {Pid, Query} ->
            {Reply, State1} = F(Query, State),
            Pid ! {Name, Reply},
            loop(Name, F, State1)
    end.

