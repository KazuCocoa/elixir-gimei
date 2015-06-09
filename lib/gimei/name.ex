defmodule Gimei.Name do
  :application.start(:yamerl)
  @name_data Path.expand(Path.join(__DIR__, "../data/small_name.yml")) |> :yamerl_constr.file() |> List.first()

  @doc ~S"""
  Return List of name
  
  ## Examples

    iex> Gimei.Name.male
    ["林 愛斗", "はやし あいと", "ハヤシ アイト"]
  """
  @spec male :: list
  def male do
    generate_name("male")
  end

  @doc ~S"""
  Return List of name
  
  ## Examples

    iex> Gimei.Name.female
    ["林 藍斗", "はやし あいと", "ハヤシ アイト"]
  """
  @spec female :: list
  def female do
    generate_name("female")
  end


  defp generate_list(values) do
    Enum.reduce(values, [], fn (value, list) -> List.flatten(list, ["#{value}"]) end)
  end

  defp generate_name(gender) do
    last = generate_list(last_name(@name_data))
    first = generate_list(first_name(@name_data, gender))

    Enum.reduce([0, 1, 2], [], fn (count, list) ->
      List.flatten(list, ["#{Enum.at(last, count)} #{Enum.at(first, count)}"])
    end)
  end

  defp first_name(data, gender) do
    {_, names} = data
                 |> Enum.at(0)

    case gender do
      "male" -> {_, first_names} = List.keyfind(names, 'male', 0)
      "female" -> {_, first_names} = List.keyfind(names, 'female', 0)
      _ -> {gender, first_names} = Enum.at(names, 0)
    end

    Enum.at(first_names, 0)
  end

  defp last_name(data) do
    {_, last_name} = data
             |> Enum.at(1)

    Enum.at(last_name, 1)
  end

end