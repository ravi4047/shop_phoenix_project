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



echo "# shop_phoenix_project" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/ravi4047/shop_phoenix_project.git
git push -u origin main


$ mix format # updates to the latest formatting rules. It was used for new Heex curly braces syntax

$ mix phx.gen.Schema Product products name:string slug:string:unique console:enum:pc:ps5:xbox description:text price:decimal stock:integer available:boolean released_at:naive_datetime

# It generates schema and migration file for products table with specified fields.

$ mix phx.gen.schema Product products name:string slug:string:unique description:text price:decimal stock:integer available:boolean released_at:naive_datetime

$ mix phx.gen.html Catalog Product products name:string slug:string:unique description:text price:decimal stock:integer available:boolean released_at:naive_datetime


$ mix ecto.migrate

$ mix ecto.drop

# products = Repo.all(Product) ## 👉👉 Don't call the Repo directly from controller. Use contexts.
# Controller is part of web layer, whereas Repo is part of data layer.
# Instead, use the context module to interact with the data layer.
# E.g., use Products.list_products() to fetch all products.


# To create schema using mix
mix phx.gen.schema Consoles Console consoles name:string price:integer
# First is Consoles - context module name (tutor likes plural here)
# Second is Console - schema module name
# Third is consoles - table name in plural
# Tests, fixtures, and migration files are also generated.

# To run the migration
mix ecto.migrate

# To rollback the last migration
mix ecto.rollback



# Promotions
mix phx.gen.json Promotions Promotion promotions name:string code:string:unique
mix ecto.migrate
# There is a fallback controller to handle errors in case a promotion is not found or else.


# Authentication
mix phx.gen.auth Accounts User users 
# This asks to choose view. Live-views default one or controller based one.
# Live-view gives a good user experience.
mix deps.get # to fetch the dependencies # bcrypt_elixir

# By default it's 12 rounds
# For test, we are changing to 1 round in config/test.exs

# In testing, conn_case.ex is for controller tests and data_case.ex is for data layer tests (i.e. contexts)


mix test # runs all tests

# For testing folder
mix test test/shop_web

# For testing a single file
mix test test/shop_web/controllers/promotion_controller_test.exs