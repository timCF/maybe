defmodule Maybe.Global do
	defmacro __using__(_) do
		quote do



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
				case some |> to_string |> Integer.parse do
					{int, _} when (some == int) -> int
					_ -> some
				end
			end
			def to_integer(some) when is_atom(some) do
				case some |> to_string |> to_integer do
					int when is_integer(int) -> int
					_ -> some
				end
			end
			def to_integer(some) do
				some
			end
			

			
			def to_float(some) when is_integer(some) do
				some / 1
			end
			def to_float(some) when is_binary(some) do
				case Float.parse(some) do
					{fl, ""} -> fl
					_ -> some
				end
			end
			def to_float(some) when is_atom(some) do
				case some |> to_string |> to_float do
					fl when is_float(fl) -> fl
					_ -> some
				end
			end
			def to_float(some) do
				some
			end
		


			def to_number(some) do
				case to_integer(some) do
					int when is_integer(int) -> int
					^some -> to_float(some)
				end
			end
			



			def to_atom(some) when is_binary(some) do
				String.to_atom(some)
			end
			def to_atom(some) when is_number(some) do
				some |> to_string |> String.to_atom
			end
			def to_atom(some) do
				some
			end
			
			
			
			def maybe_to_string(some) when (is_number(some) or is_atom(some)) do
				some |> to_string
			end
			def maybe_to_string(some) do
				some
			end


			def to_map(some) when is_list(some) do
				case HashUtils.is_hash?(some) do
					true -> HashUtils.to_map(some)
					false -> some
				end
			end
			def to_map(some), do: some


		end
	end
end