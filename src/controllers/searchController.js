// src/controllers/searchController.js
const db = require("../db");

/**
 * GET /search/dishes?name=biryani&minPrice=150&maxPrice=300
 */
async function searchDishes(req, res) {
  try {
    const { name, minPrice, maxPrice } = req.query;

    // Basic validation
    if (!name || minPrice === undefined || maxPrice === undefined) {
      return res.status(400).json({
        message: "Missing required query params: name, minPrice, maxPrice",
      });
    }

    const min = parseInt(minPrice, 10);
    const max = parseInt(maxPrice, 10);

    if (Number.isNaN(min) || Number.isNaN(max)) {
      return res.status(400).json({ message: "minPrice and maxPrice must be numbers" });
    }
    if (min > max) {
      return res.status(400).json({ message: "minPrice cannot be greater than maxPrice" });
    }

    // SQL: find menu items matching name (case-insensitive), price between range,
    // count orders per menu_item, join with restaurants, order by count desc, limit 10
    const sql = `
      SELECT
        r.id AS restaurantId,
        r.name AS restaurantName,
        r.city AS city,
        m.name AS dishName,
        m.price AS dishPrice,
        COUNT(o.id) AS orderCount
      FROM menu_items m
      JOIN restaurants r ON m.restaurant_id = r.id
      LEFT JOIN orders o ON o.menu_item_id = m.id
      WHERE LOWER(m.name) LIKE ? AND m.price BETWEEN ? AND ?
      GROUP BY r.id, r.name, r.city, m.id, m.name, m.price
      ORDER BY orderCount DESC
      LIMIT 10;
    `;

    // parameter values
    const likeName = `%${name.toLowerCase()}%`;
    const [rows] = await db.query(sql, [likeName, min, max]);

    // Format numbers as integers
    const results = rows.map((row) => ({
      restaurantId: row.restaurantId,
      restaurantName: row.restaurantName,
      city: row.city,
      dishName: row.dishName,
      dishPrice: Number(row.dishPrice),
      orderCount: Number(row.orderCount),
    }));

    return res.json({ restaurants: results });
  } catch (err) {
    console.error("searchDishes error:", err);
    return res.status(500).json({ message: "Internal server error" });
  }
}

module.exports = { searchDishes };
