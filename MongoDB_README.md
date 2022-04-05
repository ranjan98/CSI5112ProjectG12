# MongoDB

Database for the Project - UOMart

## Collections

Total Collections: 6\
Collections: answers, categories, orders, products, questions, user

<img src = "https://github.com/ranjan98/CSI5112ProjectG12/blob/main/Database.png" width = "1000" alt = "Collections" />

Indexes Created: 

  <strong> 1. Category Id index on products Collection </strong><br>
Since we are fetching products for one category, we created an index for fetching the products using category id.
<img src = "product_indexes.png" width = "1000" alt = "Category Id Index on Products Collection" />

  <strong> 2. User Id index on orders Collection </strong><br>
We created this as we are fetching the orders for a specific user. Hence, we created an index for fetching the orders using user id.
<img src = "orders_indexes.png" width = "1000" alt = "User Id Index on Orders Collection" />

  <strong> 3. Question Id index on answers Collection </strong><br>
Since we are fetching answers for a particular question, we created an index for fetching the answers using the question id
<img src = "answers_indexes.png" width = "1000" alt = "Question Id Index on Answers Collection" />

<em> All the CRUD Operations are working and the API documentation can be accessed from the following link: </em><br>
<a href="https://documenter.getpostman.com/view/11041377/UVyuREpy">https://documenter.getpostman.com/view/11041377/UVyuREpy</a>
