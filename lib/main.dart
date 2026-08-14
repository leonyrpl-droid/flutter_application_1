import 'package:flutter/material.dart';

// ==========================
// ASINKRON + PENANGANAN GALAT
// ==========================
Future<void> muatLaporan() async {
  try {
    print("Menyiapkan laporan...");

    await Future.delayed(
      const Duration(seconds: 1),
    );

    // Simulasi laporan gagal
    throw Exception("Gagal memuat laporan");

  } catch (e) {
    print("Laporan gagal dimuat: $e");
  }
}

// ==========================
// DOKUMENTASI TP 12.2
// ==========================
//
// 1. Tipe data dan kontrol alur digunakan untuk mengolah
//    harga, jumlah pembelian, stok, potongan, dan status anggota.
//
// 2. OOP digunakan melalui class Barang, Pembeli, BarangPromo,
//    dan BarangGrosir.
//
// 3. Pewarisan dan override digunakan pada BarangPromo
//    dan BarangGrosir.
//
// 4. Try-catch-finally digunakan untuk menangani kesalahan
//    input agar program tetap berjalan stabil.
//
// 5. Asinkron digunakan pada muatLaporan() untuk proses
//    pemuatan laporan tanpa menghentikan program.
//
// Kelima konsep tersebut bekerja sama dalam satu sistem kasir,
// mulai dari memuat laporan, menampilkan barang, memproses transaksi,
// menghitung harga, mengurangi stok, hingga memberikan poin anggota.
//


// ==========================
// MAIN
// ==========================
Future<void> main() async {
  // 1. Muat laporan terlebih dahulu
  await muatLaporan();

  // 2. Membuat data barang
  Barang bukuTulis = Barang(
    "Buku Tulis",
    3000,
    10,
    "ATK",
  );

  Barang pulpen = Barang(
    "Pulpen",
    2500,
    15,
    "ATK",
  );

  Barang roti = Barang(
    "Roti",
    5000,
    8,
    "Makanan",
  );

  // 3. Menyimpan barang dalam List
  List<Barang> daftarBarang = [
    bukuTulis,
    pulpen,
    roti,
  ];

  // 4. Menampilkan daftar barang
  print("");
  print("=== DAFTAR BARANG ===");

  for (int i = 0; i < daftarBarang.length; i++) {
    print(
      "${i + 1}. ${daftarBarang[i].nama} - Rp${daftarBarang[i].harga.toStringAsFixed(0)} - Stok: ${daftarBarang[i].stok}",
    );
  }

  // 5. Membuat pembeli
  Pembeli pembeli = Pembeli(
    "Pembeli 1",
    true,
  );

  // 6. Proses satu transaksi
  print("");
  print("=== PROSES TRANSAKSI ===");

  prosesTransaksi(
    bukuTulis,
    "2",
    pembeli,
  );

  // Menjalankan aplikasi Flutter
  runApp(const MyApp());
}

// ==========================
// FUNGSI HITUNG TOTAL
// ==========================
double hitungTotal(int jumlah, double harga) {
  return jumlah * harga;
}

// ==========================
// FUNGSI HITUNG HARGA AKHIR
// ==========================
double hitungHargaAkhir(
  double total,
  double persenPotongan,
) {
  return total - (total * persenPotongan / 100);
}

// ==========================
// FUNGSI PROSES TRANSAKSI
// ==========================
void prosesTransaksi(
  Barang barang,
  String inputJumlah,
  Pembeli pembeli,
) {
  try {
    int jumlah = int.parse(inputJumlah);

    // Mengecek jumlah pembelian
    if (jumlah <= 0) {
      print("Jumlah pembelian harus lebih dari 0.");
      return;
    }

    // Mengecek stok
    if (!barang.bisaDijual(jumlah)) {
      print("Jumlah beli melebihi stok yang tersedia.");
      print("Stok tersedia: ${barang.stok}");
      return;
    }

    // Menentukan harga anggota atau umum
    double harga = pembeli.statusAnggota
        ? barang.harga
        : barang.harga + 500;

    String jenisHarga =
        pembeli.statusAnggota ? "Anggota" : "Umum";

    // Menghitung total
    double totalBelanja =
        hitungTotal(jumlah, harga);

    // Menentukan potongan
    double persenPotongan = 0;

    if (totalBelanja > 200000) {
      persenPotongan = 10;
    } else if (totalBelanja > 100000) {
      persenPotongan = 5;
    }

    // Menghitung harga akhir
    double hargaAkhir = hitungHargaAkhir(
      totalBelanja,
      persenPotongan,
    );

    // Mengurangi stok
    bool berhasil = barang.jual(jumlah);

   if (berhasil) {
  print("Nama Barang : ${barang.nama}");
  print("Jumlah Beli : $jumlah");
  print("Status      : $jenisHarga");
  print("Harga       : Rp${harga.toStringAsFixed(0)}");
  print(
    "Total       : Rp${totalBelanja.toStringAsFixed(0)}",
  );
  print("Potongan    : $persenPotongan%");
  print(
    "Harga Akhir : Rp${hargaAkhir.toStringAsFixed(0)}",
  );
  print("Stok Sisa   : ${barang.stok}");
  print("Penjualan berhasil diproses.");

  // Menambahkan poin anggota
  pembeli.tambahPoin();
  print("Poin anggota: ${pembeli.poin}");
}
} catch (e) {
  print(
    "Input '$inputJumlah' bukan angka. Silakan ulangi.",
  );
} finally {
  print("Transaksi dicatat di log.");
}
}

// ==========================
// CLASS BARANG
// ==========================
class Barang {
  String nama;
  double harga;
  int _stok;
  String kategori;

  Barang(
    this.nama,
    this.harga,
    this._stok,
    this.kategori,
  );

  // Getter stok
  int get stok => _stok;

  // Menampilkan data barang
  void tampilkan() {
    print("=== KARTU BARANG ===");
    print("Nama     : $nama");
    print("Harga    : Rp${harga.toStringAsFixed(0)}");
    print("Stok     : $stok");
    print("Kategori : $kategori");
    print("--------------------");
  }

  // Menghitung nilai stok
  double nilaiStok() {
    return harga * _stok;
  }

  // Mengecek apakah barang dapat dijual
  bool bisaDijual(int jumlah) {
    return _stok >= jumlah;
  }

  // Menjual barang dan mengurangi stok
  bool jual(int jumlah) {
    if (_stok >= jumlah) {
      _stok -= jumlah;
      return true;
    }

    return false;
  }
}

// ==========================
// CLASS BARANG PROMO
// ==========================
class BarangPromo extends Barang {
  double diskon;

  BarangPromo(
    String nama,
    double harga,
    int stok,
    String kategori,
    this.diskon,
  ) : super(
          nama,
          harga,
          stok,
          kategori,
        );

  double hargaPromo() {
    return harga - (harga * diskon / 100);
  }

  @override
  void tampilkan() {
    print("=== BARANG PROMO ===");
    print("Nama        : $nama");
    print("Harga       : Rp${harga.toStringAsFixed(0)}");
    print("Diskon      : $diskon%");
    print(
      "Harga Promo : Rp${hargaPromo().toStringAsFixed(0)}",
    );
    print("Stok        : $stok");
    print("Kategori    : $kategori");
    print("--------------------");
  }
}

// ==========================
// CLASS BARANG GROSIR
// ==========================
class BarangGrosir extends Barang {
  int minimalBeli;

  BarangGrosir(
    String nama,
    double harga,
    int stok,
    String kategori,
    this.minimalBeli,
  ) : super(
          nama,
          harga,
          stok,
          kategori,
        );

  @override
  void tampilkan() {
    print("=== BARANG GROSIR ===");
    print("Nama        : $nama");
    print("Harga       : Rp${harga.toStringAsFixed(0)}");
    print("Stok        : $stok");
    print("Kategori    : $kategori");
    print("Minimal Beli: $minimalBeli");
    print("--------------------");
  }
}

// ==========================
// CLASS PEMBELI
// ==========================
class Pembeli {
  String nama;
  bool statusAnggota;
  int poin;

  Pembeli(
    this.nama,
    this.statusAnggota, {
    this.poin = 0,
  });

  void tambahPoin() {
    if (statusAnggota) {
      poin++;
    }
  }
}

// ==========================
// FLUTTER APP
// ==========================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koperasi Sekolah',
      home: const MyHomePage(),
    );
  }
}

// ==========================
// HALAMAN UTAMA
// ==========================
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Koperasi Sekolah"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Sistem Kasir Brantas Mart\n"
          "Transaksi berhasil diproses.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}