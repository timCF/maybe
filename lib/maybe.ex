defmodule Maybe do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Maybe.Worker, [arg1, arg2, arg3])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Maybe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def to_integer(some) when is_binary(some) do
    case Integer.parse(some) do
      {int, ""} -> int
      _ -> case Float.parse(some) do
          {fl, ""} -> case to_integer(fl) do
                  some_int when is_integer(some_int) -> some_int
                  _ -> some
                end
          _ -> some
         end
    end
  end
  def to_integer(some) when is_float(some) do
    case round(some) do
      int when (some == int) -> int
      _ -> some
    end
  end
  def to_integer(some) when is_atom(some) do
    case some |> Atom.to_string |> to_integer do
      int when is_integer(int) -> int
      _ -> some
    end
  end
  def to_integer(some) when is_list(some) do
    case maybe_to_string(some) do
      lst when is_list(lst) -> some
      bin when is_binary(bin) ->
        case to_integer(bin) do
          int when is_integer(int) -> int
          _ -> some
        end
    end
  end
  def to_integer(some), do: some



  def to_float(some) when is_integer(some), do: some / 1
  def to_float(some) when is_binary(some) do
    case Float.parse(some) do
      {fl, ""} -> fl
      _ -> some
    end
  end
  def to_float(some) when is_atom(some) do
    case some |> Atom.to_string |> to_float do
      fl when is_float(fl) -> fl
      _ -> some
    end
  end
  def to_float(some) when is_list(some) do
    case maybe_to_string(some) do
      lst when is_list(lst) -> some
      bin when is_binary(bin) ->
        case to_float(bin) do
          fl when is_float(fl) -> fl
          _ -> some
        end
    end
  end
  def to_float(some), do: some



  def to_number(some) do
    case to_integer(some) do
      int when is_integer(int) -> int
      ^some -> to_float(some)
    end
  end




  def to_atom(some) when is_binary(some), do: String.to_atom(some)
  def to_atom(some) when is_number(some), do: some |> maybe_to_string |> String.to_atom
  def to_atom(some) when is_list(some) do
    case maybe_to_string(some) do
      bin when is_binary(bin) -> String.to_atom(bin)
      _ -> some
    end
  end
  def to_atom(some), do: some


	def maybe_to_string(some, params \\ %{})
	def maybe_to_string(atom, _) when is_atom(atom), do: Atom.to_string(atom)
	def maybe_to_string(int, _) when is_integer(int), do: Integer.to_string(int)
	def maybe_to_string(float, %{decimals: decimals}) when is_float(float) and is_integer(decimals) and (decimals > 0) do
		Float.to_string(float, [decimals: decimals])
		|> String.codepoints
		|> Enum.reverse
		|> Enum.drop_while(&(&1 == "0"))
		|> Enum.reverse
		|> Enum.join
	end
	def maybe_to_string(float, _) when is_float(float), do: Float.to_string(float)
	def maybe_to_string(some, _) when (is_list(some)) do
		try do
			:erlang.list_to_binary(some)
		rescue
			_ -> some
		catch
			_ -> some
		end
	end
	def maybe_to_string(some, _), do: some


	def to_map(some) when is_list(some) do
		case Keyword.keyword?(some) do
			true -> Enum.reduce(some, %{}, fn({k,v},acc) -> Map.put(acc,k,v) end)
			false -> some
		end
	end
	def to_map(some), do: some

end
