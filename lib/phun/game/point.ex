defmodule Phun.Game.Point do
  use Ecto.Schema
  import Ecto.Changeset
  alias Phun.Game.Puzzle

  schema "points" do
    field :y, :integer
    field :x, :integer
    belongs_to :puzzle, Puzzle

    timestamps()
  end

  @doc false
  def changeset(point, attrs) do
    point
    |> cast(attrs, [:x, :y, :alive])
    |> validate_required([:x, :y, :alive])
  end
end
