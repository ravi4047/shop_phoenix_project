## Why .exs? Because it's a script file because we don't need to compile to production.
## I mean we can ignore the test folder when compiling the files.

def Shop.ProductsTest do
  use Shop.DataCase

  alias Shop.Products
  import Shop.ProductsFixtures

  test "list_products/0 returns all products" do
    product = product_fixture()
    assert Products.list_products() == [product]
  end

end

