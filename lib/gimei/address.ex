defmodule Gimei.Address do
  :application.start(:yamerl)
  @address_data Path.expand(Path.join(__DIR__, "../data/small_addresses.yml")) |> :yamerl_constr.file() |> List.first()

  @doc ~S"""
  Return list of prefecture.

  ## Examples

      iex> Gimei.Address.prefecture
      ["青森県", "あおもりけん", "アオモリケン"]
  """
  @spec prefecture :: list
  def prefecture do
    generate_list(address("prefecture"))
  end

  @doc ~S"""
  Return list of city.

  ## Examples

      iex> Gimei.Address.city
      ["島尻郡八重瀬町", "しまじりぐんやえせちょう", "シマジリグンヤエセチョウ"]
  """
  @spec city :: list
  def city do
    generate_list(address("city"))
  end

  @doc ~S"""
  Return list of town.

  ## Examples

      iex> Gimei.Address.town
      ["亀尾町", "かめおちょう", "カメオチョウ"]
  """
  @spec town :: list
  def town do
    generate_list(address("town"))
  end

  @doc ~S"""
  Return list of address.

  ## Examples

      iex> Gimei.Address.address
      ["青森県島尻郡八重瀬町亀尾町",
      "あおもりけんしまじりぐんやえせちょうかめおちょう",
      "アオモリケンシマジリグンヤエセチョウカメオチョウ"]
  """
  @spec address :: list
  def address do
    prefecture = generate_list(address("prefecture"))
    city = generate_list(address("city"))
    town = generate_list(address("town"))

    Enum.reduce([0, 1, 2], [], fn (count, list) ->
      List.flatten(list, ["#{Enum.at(prefecture, count) <> Enum.at(city, count) <> Enum.at(town, count)}"])
    end)
  end


  defp generate_list(values) do
    Enum.reduce(values, [], fn (value, list) -> List.flatten(list, ["#{value}"]) end)
  end

  defp address(target) do
    {_, parsed_yaml} = @address_data
                       |> Enum.at(0)
    case target do
      "prefecture" -> {_, value} = List.keyfind(parsed_yaml, 'prefecture', 0)
      "city"       -> {_, value} = List.keyfind(parsed_yaml, 'city', 0)
      "town"       -> {_, value} = List.keyfind(parsed_yaml, 'town', 0)
    end
    Enum.at(value, 1)
  end

  defp get_random_item(list, list_count) do
    list
    |> Enum.at(:crypto.rand_uniform(0, list_count))
    |> Enum.map fn(item) -> List.to_string(item) end
  end
end