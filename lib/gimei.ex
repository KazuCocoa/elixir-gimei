defmodule Gimei do

  @moduledoc """
  Gimei is a pure Elixir library for Japanese fake data.
  """

  @doc """
  Start Gimei.
  """
  @spec start() :: :ok
  def start do
    :application.start(:gimei)
  end

  @spec sample(String.t) :: String.t
  def sample(string) do
    string
  end
end
