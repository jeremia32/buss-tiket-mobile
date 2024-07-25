const router = require("express").Router();
const bussController = require("../controllers/bussController");
const uploadConfig = require("../uploadConfig");

// Middleware untuk mengatur fields upload
const fields = uploadConfig.upload.fields([
  {
    name: "gambar",
    maxCount: 1,
  },
]);

// Endpoint untuk membuat data baru
router.post("/create", fields, (req, res) => {
  try {
    // Pastikan req.files dan req.files.gambar sudah ada sebelum mengakses propertinya
    const gambar = req.files && req.files.gambar ? req.files.gambar[0].filename : null;
    req.body.gambar = gambar;

    bussController
      .create(req.body)
      .then((result) => res.json(result))
      .catch((err) => res.json(err));
  } catch (err) {
    // Tangani kesalahan jika ada
    res.json({ sukses: false, msg: "Terjadi kesalahan saat memproses permintaan" });
  }
});

// Endpoint untuk mengedit data
router.put("/edit/:id", fields, (req, res) => {
  try {
    const gambar = uploadConfig.cekNull(req.files && req.files.gambar ? req.files.gambar : null);
    const data = req.body;

    if (gambar) {
      data.gambar = gambar;
    } else {
      delete data.gambar;
    }

    bussController
      .edit(req.params.id, data)
      .then((result) => res.json(result))
      .catch((err) => res.json(err));
  } catch (err) {
    res.json({ sukses: false, msg: "Terjadi kesalahan saat memproses permintaan" });
  }
});

// Endpoint untuk mendapatkan semua data
router.get("/getall", (req, res) => {
  bussController
    .getData()
    .then((result) => res.json(result))
    .catch((err) => res.json(err));
});

// Endpoint untuk mendapatkan data berdasarkan ID
router.get("/getbyid/:id", (req, res) => {
  bussController
    .getById(req.params.id)
    .then((result) => res.json(result))
    .catch((err) => res.json(err));
});

// Endpoint untuk menghapus data
router.delete("/hapus/:id", (req, res) => {
  bussController
    .delete(req.params.id)
    .then((result) => res.json(result))
    .catch((err) => res.json(err));
});

module.exports = router;
