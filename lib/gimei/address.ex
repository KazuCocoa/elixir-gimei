defmodule Gimei.Address do
  :application.start(:yamerl)
  @address_data Path.expand(Path.join(__DIR__, "../data/small_addresses.yml")) |> :yamerl_constr.file() |> List.first()

  @doc ~S"""
  Return list of prefecture.

  ## Examples

      iex> Gimei.Address.prefecture(1)
      ["青森県", "あおもりけん", "アオモリケン"]
  """
  @spec prefecture :: list
  def prefecture(number \\ -1) do
    generate_list(gran_address("prefecture", number))
  end

  @doc ~S"""
  Return list of city.

  ## Examples

      iex> Gimei.Address.city(1)
      ["島尻郡八重瀬町", "しまじりぐんやえせちょう", "シマジリグンヤエセチョウ"]
  """
  @spec city :: list
  def city(number \\ -1) do
    generate_list(gran_address("city", number))
  end

  @doc ~S"""
  Return list of town.

  ## Examples

      iex> Gimei.Address.town(1)
      ["亀尾町", "かめおちょう", "カメオチョウ"]
  """
  @spec town :: list
  def town(number \\ -1) do
    generate_list(gran_address("town", number))
  end

  @doc ~S"""
  Return list of address.

  ## Examples

      iex> Gimei.Address.address(1)
      ["青森県島尻郡八重瀬町亀尾町",
      "あおもりけんしまじりぐんやえせちょうかめおちょう",
      "アオモリケンシマジリグンヤエセチョウカメオチョウ"]
  """
  @spec address :: list
  def address(number \\ -1) do
    prefecture = generate_list(gran_address("prefecture", number))
    city = generate_list(gran_address("city", number))
    town = generate_list(gran_address("town", number))

    Enum.reduce([0, 1, 2], [], fn (count, list) ->
      List.flatten(list, ["#{Enum.at(prefecture, count) <> Enum.at(city, count) <> Enum.at(town, count)}"])
    end)
  end


  defp generate_list(values) do
    Enum.reduce(values, [], fn (value, list) -> List.flatten(list, ["#{value}"]) end)
  end

  defp gran_address(target, number \\ -1) do
    {_, parsed_yaml} = @address_data
                       |> Enum.at(0)
    case target do
      "prefecture" -> {_, values} = List.keyfind(parsed_yaml, 'prefecture', 0)
      "city"       -> {_, values} = List.keyfind(parsed_yaml, 'city', 0)
      "town"       -> {_, values} = List.keyfind(parsed_yaml, 'town', 0)
    end

    case number do
      -1 -> random(values)
      _ -> Enum.at(values, number)
    end
  end

  defp random(list) do
    list
    |> Enum.at(:crypto.rand_uniform(0, Enum.count(list)))
  end
end