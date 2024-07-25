const Rute = require("../models/rute");

exports.create = async (data) => {
  try {
    console.log("Data diterima di controller:", data); // Debugging
    if (!data.bus || !data.asal || !data.tujuan || !data.jarak || !data.durasi || !data.namarute) {
      console.error("Data yang diterima tidak lengkap:", data); // Debugging
      throw new Error("Semua field yang diperlukan harus diisi");
    }
    const rute = new Rute(data);
    const result = await rute.save();
    return { sukses: true, data: result, msg: "Rute berhasil dibuat" };
  } catch (err) {
    console.error("Error saat menyimpan rute:", err); // Debugging
    return { sukses: false, msg: err.message };
  }
};

exports.getAll = async () => {
  try {
    const res = await Rute.find({});
    return {
      sukses: true,
      msg: "Berhasil Mengambil Data",
      data: res,
    };
  } catch (err) {
    return {
      sukses: false,
      msg: "Gagal Mengambil Data",
      data: [],
    };
  }
};

exports.getById = async (id) => {
  try {
    const res = await Rute.findById(id);
    if (res) {
      return { sukses: true, msg: "Berhasil Mengambil Data", data: res };
    } else {
      throw new Error("Data tidak ditemukan");
    }
  } catch (err) {
    console.error("Error saat mengambil data rute:", err); // Debugging
    return { sukses: false, msg: err.message, data: {} };
  }
};

exports.edit = async (id, data) => {
  try {
    const res = await Rute.findByIdAndUpdate(id, data, { new: true });
    if (res) {
      return { sukses: true, msg: "Berhasil Edit Data" };
    } else {
      throw new Error("Data tidak ditemukan");
    }
  } catch (err) {
    console.error("Error saat mengedit data rute:", err); // Debugging
    return { sukses: false, msg: err.message };
  }
};

exports.delete = async (id) => {
  try {
    const res = await Rute.findByIdAndDelete(id);
    if (res) {
      return { sukses: true, msg: "Berhasil Hapus Data" };
    } else {
      throw new Error("Data tidak ditemukan");
    }
  } catch (err) {
    console.error("Error saat menghapus data rute:", err); // Debugging
    return { sukses: false, msg: err.message };
  }
};
