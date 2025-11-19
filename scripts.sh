mix phx.new shop --database sqlite3

# We are almost there! The following steps are missing:

    $ cd shop

# Then configure your database in config/dev.exs and run:

    $ mix ecto.create

# Start your Phoenix app with:

    $ mix phx.server

# You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server

PS C:\elixir> cd shop
PS C:\elixir\shop> mix ecto.create
# Compiling 15 files (.ex)
# Generated shop app
# The database for Shop.Repo has been created

