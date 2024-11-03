defmodule ElixirScriptSdkTest do
  use ExUnit.Case
  doctest ElixirScriptSdk

  test "greets the world" do
    assert ElixirScriptSdk.hello() == :world
  end
end
