# alias Shop.{Repo, Product}
alias Shop.Repo
alias Shop.Products
alias Shop.Products.Product

# 👉 Now this will run everytime before IEX runs.
# 👉 As far as I've seen recompiling is not enough, You need to restart it.

import Ecto.Query #### To run complex query clauses, you need to import Ecto.Query
