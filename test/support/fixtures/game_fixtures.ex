defmodule Phun.GameFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Phun.Game` context.
  """

  @doc """
  Generate a puzzle.
  """
  def puzzle_fixture(attrs \\ %{}) do
    {:ok, puzzle} =
      attrs
      |> Enum.into(%{
        name: "some name",
        width: 42,
        height: 42
      })
      |> Phun.Game.create_puzzle()

    puzzle
  end
end
