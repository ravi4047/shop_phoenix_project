defmodule Shop.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name, :slug, :console]}
  schema "products" do
    field :name, :string
    field :slug, :string
    field :console, Ecto.Enum, values: [:pc, :xbox, :nintendo, :playstation]

    timestamps(type: :utc_datetime)
  end

  ## Three fields are already created. Two more fields `created_at` and `updated_at` and done at
  ## timestamps.
  # One more field id is also created.

### 👉👉👉
#   iex(1)> game = %Shop.Product{name: "Diablo 4", slug: "diablo-4", console: "pc"}
# %Shop.Product{
#   __meta__: #Ecto.Schema.Metadata<:built, "products">,
#   id: nil,
#   name: "Diablo 4",
#   slug: "diablo-4",
#   console: "pc",
#   inserted_at: nil,
#   updated_at: nil
# }

# 👉 Changeset is a function which runs before we interact with the database.
# I mean it prevents the user from passing any wrong values. I mean a constraint or a validation

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :console]) # cast checks the fields and types
    |> validate_required([:name, :console]) # as name tells
    |> validate_length(:name, min: 3)
    |> format_name()
    |> generate_slug()
    |> unique_constraint(:slug) # check the unique constraint.
    ## Me doubt in unique constraint? Does it checks the whole database to check uniqueness or what??

    # 👉👉👉 After changing the changeset, just do $ recompile
  end

# iex(3)> changeset = Product.changeset(%Product{}, %{name: "Diablo 4"})
# #Ecto.Changeset<
#   action: nil,
#   changes: %{name: "Diablo 4"},
#   errors: [
#     slug: {"can't be blank", [validation: :required]},
#     console: {"can't be blank", [validation: :required]}
#   ],
#   data: #Shop.Product<>,
#   valid?: false,
#   ...
# >
# iex(4)> changeset.valid?
# false
# iex(5)> changeset.changes
# %{name: "Diablo 4"}
# changeset.changes are the maps which you want to change.

  defp format_name(changeset) do
    name = changeset.changes.name
    |> String.trim()

    put_change(changeset, :name, name) # 👉 Returns the changeset
  end

  defp generate_slug(changeset) do
    slug =
      changeset.changes.name
      |> String.downcase()
      |> String.replace(" ", "-")

    put_change(changeset, :slug, slug)
  end
end
