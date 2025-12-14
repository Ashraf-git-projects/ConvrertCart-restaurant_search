// src/app.js
const express = require("express");

const app = express();

const db = require("./db");

const searchRoutes = require("./routes/searchRoutes");

// Middleware to parse JSON request bodies
app.use(express.json());
app.use("/search", searchRoutes);

// Simple health check route
app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});


// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
