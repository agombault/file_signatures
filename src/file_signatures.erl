-module(file_signatures).

-export([is_type/2]).

is_type(Filename, Type) ->
  case file:read_file(Filename) of
    {ok, Binary} ->
      verify_signature(Binary, Type);
    Error ->
      Error
  end.

verify_signature(Data, Type) ->
  try
    case erlang:apply(files_signatures, Type, [Data]) of
      true ->
        ok;
      _ ->
        {error, invalid_signature}
    end
  catch
    _:_ ->
      {error, unknow_file_signature}
  end.


