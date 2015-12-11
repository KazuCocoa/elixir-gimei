defmodule Gimei.Name do
  :application.start(:yamerl)
  @name_data Path.expand(Path.join(__DIR__, "../data/names.yml")) |> :yamerl_constr.file() |> List.first()

  @doc ~S"""
  Return List of name

  ## Examples

    iex> Gimei.Name.male(0)
    ["佐藤 愛斗", "さとう あいと", "サトウ アイト"]
  """
  @spec male(integer) :: list
  def male(number \\ -1), do: generate_name("male", number)

  @doc ~S"""
  Return List of name

  ## Examples

    iex> Gimei.Name.female(0)
    ["佐藤 阿愛", "さとう ああい", "サトウ アアイ"]
  """
  @spec female(integer) :: list
  def female(number \\ -1), do: generate_name("female", number)

  defp generate_list(values), do: values |> Enum.reduce([], fn (value, list) -> List.flatten(list, ["#{value}"]) end)

  defp generate_name(gender, number \\ -1) do
    last = generate_list(last_name(@name_data, number))
    first = generate_list(first_name(@name_data, gender, number))

    Enum.reduce([0, 1, 2], [], fn (count, acc) ->
      acc
      |> List.flatten(["#{Enum.at(last, count)} #{Enum.at(first, count)}"])
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
      x when x >= 0 -> Enum.at(first_names, number)
      _             -> random(first_names)
    end
  end

  defp last_name(data, number \\ -1) do
    {_, last_names} = data
             |> Enum.at(1)

    case number do
      x when x >= 0 -> Enum.at(last_names, number)
      _             -> random(last_names)
    end
  end

  defp random(list), do: list |> Enum.at(:crypto.rand_uniform(0, Enum.count(list)))
end
