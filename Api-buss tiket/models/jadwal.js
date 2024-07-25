const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const jadwalSchema = new Schema({
  bus: {
    type: Schema.Types.ObjectId,
    ref: "Bus",
    required: true,
  },
  rute: {
    type: Schema.Types.ObjectId,
    ref: "Rute",
    required: true,
  },
  namarute: {
    type: String,
    ref: "Rute",

    required: true,
  },
  tanggalBerangkat: {
    type: Date,
    required: true,
  },
  tipe: {
    type: String,
    ref: "bus",
    required: true,
  },
  waktuBerangkat: {
    type: String,
    required: true,
  },
  hargaTiket: {
    type: Number,
    required: true,
  },
  status: {
    type: String,
    enum: ["aktif", "dibatalkan", "selesai"],
    required: true,
  },
});

module.exports = mongoose.model("Jadwal", jadwalSchema);
