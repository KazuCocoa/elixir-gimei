defmodule Gimei.Address do

  @data_path Path.expand(Path.join(__DIR__, "../data/small_addresses.yml"))

  @spec kanji() :: {:ok, String.t}
  def kanji do
    IO.puts city()
  end

  defp city() do
    {_, values} = List.flatten(:yamerl_constr.file(@data_path)) |> Enum.at(0)
    {_, cities} = List.keyfind(values, 'city', 0)
    Enum.at(cities, 1) |> Enum.at(0)
  end
end