defmodule Shop.Repo do
  use Ecto.Repo,
    otp_app: :shop,
    adapter: Ecto.Adapters.SQLite3

  # To interact with database, we use `Shop.Repo` like insertion, update, deletion etc.

  ## 👉 So this Repo is like repository to handle the databases.

end


# iex(7)> Shop.Repo.all(Shop.Product)
# [debug] QUERY OK source="products" db=6.9ms decode=6.8ms queue=0.1ms idle=1782.8ms
# SELECT p0."id", p0."name", p0."slug", p0."console", p0."inserted_at", p0."updated_at" FROM "products" AS p0 []
# ↳ :elixir.eval_external_handler/3, at: src/elixir.erl:386
# []

# iex(8)> product = %Product{name: "Overwatch 2", slug: "overwatch-2", console: :pc}
# %Shop.Product{
#   __meta__: #Ecto.Schema.Metadata<:built, "products">,
#   id: nil,
#   name: "Overwatch 2",
#   slug: "overwatch-2",
#   console: :pc,
#   inserted_at: nil,
#   updated_at: nil
# }
# iex(9)> alias Shop.Repo
# Shop.Repo
# iex(10)> alias Shop.Product
# Shop.Product
# iex(11)> Repo.insert(product)
# [debug] QUERY OK source="products" db=3.5ms queue=0.1ms idle=1233.6ms
# INSERT INTO "products" ("name","console","slug","inserted_at","updated_at") VALUES (?1,?2,?3,?4,?5) RETURNING "id" ["Overwatch 2", :pc, "overwatch-2", ~U[2025-08-13 10:28:14Z], ~U[2025-08-13 10:28:14Z]]
# ↳ :elixir.eval_external_handler/3, at: src/elixir.erl:386
# {:ok,
#  %Shop.Product{
#    __meta__: #Ecto.Schema.Metadata<:loaded, "products">,
#    id: 1,
#    name: "Overwatch 2",
#    slug: "overwatch-2",
#    console: :pc,
#    inserted_at: ~U[2025-08-13 10:28:14Z],
#    updated_at: ~U[2025-08-13 10:28:14Z]
#  }}
# iex(12)>
# 👉 Since :ok means worked.
# iex(12)> Repo.all(Product)
# [debug] QUERY OK source="products" db=1.0ms queue=0.1ms idle=1488.9ms
# SELECT p0."id", p0."name", p0."slug", p0."console", p0."inserted_at", p0."updated_at" FROM "products" AS p0 []
# ↳ :elixir.eval_external_handler/3, at: src/elixir.erl:386
# [
#   %Shop.Product{
#     __meta__: #Ecto.Schema.Metadata<:loaded, "products">,
#     id: 1,
#     name: "Overwatch 2",
#     slug: "overwatch-2",
#     console: :pc,
#     inserted_at: ~U[2025-08-13 10:28:14Z],
#     updated_at: ~U[2025-08-13 10:28:14Z]
#   }
# ]

## 
