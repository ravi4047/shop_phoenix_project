defmodule Shop.PromotionsTest do
  use Shop.DataCase

  alias Shop.Promotions

  describe "promotions" do
    alias Shop.Promotions.Promotion

    import Shop.PromotionsFixtures

    @invalid_attrs %{code: nil, name: nil, expires_at: nil}

    test "list_promotions/0 returns all promotions" do
      promotion = promotion_fixture()
      assert Promotions.list_promotions() == [promotion]
    end

    test "get_promotion!/1 returns the promotion with given id" do
      promotion = promotion_fixture()
      assert Promotions.get_promotion!(promotion.id) == promotion
    end

    test "create_promotion/1 with valid data creates a promotion" do
      valid_attrs = %{code: "some code", name: "some name", expires_at: ~U[2025-08-12 21:56:00Z]}

      assert {:ok, %Promotion{} = promotion} = Promotions.create_promotion(valid_attrs)
      assert promotion.code == "some code"
      assert promotion.name == "some name"
      assert promotion.expires_at == ~U[2025-08-12 21:56:00Z]
    end

    test "create_promotion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Promotions.create_promotion(@invalid_attrs)
    end

    test "update_promotion/2 with valid data updates the promotion" do
      promotion = promotion_fixture()
      update_attrs = %{code: "some updated code", name: "some updated name", expires_at: ~U[2025-08-13 21:56:00Z]}

      assert {:ok, %Promotion{} = promotion} = Promotions.update_promotion(promotion, update_attrs)
      assert promotion.code == "some updated code"
      assert promotion.name == "some updated name"
      assert promotion.expires_at == ~U[2025-08-13 21:56:00Z]
    end

    test "update_promotion/2 with invalid data returns error changeset" do
      promotion = promotion_fixture()
      assert {:error, %Ecto.Changeset{}} = Promotions.update_promotion(promotion, @invalid_attrs)
      assert promotion == Promotions.get_promotion!(promotion.id)
    end

    test "delete_promotion/1 deletes the promotion" do
      promotion = promotion_fixture()
      assert {:ok, %Promotion{}} = Promotions.delete_promotion(promotion)
      assert_raise Ecto.NoResultsError, fn -> Promotions.get_promotion!(promotion.id) end
    end

    test "change_promotion/1 returns a promotion changeset" do
      promotion = promotion_fixture()
      assert %Ecto.Changeset{} = Promotions.change_promotion(promotion)
    end
  end

  describe "promotions" do
    alias Shop.Promotions.Promotion

    import Shop.AccountsFixtures, only: [user_scope_fixture: 0]
    import Shop.PromotionsFixtures

    @invalid_attrs %{code: nil, name: nil}

    test "list_promotions/1 returns all scoped promotions" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      promotion = promotion_fixture(scope)
      other_promotion = promotion_fixture(other_scope)
      assert Promotions.list_promotions(scope) == [promotion]
      assert Promotions.list_promotions(other_scope) == [other_promotion]
    end

    test "get_promotion!/2 returns the promotion with given id" do
      scope = user_scope_fixture()
      promotion = promotion_fixture(scope)
      other_scope = user_scope_fixture()
      assert Promotions.get_promotion!(scope, promotion.id) == promotion
      assert_raise Ecto.NoResultsError, fn -> Promotions.get_promotion!(other_scope, promotion.id) end
    end

    test "create_promotion/2 with valid data creates a promotion" do
      valid_attrs = %{code: "some code", name: "some name"}
      scope = user_scope_fixture()

      assert {:ok, %Promotion{} = promotion} = Promotions.create_promotion(scope, valid_attrs)
      assert promotion.code == "some code"
      assert promotion.name == "some name"
      assert promotion.user_id == scope.user.id
    end

    test "create_promotion/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Promotions.create_promotion(scope, @invalid_attrs)
    end

    test "update_promotion/3 with valid data updates the promotion" do
      scope = user_scope_fixture()
      promotion = promotion_fixture(scope)
      update_attrs = %{code: "some updated code", name: "some updated name"}

      assert {:ok, %Promotion{} = promotion} = Promotions.update_promotion(scope, promotion, update_attrs)
      assert promotion.code == "some updated code"
      assert promotion.name == "some updated name"
    end

    test "update_promotion/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      promotion = promotion_fixture(scope)

      assert_raise MatchError, fn ->
        Promotions.update_promotion(other_scope, promotion, %{})
      end
    end

    test "update_promotion/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      promotion = promotion_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Promotions.update_promotion(scope, promotion, @invalid_attrs)
      assert promotion == Promotions.get_promotion!(scope, promotion.id)
    end

    test "delete_promotion/2 deletes the promotion" do
      scope = user_scope_fixture()
      promotion = promotion_fixture(scope)
      assert {:ok, %Promotion{}} = Promotions.delete_promotion(scope, promotion)
      assert_raise Ecto.NoResultsError, fn -> Promotions.get_promotion!(scope, promotion.id) end
    end

    test "delete_promotion/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      promotion = promotion_fixture(scope)
      assert_raise MatchError, fn -> Promotions.delete_promotion(other_scope, promotion) end
    end

    test "change_promotion/2 returns a promotion changeset" do
      scope = user_scope_fixture()
      promotion = promotion_fixture(scope)
      assert %Ecto.Changeset{} = Promotions.change_promotion(scope, promotion)
    end
  end
end
