🍽️ Restaurant Search Backend Service

A simple Node.js + Express + MySQL backend service that allows users to search for restaurants by dish name, restricted by a mandatory price range, and ranked by order popularity.

This project was built as part of a backend assignment to demonstrate data modeling, SQL aggregation, and API design.

❗ Note on Deployment

A live deployed URL is not provided for this submission.

Reason:

During deployment attempts on free-tier cloud platforms, outbound TCP connections to managed MySQL services resulted in network timeouts due to platform-level restrictions.

The application works fully and correctly in local and containerized environments, and the core objective of the assignment—schema design, query logic, and API behavior—remains unaffected.

A short demo recording of the working local setup can be shared if required.

🚀 Features

Search restaurants by dish name

Mandatory price range filtering

Rank restaurants by number of times a dish has been ordered

Returns top 10 restaurants

Clean, modular backend structure

Seeded database with sample data

🛠️ Tech Stack

Node.js

Express.js

MySQL

mysql2

📁 Project Structure
restaurant-search
├── src
│   ├── app.js
│   ├── db.js
│   ├── routes
│   │   └── searchRoutes.js
│   └── controllers
│       └── searchController.js
├── seed
│   └── seed.sql
├── package.json
├── .gitignore
└── README.md

🗄️ Database Schema
restaurants

id (PK)

name

city

menu_items

id (PK)

restaurant_id (FK → restaurants.id)

name

price

orders

id (PK)

menu_item_id (FK → menu_items.id)

order_time

For simplicity, each order contains exactly one menu item, as specified in the assignment.

🔍 API Endpoint
Search Restaurants by Dish
GET /search/dishes

Query Parameters
Param	Type	Required
name	string	✅ Yes
minPrice	number	✅ Yes
maxPrice	number	✅ Yes
Example Request
/search/dishes?name=biryani&minPrice=150&maxPrice=300

Example Response
{
  "restaurants": [
    {
      "restaurantId": 1,
      "restaurantName": "Hyderabadi Spice House",
      "city": "Hyderabad",
      "dishName": "Chicken Biryani",
      "dishPrice": 220,
      "orderCount": 12
    }
  ]
}

⚙️ Local Setup Instructions
1️⃣ Clone the Repository
git clone <your-github-repo-url>
cd restaurant-search

2️⃣ Install Dependencies
npm install

3️⃣ Setup Environment Variables

Create a .env file in the project root:

DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=restaurant_search

4️⃣ Setup Database & Seed Data

Create the database and seed it using:

mysql -u root -p restaurant_search < seed/seed.sql

5️⃣ Start the Server
npm start


Server will run at:

http://localhost:3000

✅ Health Check
GET /health


Response:

{ "status": "ok" }

🧠 Design Considerations

Parameterized SQL queries used to prevent SQL injection

Clear separation of concerns (routes, controllers, DB)

Simple and readable codebase for easy extension

Aggregation handled at the SQL layer for efficiency

🔮 Future Improvements

Pagination support

Case-insensitive full-text search

Caching popular search results

Authentication & user-specific ordering

Dockerized deployment

👤 Author
Ashraf Hussain Siddiqui
Backend / Full Stack Developer
