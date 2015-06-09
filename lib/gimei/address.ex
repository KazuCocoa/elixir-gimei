defmodule Gimei.Address do

  @data_path Path.expand(Path.join(__DIR__, "../data/small_addresses.yml"))

  @doc ~S"""
  Return list of prefecture.

  ## Examples

      iex> Gimei.Address.prefecture()
      ["青森県", "あおもりけん", "アオモリケン"]
  """
  @spec prefecture() :: list
  def prefecture do
    generate_list(address("prefecture"))
  end

  @doc ~S"""
  Return list of city.

  ## Examples

      iex> Gimei.Address.city()
      ["島尻郡八重瀬町", "しまじりぐんやえせちょう", "シマジリグンヤエセチョウ"]
  """
  @spec city() :: list
  def city do
    generate_list(address("city"))
  end

  @doc ~S"""
  Return list of town.

  ## Examples

      iex> Gimei.Address.town()
      ["亀尾町", "かめおちょう", "カメオチョウ"]
  """
  @spec town() :: list
  def town do
    generate_list(address("town"))
  end


  defp generate_list(values) do
    Enum.reduce(values, [], fn (value, list) -> List.flatten(list, ["#{value}"]) end)
  end

  defp addresses_from_yaml do
    {_, values} = List.flatten(:yamerl_constr.file(@data_path))
                  |> Enum.at(0)
    values
  end

  defp address(target) do
    parsed_yaml = addresses_from_yaml
    case target do
      "prefecture" -> {_, value} = List.keyfind(parsed_yaml, 'prefecture', 0)
      "city"       -> {_, value} = List.keyfind(parsed_yaml, 'city', 0)
      "town"       -> {_, value} = List.keyfind(parsed_yaml, 'town', 0)
    end
    Enum.at(value, 1)
  end
end