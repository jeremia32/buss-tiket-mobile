const mongoose = require("mongoose");
const jadwal = require("./jadwal");
const Schema = mongoose.Schema;
const objectId = mongoose.Types.ObjectId;

const transaksiSchema = new Schema({
  bus: {
    type: Schema.Types.ObjectId,
    ref: "Bus",
    required: true,
  },
  username: {
    ref: "user", // Merujuk ke model user
    type: Schema.Types.ObjectId,
    required: true,
  },
  rute: {
    type: Schema.Types.ObjectId,
    ref: "Rute",
    required: true,
  },

  jadwal: {
    type: Schema.Types.ObjectId,
    ref: "jadwal",
    required: true,
  },
  jumlah: {
    type: Number,
    required: true,
  },
  harga: {
    type: Number,
    ref: "jadwal", // Merujuk ke model user
    required: true,
  },
  tanggal: {
    type: Date,
    default: new Date().toLocaleDateString(),
  },
  status: {
    type: Number,
    default: 0,
  },
  buktiPembayaran: {
    type: String,
  },
});

module.exports = mongoose.model("transaksi", transaksiSchema);
