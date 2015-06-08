defmodule GimeiTest do
  use ExUnit.Case, async: true

  test "return sample" do
    assert  Gimei.sample("neko") == "neko"
  end


  # memos: 以下の手順で実施可能
  # > a = :yamerl_constr.file("lib/data/small_addresses.yml")
  # > {addresses, values} = List.flatten(a) |> List.first()
  # > {city, cities} = List.keyfind(values, 'city', 0)


  # > {key, value} = List.flatten(a) |> List.first(v) |> Enum.each(fn x -> IO.puts("#{x} is word") end)

  # > List.first(cities) |> Enum.each(&IO.puts("#{&1} is words"))
  # 島尻郡久米島町 is words
  # しまじりぐんくめじまちょう is words
  # シマジリグンクメジマチョウ is words

  # > Enum.each(cities, &IO.puts("#{&1} is words"))
  # 島尻郡久米島町しまじりぐんくめじまちょうシマジリグンクメジマチョウ is words
  # 島尻郡八重瀬町しまじりぐんやえせちょうシマジリグンヤエセチョウ is words
  # 宮古郡多良間村みやこぐんたらまそんミヤコグンタラマソン is words
  # 八重山郡竹富町やえやまぐんたけとみちょうヤエヤマグンタケトミチョウ is words
  # 八重山郡与那国町やえやまぐんよなぐにちょうヤエヤマグンヨナグニチョウ is words
  # :ok

  # > Enum.at(cities, 1) |> Enum.at(0) |> IO.puts
  # 島尻郡八重瀬町
  # :ok
end
