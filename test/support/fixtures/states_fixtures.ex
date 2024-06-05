defmodule Grow.StatesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grow.States` context.
  """

  @doc """
  Generate a state.
  """
  def state_fixture(attrs \\ %{}) do
    {:ok, state} =
      attrs
      |> Enum.into(%{
        active: true,
        name: "some name",
        pin: 42
      })
      |> Grow.States.create_state()

    state
  end
end
