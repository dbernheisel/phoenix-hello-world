# Elixir

## Good resources
  * [Elixir School](http://elixirschool.com/lessons/basics/basics/)
  * [Phoenix Docs](http://www.phoenixframework.org/docs/overview)
  * [Elixir Docs](http://elixir-lang.org/getting-started/introduction.html)
  * [Elixir Koans](https://github.com/elixirkoans/elixir-koans)

## Install Elixir

```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash
echo '. $HOME/.asdf/asdf.sh' >> ~/.bash_profile # or .zprofile or .zshrc
# skip the next line if you're using ZSH. Autocompletion isn't supported from asdf until this pull request is merged: https://github.com/asdf-vm/asdf/pull/69/files
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bash_profile
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install erlang 18.0
asdf install elixir 1.3.0
asdf global erlang 18.0
asdf global elixir 1.3.0
mix local.hex
```

## Ruby to Elixir

| Operation               | Ruby                      | Elixir 
|:------------------------|:-------------------------:|:--------:
| Call methods            | `some_method(parameter)`  | `parameter |> some_method`
| String concat           | `"Hello " + "World"`      | `"Hello " <> "World"`
| Add to list             | `['some'] << 'list'`      | `['some'] ++ ['list']`
| module method on types  | `"some string".upcase`    | `String.upcase("some string")`
| Quoted strings          | Prefer single-quotes. Double-quotes for interpolation | double-quotes are UTF-8. single-quotes are not. Interpolation happens in both.


| Ruby                    | Elixir                    | Notes |
|:-----------------------:|:-------------------------:|:-------|
| Symbol                  | Atom                      | 
| String                  | String                    | Stored as binary in Elixir becuase it defaults to UTF-8
| Array                   | List                      | 
| Hash                    | Map                       | Hashes are ordered since Ruby 1.9. Maps are not ordered.
| `|` operator            | _doesn't exist_ but this works: `head, tail = some_array[0], some_array[1..-1]`          | Splits a list `[head|tail] = some_list`
| `module Something`      | `defmodule Something do`  | 
| `class Something`       | _doesn't exist_           | use defmodule instead.
| `def something`         | `def something do`        | 
| `private def something` | `defp something do`       | 
| `rake some_task`        | `mix some_task`           | 
| `gem`                   | _doesn't exist_           | gem is global. Mix is always in context to project. Hex.pm serves as RubyGems.org.
| Gemfile                 | mix.exs                   | 
| `bundle install`        | `mix deps.get`            | 
| `rails c`               | `iex -S mix`              | Elixir doesn't rely on the framework to provide contextual console


## Notes

  * **Tuple** - Stored all in memory at once and not meant to be iterated. Think of this as a type that's used for returns with multiple pieces of information, like `{ :error, "A more descriptive explanation" }`.

  * **List (Ruby Array)** - This is much like an Array in Ruby. Elixir's List is a O(n) operation (linear) that starts at the beginning of the list, so it's cheaper to prepend rather than append. Ruby's Array ``<<`` operator is an O(1) operation (constant), but otherwise is a O(n) operation.

  * **Keyword List** - Like an Array but with keys, but keys are not unique. Is an array of tuples with some extra sauce.

  * **Map (Ruby Hash)** - Maps are unordered, Hashes are ordered.

  * **= operator (Match)** - If unassigned variable is on left side, then it assigns. If the variable is on the right side then it acts like a comparison but raises an exception if the values don't match.
  ```elixir
  x = 1
  # => "1"
  1 = x
  # => "1"
  1 == x
  # => true
  2 = x
  # => "** (MatchError) no match of right hand side value: 1"
  ````

  It also supports pattern matching and destructuring. eg:
  ```elixir
  some_variable = "Dwight Schrute"
  # => "Dwight Schrute"
  {:a_key, another_variable} = {:a_key, some_variable}
  # => {:a_key, "Dwight Schrute"}
  another_variable
  # => "Dwight Schrute"
  {:b_key, another_variable} = {:a_key, some_variable}
  # => ** (MatchError) no match of right hand side value: {:a_key, "Dwight Schrute"}
  some_variable = "Jim Halpert"
  # => "Jim Halpert"
  some_variable == another_variable
  # => false
  ```

  * **Arity** - Methods can be routed to methods with the same name but with different arity (number of parameters they accept).
  
  ```elixir
  defmodule Greeter do
    def hello(name) do
      "Hello #{name}!"
    end

    def hello(name_one, name_two) do
      "Hello #{name_one} and #{name_two}!"
    end
  end

  Greeter.hello("Adam")
  # => "Hello Adam!"
  Greeter.hello("Andres", "Andrew")
  # => "Hello Andres and Andrew!"
  ```

  * **Guard** - Methods can have guards that route calls depending on the condition (eg parameter type).

  ```elixir
  defmodule Greeter do
    def hello(name) when is_binary(name) do
      phrase <> name <> "!"
    end

    def hello(names) when is_list(names) do
      names |> Enum.join(", ") |> hello
    end

    defp phrase, do: "Hello, "
  end

  Greeter.hello("Adam")
  # => "Hello, Adam!"
  Greeter.hello(["Andres", "Andrew"])
  # => "Hello Andres, Andrew!"
  Greeter.phrase
  # => ** (UndefinedFunctionError) function Greeter.phrase/0 is undefined or private
  ```

# Plug
Plug is like Rack in Ruby with a little Sinatra for handling APIs.
https://hexdocs.pm/plug


# Ecto
Ecto is like ActiveRecord in Ruby.
https://hexdocs.pm/ecto


# Phoenix
> "A productive web framework that does not compromise speed and maintainability."
https://hexdocs.pm/phoenix

## Install
  * Create project folder `mkdir elixir_example && cd elixir_example`
  * Install Phoenix `mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez`
  * Create Phoenix project `mix phoenix.new .`
  * Create database `mix ecto.create`. You may need to edit config/dev.exs and provide your real postgres server information.

## Live Reload && Performance
http://www.phoenixframework.org/docs/overview or https://vimeo.com/131633172
Video at 15:15-26:27

## Let's scaffold something
  * Start the server in a separate terminal session: `mix phoenix.server`
  * Create new model `mix phoenix.gen.html TrainingLunch training_lunches attendee:string date:datetime topic:string`
  * Put our new resource into the router `resources "/training_lunches", TrainingLunchController`
  * `mix ecto.migrate`
  * Check it out at http://localhost:4000
  * Whoops! I meant to make it presenter, not attendee; let's change that.
  * `mix ecto.gen.migration rename_attendee_to_presenter`
  * open migration file and put this into `change`: `rename table(:training_lunches), :attendee, to: :presenter`
  * `mix ecto.migrate`
  * Check it out at http://localhost:4000. Blows up. Nice error handling.
  * Edit files to replace `attendee` with `presenter`
  * Check it out at http://localhost:4000. Now it works.
  * Insert a seed by editing priv/repo/seeds.exs

    ```elixir
    Repo.insert! %ElixirExample.TrainingLunch{
      presenter: "David Bernheisel",
      topic: "Elixir/Phoenix",
      date: %Ecto.DateTime{
        year: 2016,
        month: 6,
        day: 26,
        hour: 12,
        min: 30,
        sec: 0}
      }
    }
    ```
