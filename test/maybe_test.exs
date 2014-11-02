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
    assert "123 qwe" == Maybe.to_float("123 qwe")
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
  end

  test "to_atom" do
  	assert :"111" == Maybe.to_atom(111)
  end

  test "maybe_to_string" do
  	assert [] == Maybe.maybe_to_string([])
  	assert "qwe" == Maybe.maybe_to_string(:qwe)
  end


end