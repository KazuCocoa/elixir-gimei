defmodule GimeiTest do
  use ExUnit.Case, async: true

  test "return sample" do
    assert  Gimei.sample("neko") == "neko"
  end
end
