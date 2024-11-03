Mix.install([{:dagger, path: "./dagger_sdk"}])

defmodule ChangemeModule do
  use Dagger.Mod.Object, name: "ChangemeModule"

  defn container_echo(string_arg: String.t()) :: Dagger.Container.t() do
    dag()
    |> Dagger.Client.container()
    |> Dagger.Container.from("alpine")
    |> Dagger.Container.with_exec(~w"echo hello")
  end
end

Dagger.Mod.invoke(ChangemeModule)
