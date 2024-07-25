const express = require("express");
const router = express.Router();
const ruteController = require("../controllers/ruteController");

// Endpoint untuk membuat rute baru
router.post("/create", async (req, res) => {
  console.log("Data yang diterima di router:", req.body); // Tambahkan ini untuk debugging
  try {
    const result = await ruteController.create(req.body);
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint untuk mengedit rute berdasarkan ID
router.put("/edit/:id", async (req, res) => {
  try {
    const result = await ruteController.edit(req.params.id, req.body);
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint untuk mendapatkan semua rute
router.get("/getall", async (req, res) => {
  try {
    const result = await ruteController.getAll();
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint untuk mendapatkan rute berdasarkan ID
router.get("/getbyid/:id", async (req, res) => {
  try {
    const result = await ruteController.getById(req.params.id);
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint untuk menghapus rute berdasarkan ID
router.delete("/hapus/:id", async (req, res) => {
  try {
    const result = await ruteController.delete(req.params.id);
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
