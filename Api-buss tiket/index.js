const express = require("express");
const app = express();
const mongoose = require("mongoose");
const mongoUrl = "mongodb://localhost:27017/tiketbuss";
const cors = require("cors");
const path = require("path");
const rute = require("./routes/rute"); // Import router

mongoose
  .connect(mongoUrl, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("Berhasil Connect Ke Database");
  })
  .catch((e) => {
    console.log(e);
    console.log("Gagal Connect Ke Database");
  });

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

const directory = path.join(__dirname, "/static/");
app.use(express.static(directory));

app.use("/user", require("./routes/user"));
app.use("/bus", require("./routes/bus"));
app.use("/rute", require("./routes/rute"));
app.use("/jadwal", require("./routes/jadwal"));
app.use("/transaksi", require("./routes/transaksi"));

app.listen(5001, () => {
  console.log("Berhasil Jalan");
});
