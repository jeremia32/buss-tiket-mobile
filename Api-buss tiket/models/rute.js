const mongoose = require("mongoose");
const Schema = mongoose.Schema;

// Definisikan skema untuk model rute
const ruteSchema = new Schema(
  {
    bus: {
      type: Schema.Types.ObjectId,
      ref: "Bus", // Merujuk ke model Bus
      required: true,
    },
    namarute: {
      type: String,
      required: true,
    },
    asal: {
      type: String,
      required: true,
    },
    tujuan: {
      type: String,
      required: true,
    },
    jarak: {
      type: String,
      required: true,
    },
    durasi: {
      type: String,
      required: true,
    },
    // Tambahan field lainnya bisa ditambahkan sesuai kebutuhan
  },
  {
    collection: "rute", // Menetapkan nama koleksi secara eksplisit
  }
);

// Buat model "Rute" berdasarkan skema yang telah didefinisikan
const Rute = mongoose.model("Rute", ruteSchema);

module.exports = Rute;
