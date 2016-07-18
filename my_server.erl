-revision('Revision: 1.01 ').
-created('Date: 2016/07/14 16:21:11 ').
-created_by('ravshan.sharipov@gmail.com').

%% user interface
-export([help/0, start/0, stop/0, info/1]).

%% intermodule exports
-export([make_pid/1, make_pid/3]).
-export([process_abbrevs/0, print_info/5]).

%% exports for use within module only
-export([init/1, info_log_impl/1]).


main_loop() ->
  receive
    {msg1, Msg1} -> 
      ...,
      main_loop();
    {msg2, Msg2} ->
      ...,
      main_loop();
    Other -> % Flushes the message queue.
      error_logger:error_msg(
          "Error: Process ~w got unknown msg ~w~n.", 
          [self(), Other]),
      main_loop()
  end.
  
  
  loop() ->
  receive
    {msg1, Msg1} -> 
      ...,
      loop();
    stop ->
      io:format("Server going down");
    Other ->
      error_logger:log({error, {process_got_other, self(), Other}}),
      loop()
  end. % This is tail-recursive

  
