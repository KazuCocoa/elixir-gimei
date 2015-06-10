defmodule Gimei.Name do
  :application.start(:yamerl)
  @name_data Path.expand(Path.join(__DIR__, "../data/small_name.yml")) |> :yamerl_constr.file() |> List.first()

  @doc ~S"""
  Return List of name
  
  ## Examples

    iex> Gimei.Name.male(0)
    ["佐藤 愛斗", "さとう あいと", "サトウ アイト"]
  """
  @spec male :: list
  def male(number \\ -1) do
    generate_name("male", number)
  end

  @doc ~S"""
  Return List of name
  
  ## Examples

    iex> Gimei.Name.female(0)
    ["佐藤 藍斗", "さとう あいと", "サトウ アイト"]
  """
  @spec female :: list
  def female(number \\ -1) do
    generate_name("female", number)
  end


  defp generate_list(values) do
    Enum.reduce(values, [], fn (value, list) -> List.flatten(list, ["#{value}"]) end)
  end

  defp generate_name(gender, number \\ -1) do
    last = generate_list(last_name(@name_data, number))
    first = generate_list(first_name(@name_data, gender, number))

    Enum.reduce([0, 1, 2], [], fn (count, list) ->
      List.flatten(list, ["#{Enum.at(last, count)} #{Enum.at(first, count)}"])
    end)
  end

  defp first_name(data, gender, number \\ -1) do
    {_, names} = data
                 |> Enum.at(0)

    case gender do
      "male" -> {_, first_names} = List.keyfind(names, 'male', 0)
      "female" -> {_, first_names} = List.keyfind(names, 'female', 0)
      _ -> {gender, first_names} = Enum.at(names, 0)
    end

    case number do
      -1 -> random(first_names)
      _ -> Enum.at(first_names, number)
    end
  end

  defp last_name(data, number \\ -1) do
    {_, last_names} = data
             |> Enum.at(1)

    case number do
      -1 -> random(last_names)
      _ -> Enum.at(last_names, number)
    end
  end

  defp random(list) do
    list
    |> Enum.at(:crypto.rand_uniform(0, Enum.count(list)))
  end


end