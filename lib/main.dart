import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ==========================
// FUNGSI
// ==========================
double hitungTotal(int jumlah, double harga) {
  return jumlah * harga;
}

double hitungHargaAkhir(double total, double persenPotongan) {
  return total - (total * persenPotongan / 100);
}

// ==========================
// CLASS BARANG
// ==========================
class Barang {
  String nama;
  double harga;
  int stok;
  String kategori;

  // Konstruktor
  Barang(this.nama, this.harga, this.stok, this.kategori);

  // Method tampilkan()
  void tampilkan() {
    print("=== KARTU BARANG ===");
    print("Nama     : $nama");
    print("Harga    : Rp$harga");
    print("Stok     : $stok");
    print("Kategori : $kategori");
    print("--------------------");
  }

// Method untuk menghitung nilai stok
double nilaiStok() {
  return harga * stok;
  }
// Method untuk mengecek apakah barang bisa dijual
bool bisaDijual(int diminta) {
  return stok >= diminta;
  }
}

// ==========================
// CLASS BARANG PROMO
// ==========================
class BarangPromo extends Barang {
  double diskon;

  // Konstruktor dengan super(...)
  BarangPromo(
    String nama,
    double harga,
    int stok,
    String kategori,
    this.diskon,
  ) : super(nama, harga, stok, kategori);

  // Method khusus menghitung harga promo
  double hargaPromo() {
    return harga - (harga * diskon / 100);
  }
}

// ==========================
// CLASS PEMBELI
// ==========================
class Pembeli {
  String nama;
  bool statusAnggota;

  // Konstruktor
  Pembeli(this.nama, this.statusAnggota);
}

// ==========================
// CLASS MY APP
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
    // ==========================
    // DATA TRANSAKSI
    // ==========================
    String namaBarang = "Buku Tulis";
    String kategori = "makanan";

    double hargaAnggota = 3000;
    double hargaUmum = 3500;

    bool anggota = true;
    int jumlah = 50;

    // ==========================
    // OBJEK BARANG
    // ==========================
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

BarangPromo promo = BarangPromo(
  "Buku Tulis Promo",
  5000,
  10,
  "ATK",
  20,
);

print("=== BARANG PROMO ===");
print("Nama : ${promo.nama}");
print("Harga Normal : Rp${promo.harga}");
print("Diskon : ${promo.diskon}%");
print("Harga Promo : Rp${promo.hargaPromo()}");

    // Memanggil method tampilkan()
    bukuTulis.tampilkan();
    pulpen.tampilkan();
    roti.tampilkan();

// ==========================
// LIST BARANG
// ==========================

// Dibandingkan Sprint 3 yang menggunakan objek
// secara terpisah, List<Barang> lebih rapi karena
// semua barang disimpan dalam satu kumpulan.
// Dengan perulangan, semua barang dapat ditampilkan
// tanpa memanggil tampilkan() satu per satu.

List<Barang> daftarBarangObjek = [
  bukuTulis,
  pulpen,
  roti,
];

// Menampilkan semua barang menggunakan perulangan.
for (Barang barang in daftarBarangObjek) {
  barang.tampilkan();
}

    // ==========================
    // MENENTUKAN HARGA
    // ==========================
    String jenisHarga;
    double harga;

    if (anggota) {
      harga = hargaAnggota;
      jenisHarga = "Anggota";
    } else {
      harga = hargaUmum;
      jenisHarga = "Umum";
    }

    // ==========================
    // MENGHITUNG TOTAL
    // ==========================
    double totalBelanja = hitungTotal(jumlah, harga);

    // ==========================
    // MENENTUKAN POTONGAN
    // ==========================
    double persenPotongan = 0;

    if (totalBelanja > 200000) {
      persenPotongan = 10;
    } else if (totalBelanja > 100000) {
      persenPotongan = 5;
    } else {
      persenPotongan = 0;
    }

    // ==========================
    // HARGA AKHIR
    // ==========================
    double hargaAkhir =
        hitungHargaAkhir(totalBelanja, persenPotongan);

    // ==========================
    // MENENTUKAN RAK
    // ==========================
    String rak;

    switch (kategori) {
      case "atk":
        rak = "Rak 1";
        break;
      case "makanan":
        rak = "Rak 2";
        break;
      case "minuman":
        rak = "Rak 3";
        break;
      default:
        rak = "Rak lain";
    }

    // ==========================
    // OUTPUT DEBUG CONSOLE
    // ==========================
    print("=== TRANSAKSI KOPERASI ===");
    print("Status : $jenisHarga");
    print("Harga : Rp$harga");
    print("Total : Rp$totalBelanja");
    print("Potongan : $persenPotongan%");
    print("Harga Akhir : Rp$hargaAkhir");
    print("Kategori : $rak");

    // ==========================
    // DAFTAR BARANG
    // ==========================
    List<String> daftarBarang = [
      "Buku Tulis",
      "Pulpen",
      "Penghapus",
      "Roti",
    ];

    List<int> daftarHarga = [
      3000,
      2500,
      1500,
      5000,
    ];

    print("=== DAFTAR BARANG ===");

    for (int i = 0; i < daftarBarang.length; i++) {
      print(
        "${i + 1}. ${daftarBarang[i]} - Rp. ${daftarHarga[i]}",
      );
    }

    // ==========================
    // PENJUALAN BUKU TULIS
    // ==========================
    int stok = 3;

    print("--- Penjualan Buku Tulis ---");

    while (stok > 0) {
      stok--;
      print("Terjual 1, sisa stok: $stok");
    }

    // ==========================
    // TAMPILAN FLUTTER
    // ==========================
    return Scaffold(
      appBar: AppBar(
        title: const Text("Koperasi Sekolah"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "=== TRANSAKSI KOPERASI ===",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text("Nama Barang : $namaBarang"),
            Text("Kategori : $kategori"),
            Text("Lokasi Rak : $rak"),
            Text("Status Anggota : ${anggota ? "Ya" : "Tidak"}"),
            Text(
              "Harga Satuan : Rp${harga.toStringAsFixed(0)}",
            ),
            Text(
              "Total Belanja : Rp${totalBelanja.toStringAsFixed(0)}",
            ),
            Text(
              "Potongan : ${persenPotongan.toStringAsFixed(0)}%",
            ),

            Text(
              "Harga Akhir : Rp${hargaAkhir.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================
// CATATAN
// ==========================
//
// Switch digunakan untuk menentukan rak berdasarkan kategori.
//
// Kondisi while (stok > 0) memastikan penjualan berhenti
// ketika stok mencapai 0 sehingga stok tidak menjadi minus.
//
// Pemecahan program menjadi fungsi membuat kode lebih rapi
// dan mengurangi pengulangan rumus.
//
// Jika aturan potongan berubah, bagian perhitungan potongan
// cukup diperbarui pada satu tempat.
//
// Class Barang digunakan untuk menggabungkan nama, harga,
// stok, dan kategori dalam satu objek sehingga data barang
// lebih mudah dikelola.
//
// Setiap barang dapat dibuat sebagai objek yang berbeda,
// tetapi tetap menggunakan konsep Barang yang sama.

// ==========================
// JAWABAN LKPD-5 OOP
// ==========================
//
// Keuntungan memodelkan barang sebagai objek adalah
// data dan fungsi barang menjadi lebih terstruktur.
// Setiap barang memiliki atribut seperti nama, harga,
// stok, dan kategori dalam satu objek. Dengan begitu,
// sistem koperasi ke depan lebih mudah dikembangkan,
// misalnya menambah barang, mengubah data barang,
// mengelola stok, dan menambahkan fitur baru tanpa
// harus mengubah banyak bagian program.

// ==========================
// NILAI STOK BARANG
// ==========================
// Nilai stok berguna untuk mengetahui nilai aset
// koperasi yang masih tersimpan dalam bentuk barang.
// Angka ini membantu koperasi membuat laporan aset,
// mengetahui nilai persediaan, dan memantau kondisi
// keuangan koperasi.

// ==========================
// JAWABAN BISA DIJUAL
// ==========================
//
// Pengecekan diletakkan di dalam objek Barang agar
// aturan stok terpusat dan setiap barang dapat
// mengecek sendiri apakah stoknya mencukupi.
// Hal ini membuat kode lebih rapi, mudah digunakan,
// dan mengurangi kesalahan saat sistem dikembangkan.

// ==========================
// RELASI PEMBELI & BARANG
// ==========================
//
// Relasi yang wajar adalah satu Pembeli dapat membeli
// satu atau beberapa Barang dalam satu transaksi.
// Sebaliknya, satu Barang dapat dibeli oleh banyak Pembeli
// pada transaksi yang berbeda.
//
// Dalam satu transaksi, Pembeli menjadi pihak yang membeli
// Barang, sedangkan Barang menjadi item yang dibeli.