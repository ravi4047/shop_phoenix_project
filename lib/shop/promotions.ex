defmodule Shop.Promotions do
  @moduledoc """
  The Promotions context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Promotions.Promotion

  @doc """
  Returns the list of promotions.

  ## Examples

      iex> list_promotions()
      [%Promotion{}, ...]

  """
  def list_promotions do
    Repo.all(Promotion)
  end

  @doc """
  Gets a single promotion.

  Raises `Ecto.NoResultsError` if the Promotion does not exist.

  ## Examples

      iex> get_promotion!(123)
      %Promotion{}

      iex> get_promotion!(456)
      ** (Ecto.NoResultsError)

  """
  def get_promotion!(id), do: Repo.get!(Promotion, id)

  @doc """
  Creates a promotion.

  ## Examples

      iex> create_promotion(%{field: value})
      {:ok, %Promotion{}}

      iex> create_promotion(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_promotion(attrs) do
    %Promotion{}
    |> Promotion.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a promotion.

  ## Examples

      iex> update_promotion(promotion, %{field: new_value})
      {:ok, %Promotion{}}

      iex> update_promotion(promotion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_promotion(%Promotion{} = promotion, attrs) do
    promotion
    |> Promotion.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a promotion.

  ## Examples

      iex> delete_promotion(promotion)
      {:ok, %Promotion{}}

      iex> delete_promotion(promotion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_promotion(%Promotion{} = promotion) do
    Repo.delete(promotion)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking promotion changes.

  ## Examples

      iex> change_promotion(promotion)
      %Ecto.Changeset{data: %Promotion{}}

  """
  def change_promotion(%Promotion{} = promotion, attrs \\ %{}) do
    Promotion.changeset(promotion, attrs)
  end

  alias Shop.Promotions.Promotion
  alias Shop.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any promotion changes.

  The broadcasted messages match the pattern:

    * {:created, %Promotion{}}
    * {:updated, %Promotion{}}
    * {:deleted, %Promotion{}}

  """
  def subscribe_promotions(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Shop.PubSub, "user:#{key}:promotions")
  end

  defp broadcast(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Shop.PubSub, "user:#{key}:promotions", message)
  end

  @doc """
  Returns the list of promotions.

  ## Examples

      iex> list_promotions(scope)
      [%Promotion{}, ...]

  """
  def list_promotions(%Scope{} = scope) do
    Repo.all_by(Promotion, user_id: scope.user.id)
  end

  @doc """
  Gets a single promotion.

  Raises `Ecto.NoResultsError` if the Promotion does not exist.

  ## Examples

      iex> get_promotion!(scope, 123)
      %Promotion{}

      iex> get_promotion!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_promotion!(%Scope{} = scope, id) do
    Repo.get_by!(Promotion, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a promotion.

  ## Examples

      iex> create_promotion(scope, %{field: value})
      {:ok, %Promotion{}}

      iex> create_promotion(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_promotion(%Scope{} = scope, attrs) do
    with {:ok, promotion = %Promotion{}} <-
           %Promotion{}
           |> Promotion.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast(scope, {:created, promotion})
      {:ok, promotion}
    end
  end

  @doc """
  Updates a promotion.

  ## Examples

      iex> update_promotion(scope, promotion, %{field: new_value})
      {:ok, %Promotion{}}

      iex> update_promotion(scope, promotion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_promotion(%Scope{} = scope, %Promotion{} = promotion, attrs) do
    true = promotion.user_id == scope.user.id

    with {:ok, promotion = %Promotion{}} <-
           promotion
           |> Promotion.changeset(attrs, scope)
           |> Repo.update() do
      broadcast(scope, {:updated, promotion})
      {:ok, promotion}
    end
  end

  @doc """
  Deletes a promotion.

  ## Examples

      iex> delete_promotion(scope, promotion)
      {:ok, %Promotion{}}

      iex> delete_promotion(scope, promotion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_promotion(%Scope{} = scope, %Promotion{} = promotion) do
    true = promotion.user_id == scope.user.id

    with {:ok, promotion = %Promotion{}} <-
           Repo.delete(promotion) do
      broadcast(scope, {:deleted, promotion})
      {:ok, promotion}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking promotion changes.

  ## Examples

      iex> change_promotion(scope, promotion)
      %Ecto.Changeset{data: %Promotion{}}

  """
  # def change_promotion(%Scope{} = scope, %Promotion{} = promotion, attrs \\ %{}) do
  #   true = promotion.user_id == scope.user.id

  #   Promotion.changeset(promotion, attrs, scope)
  # end
end
