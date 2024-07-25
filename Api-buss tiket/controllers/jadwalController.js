const Jadwal = require("../models/jadwal");

exports.create = async (data) => {
  try {
    console.log("Data diterima di controller:", data); // Debugging
    if (!data.bus || !data.tanggalBerangkat || !data.waktuBerangkat || !data.hargaTiket || !data.rute || !data.status) {
      console.error("Data yang diterima tidak lengkap:", data); // Debugging
      throw new Error("Semua field yang diperlukan harus diisi");
    }
    const jadwal = new Jadwal(data);
    const result = await jadwal.save();
    return { sukses: true, data: result, msg: "Jadwal berhasil dibuat" };
  } catch (err) {
    console.error("Error saat menyimpan jadwal:", err); // Debugging
    return { sukses: false, msg: err.message };
  }
};

// Get all schedules
exports.getAll = () => {
  return new Promise((resolve, reject) => {
    Jadwal.find({})
      .then((result) => {
        resolve({
          success: true,
          msg: "Berhasil Mengambil Data Jadwal",
          data: result,
        });
      })
      .catch(() => {
        reject({
          success: false,
          msg: "Gagal Mengambil Data Jadwal",
          data: [],
        });
      });
  });
};

// Get schedule by ID
exports.getById = (id) => {
  return new Promise((resolve, reject) => {
    Jadwal.findById(id)
      .then((result) => {
        if (result) {
          resolve({
            success: true,
            msg: "Berhasil Mengambil Data Jadwal",
            data: result,
          });
        } else {
          reject({
            success: false,
            msg: "Data Jadwal Tidak Ditemukan",
            data: {},
          });
        }
      })
      .catch(() => {
        reject({
          success: false,
          msg: "Gagal Mengambil Data Jadwal",
          data: {},
        });
      });
  });
};

// Update schedule by ID
exports.updateById = (id, data) => {
  return new Promise((resolve, reject) => {
    Jadwal.findByIdAndUpdate(id, data)
      .then(() => {
        resolve({
          success: true,
          msg: "Berhasil Edit Data Jadwal",
        });
      })
      .catch(() => {
        reject({
          success: false,
          msg: "Gagal Edit Data Jadwal",
        });
      });
  });
};

// Delete schedule by ID
exports.deleteById = (id) => {
  return new Promise((resolve, reject) => {
    Jadwal.findByIdAndDelete(id)
      .then(() => {
        resolve({
          success: true,
          msg: "Berhasil Hapus Data Jadwal",
        });
      })
      .catch(() => {
        reject({
          success: false,
          msg: "Gagal Hapus Data Jadwal",
        });
      });
  });
};
