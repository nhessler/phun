defmodule Phun.Counter do

  def new(string \\ "0") do
    String.to_integer(string)
  end

  def inc(count, by \\ 1) do
    count + by
  end

  def dec(count, by \\ 1) do
    count - by
  end

  def show(count) do
    count
  end
end
