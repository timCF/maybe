defmodule MaybeTest do
  use ExUnit.Case

  test "to_integer" do
    assert 111 == Maybe.to_integer("111")
    assert "0 111" == Maybe.to_integer("0 111")
    assert -111 == Maybe.to_integer("-0111")
    assert 111 == Maybe.to_integer(:"0111")
    assert 1.222 == Maybe.to_integer(1.222)
    assert [123] == Maybe.to_integer([123])
    assert {123} == Maybe.to_integer({123})
    assert :qwe == Maybe.to_integer(:qwe)
    assert "123 qwe" == Maybe.to_integer("123 qwe")
    assert "12.12" == Maybe.to_integer("12.12")
    assert 12 == Maybe.to_integer("12.0")
    assert 123 == Maybe.to_integer('123')
    assert 123 == Maybe.to_integer('0123')
    assert 123 == Maybe.to_integer('0123.0')
	assert 100 == Maybe.to_integer(1.0e2)
	assert 100 == Maybe.to_integer('1.0e2')
	assert 100 == Maybe.to_integer("1.0e2")
    assert [nil, :atom, "string"] == Maybe.to_integer([nil, :atom, "string"])
  end

  test "to_float" do
    assert 111.0 == Maybe.to_float("111")
    assert "0 111" == Maybe.to_float("0 111")
    assert -111.0 == Maybe.to_float("-0111")
    assert 111.0 == Maybe.to_float(:"0111")
    assert 1.222 == Maybe.to_float(1.222)
    assert [123] == Maybe.to_float([123])
    assert {123} == Maybe.to_float({123})
    assert :qwe == Maybe.to_float(:qwe)
    assert -0.123 == Maybe.to_float("-0.123")
    assert "123.2 qwe" == Maybe.to_float("123.2 qwe")
    assert (12.0 == Maybe.to_float(12)) and is_float(Maybe.to_float(12))
    assert (123.0 == Maybe.to_float('123')) and is_float(Maybe.to_float(:'123'))
    assert (123.0 == Maybe.to_float('0123')) and is_float(Maybe.to_float('0123'))
    assert (123.0 == Maybe.to_float('0123.0')) and is_float(Maybe.to_float('0123.0'))
    assert [nil, :atom, "string"] == Maybe.to_float([nil, :atom, "string"])
  end

  test "to_number" do
    assert 111 == Maybe.to_number("111")
    assert "0 111" == Maybe.to_number("0 111")
    assert -111 == Maybe.to_number("-0111")
    assert 111 == Maybe.to_number(:"0111")
    assert 1.222 == Maybe.to_number(1.222)
    assert [123] == Maybe.to_number([123])
    assert {123} == Maybe.to_number({123})
    assert :qwe == Maybe.to_number(:qwe)
    assert -0.123 == Maybe.to_number("-0.123")
    assert "123.2 qwe" == Maybe.to_number("123.2 qwe")
    assert 123 == Maybe.to_number('123')
    assert 123 == Maybe.to_number('0123')
    assert 123.5 == Maybe.to_number('0123.5')
    assert 123 == Maybe.to_number('0123.0')
    assert [nil, :atom, "string"] == Maybe.to_number([nil, :atom, "string"])
  end

  test "to_atom" do
  	assert :"111" == Maybe.to_atom(111)
    assert :"0123.0" == Maybe.to_atom('0123.0')
    assert [nil, :atom, "string"] == Maybe.to_atom([nil, :atom, "string"])
  end

  test "maybe_to_string" do
  	assert "" == Maybe.maybe_to_string([])
  	assert "qwe" == Maybe.maybe_to_string(:qwe)
    assert [1232323232,22,43] == Maybe.maybe_to_string([1232323232,22,43])
    assert [nil, :atom, "string"] == Maybe.maybe_to_string([nil, :atom, "string"])
    assert "I am string" == Maybe.maybe_to_string('I am string')
	assert "1.033" == Maybe.maybe_to_string(1.033, %{decimals: 10}) |> Maybe.to_float |> Maybe.maybe_to_string(%{decimals: 10})
	assert "1.033" == Maybe.maybe_to_string(1.033, %{decimals: 3}) |> Maybe.to_float |> Maybe.maybe_to_string(%{decimals: 3})
	assert "1.03" == Maybe.maybe_to_string(1.033, %{decimals: 2}) |> Maybe.to_float |> Maybe.maybe_to_string(%{decimals: 2})
	assert "1" == Maybe.maybe_to_string(1.000, %{decimals: 3}) |> Maybe.to_float |> Maybe.maybe_to_string(%{decimals: 3})
	assert "-7" == Maybe.maybe_to_string(-7.000, %{decimals: 3}) |> Maybe.to_float |> Maybe.maybe_to_string(%{decimals: 3})
  end

  test "to_map" do
    assert %{} == Maybe.to_map([])
    assert %{we: "we", qwe: 1} == Maybe.to_map([qwe: 1, we: "we"])
    assert 1 == Maybe.to_map(1)
    assert 'azaza' == Maybe.to_map('azaza')
    assert [{"key", 123}] == Maybe.to_map([{"key", 123}])
  end

	defstruct [
		int: 123,
		float: 123.2,
		number: 11,
		string: "baz",
		atom: :qwe,
		map: %{1 => 2},
		boolean1: nil,
		boolean2: nil
	]

	test "to_struct" do
		assert %MaybeTest{} == Maybe.to_struct(%{},%MaybeTest{},%Maybe{})
		raw = %{int: :"1", float: :"1", number: "1", string: 3.3333333, atom: "we", map: [foo: 1], boolean1: 1, boolean2: 0}
		opts = %Maybe{
					to_integer: [:int],
					to_float: [:float],
					to_number: [:number],
					to_atom: [:atom],
					to_string: [:string],
					to_map: [:map],
					to_boolean: [:boolean1, :boolean2],
					decimals: 2
				}
		assert %MaybeTest{int: 1, float: 1.0, number: 1, string: "3.33", atom: :we, map: %{foo: 1}, boolean1: true, boolean2: false} == Maybe.to_struct(raw, %MaybeTest{}, opts)
	end

  test "to_boolean" do
    assert true == Maybe.to_boolean("true")
    assert false == Maybe.to_boolean("false") 
  end

end
