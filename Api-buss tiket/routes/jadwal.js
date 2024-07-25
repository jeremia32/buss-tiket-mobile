const router = require("express").Router();
const jadwalController = require("../controllers/jadwalController");

// Endpoint untuk membuat jadwal baru
router.post("/create", async (req, res) => {
  console.log("Data yang diterima di router:", req.body); // Tambahkan ini untuk debugging
  try {
    const result = await jadwalController.create(req.body);
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint untuk mengedit jadwal berdasarkan ID
router.put("/edit/:id", async (req, res) => {
  try {
    const result = await jadwalController.updateById(req.params.id, req.body);
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint untuk mendapatkan semua jadwal
router.get("/getall", async (req, res) => {
  try {
    const result = await jadwalController.getAll();
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint untuk mendapatkan jadwal berdasarkan ID
router.get("/getbyid/:id", async (req, res) => {
  try {
    const result = await jadwalController.getById(req.params.id);
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Endpoint untuk menghapus jadwal berdasarkan ID
router.delete("/hapus/:id", async (req, res) => {
  try {
    const result = await jadwalController.deleteById(req.params.id);
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
