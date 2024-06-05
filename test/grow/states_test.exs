defmodule Grow.StatesTest do
  use Grow.DataCase

  alias Grow.States

  describe "states" do
    alias Grow.States.State

    import Grow.StatesFixtures

    @invalid_attrs %{active: nil, name: nil, pin: nil}

    test "list_states/0 returns all states" do
      state = state_fixture()
      assert States.list_states() == [state]
    end

    test "get_state!/1 returns the state with given id" do
      state = state_fixture()
      assert States.get_state!(state.id) == state
    end

    test "create_state/1 with valid data creates a state" do
      valid_attrs = %{active: true, name: "some name", pin: 42}

      assert {:ok, %State{} = state} = States.create_state(valid_attrs)
      assert state.active == true
      assert state.name == "some name"
      assert state.pin == 42
    end

    test "create_state/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = States.create_state(@invalid_attrs)
    end

    test "update_state/2 with valid data updates the state" do
      state = state_fixture()
      update_attrs = %{active: false, name: "some updated name", pin: 43}

      assert {:ok, %State{} = state} = States.update_state(state, update_attrs)
      assert state.active == false
      assert state.name == "some updated name"
      assert state.pin == 43
    end

    test "update_state/2 with invalid data returns error changeset" do
      state = state_fixture()
      assert {:error, %Ecto.Changeset{}} = States.update_state(state, @invalid_attrs)
      assert state == States.get_state!(state.id)
    end

    test "delete_state/1 deletes the state" do
      state = state_fixture()
      assert {:ok, %State{}} = States.delete_state(state)
      assert_raise Ecto.NoResultsError, fn -> States.get_state!(state.id) end
    end

    test "change_state/1 returns a state changeset" do
      state = state_fixture()
      assert %Ecto.Changeset{} = States.change_state(state)
    end
  end
end
