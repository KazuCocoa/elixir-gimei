defmodule Gimei.Address do
  :application.start(:yamerl)
  @address_data Path.expand(Path.join(__DIR__, "../data/addresses.yml")) |> :yamerl_constr.file() |> List.first()

  @doc ~S"""
  Return list of prefecture.

  ## Examples

      iex> Gimei.Address.prefecture(1)
      ["青森県", "あおもりけん", "アオモリケン"]
  """
  @spec prefecture(integer) :: list
  def prefecture(number \\ -1), do: generate_list(gran_address("prefecture", number))

  @doc ~S"""
  Return list of city.

  ## Examples

      iex> Gimei.Address.city(1)
      ["札幌市北区", "さっぽろしきたく",
            "サッポロシキタク"]
  """
  @spec city(integer) :: list
  def city(number \\ -1), do: generate_list(gran_address("city", number))

  @doc ~S"""
  Return list of town.

  ## Examples

      iex> Gimei.Address.town(1)
      ["亀尾町", "かめおちょう", "カメオチョウ"]
  """
  @spec town(integer) :: list
  def town(number \\ -1), do: generate_list(gran_address("town", number))

  @doc ~S"""
  Return list of address.

  ## Examples

      iex> Gimei.Address.address(1)
      ["青森県札幌市北区亀尾町",
            "あおもりけんさっぽろしきたくかめおちょう",
            "アオモリケンサッポロシキタクカメオチョウ"]
  """
  @spec address(integer) :: list
  def address(number \\ -1) do
    prefecture = generate_list(gran_address("prefecture", number))
    city = generate_list(gran_address("city", number))
    town = generate_list(gran_address("town", number))

    Enum.reduce([0, 1, 2], [], fn (count, acc) ->
      acc
      |> List.flatten(["#{Enum.at(prefecture, count) <> Enum.at(city, count) <> Enum.at(town, count)}"])
    end)
  end

  defp generate_list(values), do: values |> Enum.reduce([], fn (value, list) -> List.flatten(list, ["#{value}"]) end)

  defp gran_address(target, number \\ -1) do
    {_, parsed_yaml} = @address_data
                       |> Enum.at(0)
    case target do
      "prefecture" -> {_, values} = List.keyfind(parsed_yaml, 'prefecture', 0)
      "city"       -> {_, values} = List.keyfind(parsed_yaml, 'city', 0)
      "town"       -> {_, values} = List.keyfind(parsed_yaml, 'town', 0)
    end

    case number do
      x when x >= 0 -> Enum.at(values, number)
      _             -> random(values)
    end
  end

  defp random(list), do: list |> Enum.at(:crypto.rand_uniform(0, Enum.count(list)))
end
