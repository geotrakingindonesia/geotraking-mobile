// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class TutorialTileTeks extends StatefulWidget {
  final String title;
  const TutorialTileTeks({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _TutorialTileTeksState createState() => _TutorialTileTeksState();
}

class _TutorialTileTeksState extends State<TutorialTileTeks> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Color.fromARGB(255, 98, 182, 183),
      color: Colors.black,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon:
                  Icon(_isExpanded ? Icons.arrow_upward : Icons.arrow_downward),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ponsel tidak mau hidup.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Apakah Anda menekan dan menahan tombol daya selama minimal tiga detik untuk menghidupkan telepon?\n• Periksa baterai. Apakah sudah terisi daya, dipasang dengan benar, dan apakah kontaknya bersih dan kering?',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Anda tidak dapat melakukan panggilan.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Periksa antena. Apakah sepenuhnya memanjang dan miring dengan benar? Apakah Anda memiliki pandangan yang jelas tanpa halangan langit?\n• Apakah Anda memasukkan nomor dalam format internasional? Semua panggilan yang dilakukan dari sistem satelit Iridium harus dalam format internasional. Lihat “Menelepon” di halaman 32.\n• Periksa indikator kekuatan sinyal. Jika sinyalnya lemah, pastikan Anda memiliki garis pandang yang jelas ke langit dan tidak ada bangunan, pohon, atau objek lain yang mengganggu.\n• Apakah Dibatasi ditampilkan? Periksa pengaturan Pembatasan Panggilan.\n• Apakah kartu SIM baru telah dimasukkan? Pastikan tidak ada batasan baru yang diberlakukan.\n• Periksa apakah daftar panggilan tetap Anda diaktifkan. Jika demikian, Anda hanya dapat melakukan panggilan ke nomor atau prefiks yang ada di dalam daftar.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Anda tidak dapat menerima panggilan.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Periksa apakah ponsel Anda sudah dihidupkan.\n• Periksa antena. Apakah sepenuhnya memanjang dan miring dengan benar? Apakah Anda memiliki pandangan yang jelas tanpa halangan langit?\n• Periksa indikator kekuatan sinyal. Jika sinyalnya lemah, pastikan Anda memiliki garis pandang yang jelas ke langit dan tidak ada bangunan, pohon, atau objek lain di sekitarnya.\n• Periksa pengaturan Penerusan Panggilan dan Pembatasan Panggilan.\n• Periksa pengaturan Dering. Jika mati, tidak ada dering yang terdengar.\n• Periksa apakah daftar panggilan tetap Anda diaktifkan.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Anda tidak dapat melakukan panggilan internasional.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Sudahkah Anda memasukkan kode-kode yang relevan? Masukkan 00 atau + diikuti dengan kode negara yang sesuai dan nomor telepon.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Ponsel Anda tidak akan terbuka.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Sudahkah Anda memasukkan kartu SIM baru? Masukkan kode PIN baru PIN default adalah 1111).\n• Masukkan kode buka kunci telepon standar: 1234\n• Apakah Anda lupa kode buka kunci?',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'PIN Anda diblokir.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Masukkan kode pembuka PIN atau hubungi penyedia layanan Anda. Lihat “Menggunakan Menu Keamanan” di halaman 153 untuk informasi lebih lanjut.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'PIN2 Anda diblokir.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Masukkan kode pembuka blokir PIN2 atau hubungi penyedia layanan Anda. Lihat “Menggunakan Menu Keamanan” di hal.153 untuk informasi lebih lanjut.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Kartu SIM Anda tidak akan berfungsi.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Apakah kartu SIM dimasukkan dengan benar?\n• Apakah kartu terlihat rusak atau tergores? Kembalikan kartu ke penyedia layanan Anda.\n• Periksa SIM dan kontak kartu. Jika kotor, bersihkan dengan kain antistatis.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Anda tidak dapat membatalkan Penerusan Panggilan atau Pembatasan Panggilan.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tunggu hingga Anda berada di area dengan jangkauan jaringan yang baik dan coba lagi.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Indikator pesan berkedip.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tidak tersedia cukup memori untuk menyimpan pesan lain. Gunakan menu pesan untuk menghapus satu atau beberapa pesan.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Baterai tidak mau mengisi daya.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Periksa pengisi daya. Apakah terhubung dengan benar? Apakah kontaknya bersih dan kering?\n• Periksa kontak baterai. Apakah mereka bersih dan kering?\n• Periksa suhu baterai. Jika hangat, biarkan dingin sebelum mengisi daya.\n• Apakah ini baterai lama? Performa baterai menurun setelah beberapa tahun digunakan. Ganti baterai.\n• Pastikan Anda memasang baterai yang disetujui Iridium. Jika kamu melihat ? pada tampilan di dekat ikon pengisian daya, Anda tidak dapat mengisi daya baterai ini.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Baterai terkuras lebih cepat dari biasanya.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Apakah Anda berada di area cakupan variabel? Ini menggunakan daya baterai ekstra.\n• Apakah antena Anda sepenuhnya diperpanjang dan dimiringkan dengan benar? Apakah Anda memiliki pandangan yang jelas tanpa halangan langit? Ini membantu menggunakan lebih sedikit daya baterai.\n• Apakah baterai baru? Baterai baru memerlukan dua hingga tiga siklus pengisian/pengosongan untuk mencapai kinerja normal\n• Apakah ini baterai lama? Performa baterai menurun setelah beberapa tahun digunakan. Ganti baterai.\n• Apakah itu baterai yang belum habis sama sekali? Biarkan baterai kosong sepenuhnya (sampai ponsel mati sendiri) dan kemudian isi baterai semalaman.\n• Apakah Anda menggunakan ponsel dalam suhu ekstrem? Pada suhu yang sangat panas atau dingin, kinerja baterai berkurang secara signifikan.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Anda menemukan ponsel Anda menjadi hangat saat digunakan.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Anda mungkin memperhatikan ini selama panggilan lama atau selama pengisian daya. Panas dihasilkan oleh komponen elektronik di dalam ponsel Anda dan hal ini cukup normal.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Ponsel tidak merespons kontrol pengguna termasuk tombol daya.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Keluarkan baterai dari telepon lalu pasang kembali untuk menghidupkan kembali dan mengatur ulang.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Kartu SIM Anda dimasukkan ke dalam telepon tetapi layar mengatakan: Periksa Kartu atau Sisipkan Kartu atau Diblokir.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Periksa Kartu atau Sisipkan Kartu: Periksa apakah kartu SIM telah dimasukkan dengan benar. Kontak kartu SIM mungkin kotor. Matikan telepon, keluarkan kartu SIM dan gosok kontak dengan kain bersih. Ganti kartu di telepon.\nDiblokir: Masukkan kunci pembuka blokir PIN atau hubungi penyedia layanan Anda. Lihat “PIN Pembatasan Panggilan” pada halaman 163 untuk informasi tambahan.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Ponsel Anda menampilkan bahasa asing yang tidak dikenal dan Anda ingin mengembalikannya ke pengaturan aslinya.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Hidupkan telepon.\n• Hidupkan telepon. Tekan tombol lunak kiri untuk menu.\n• Hidupkan telepon. Tekan ke bawah enam kali untuk Pengaturan, lalu tombol lunak kiri untuk Pilih.\n• Hidupkan telepon. Tekan ke bawah tiga kali untuk Bahasa, lalu tombol lunak kiri untuk Pilih.\n• Hidupkan telepon. Tekan tombol lunak kiri untuk Pilih.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Telepon menyatakan "Mencari Jaringan"',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '• Pastikan Anda berada di area dengan pemandangan langit terbuka\n• Rentangkan antena dan arahkan tegak lurus ke langit tepat di atas untuk menerima sinyal\n• Jika ponsel Anda dinyalakan di dalam gedung atau area dengan pemandangan langit terhalang tepat sebelum mencoba melakukan panggilan di luar, ponsel mungkin untuk sementara berada dalam mode hemat daya untuk menghemat masa pakai baterai. Anda dapat menunggunya untuk secara otomatis keluar dari mode hemat daya dalam satu atau dua menit pada interval yang dijadwalkan atau cukup matikan telepon Anda dan nyalakan lagi untuk mempercepat proses pendaftaran.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
