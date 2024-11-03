defmodule ElixirScriptSdk do
  @moduledoc false

  use Dagger.Mod.Object, name: "ElixirScriptSdk"

  alias Dagger.{Client, ElixirSdk, Container, GeneratedCode}

  @script File.read!(Path.join([:code.priv_dir(:elixir_script_sdk), "templates", "main.exs"]))

  ## SDK implementation.

  defn required_paths() :: [String.t()] do
    []
  end

  defn module_runtime(mod_source: Dagger.ModuleSource.t(), introspection_json: Dagger.File.t()) ::
         Dagger.Container.t() do
    dag()
    |> Client.container()
  end

  defn codegen(mod_source: Dagger.ModuleSource.t(), introspection_json: Dagger.File.t()) ::
         Dagger.Container.t() do
    with {:ok, mod_name} <- Dagger.ModuleSource.module_name(mod_source),
         {:ok, sub_path} <- Dagger.ModuleSource.source_subpath(mod_source) do
      container =
        dag()
        |> Client.elixir_sdk()
        |> ElixirSdk.base(mod_source, sub_path)
        |> ElixirSdk.with_sdk(introspection_json)
        |> with_new_script(mod_name)

      dag()
      |> Client.generated_code(Container.directory(container, "/src"))
      |> GeneratedCode.with_vcs_generated_paths(["dagger_sdk/**"])
      |> GeneratedCode.with_vcs_ignored_paths(["dagger_sdk"])
    end
  end

  ## Helper functions

  defp with_new_script(elixir_sdk, mod_name) do
    script_name = Macro.underscore(mod_name)
    mod_name = Macro.camelize(mod_name)

    elixir_sdk
    |> ElixirSdk.container()
    |> Container.with_new_file(
      "/src/#{script_name}.exs",
      String.replace(@script, "ChangemeModule", mod_name)
    )
  end
end
