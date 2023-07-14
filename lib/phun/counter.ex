defmodule Phun.Counter do
  defstruct [:count]
  
  def new(string \\ "0") do
    %__MODULE__{count: String.to_integer(string)}
  end

  def inc(%__MODULE__{count: count} = counter, by \\ 1) do
    %{counter | count: count + by}
  end

  def show(counter) do
    counter.count
  end
end
