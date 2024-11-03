# ElixirScriptSdk

The exploration on how to build [single-file module in Dagger](https://github.com/dagger/dagger/issues/8808) 
by extending the Dagger Elixir SDK.

## How to use

Initialize the module by using this module instead:

```shell
$ dagger init --sdk=github.com/wingyplus/elixir-script-sdk potato
```

Once initialized, you will the `potato` directory that contains Elixir script, `dagger.json` and git ignore files stuff.

After that, it can be run a module by using `dagger call`. The bootstrap module has a
`container-echo` function to call like other SDK has.
