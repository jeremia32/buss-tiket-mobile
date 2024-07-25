const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const bussSchema = new Schema({
  nama: {
    type: String,
  },
  tipe: {
    type: String,
  },
  nomormobil: {
    type: Number,
  },
  deskripsi: {
    type: String,
  },
  gambar: {
    type: String,
  },

});
module.exports = mongoose.model("bus", bussSchema);
  