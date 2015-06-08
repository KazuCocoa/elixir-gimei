defmodule Gimei.Name do

  @data_path Path.expand(Path.join(__DIR__, "../data/small_name.yml"))

  @spec kanji() :: {:ok, String.t}
  def kanji do
    IO.puts("#{last_name()}" <> "#{first_name("male")}")
  end

  defp first_name(gender) do
    {_, values} = List.flatten(:yamerl_constr.file(@data_path)) |> Enum.at(0)
    case gender do
      "male" -> {_, first_names} = List.keyfind(values, 'male', 0)
      "female" -> {_, first_names} = List.keyfind(values, 'female', 0)
      _ -> {gender, first_names} = Enum.at(values, 0)
    end

    Enum.at(first_names, 0) |> Enum.at(0)
  end

  defp last_name do
    {_, last_names} = List.flatten(:yamerl_constr.file(@data_path)) |> Enum.at(1)
    Enum.at(last_names, 0) |> Enum.at(0)
  end

end