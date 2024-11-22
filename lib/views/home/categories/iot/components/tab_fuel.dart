// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/constants/app_defaults.dart';

class TabFuel extends StatefulWidget {
  const TabFuel({Key? key}) : super(key: key);

  @override
  _TabFuelState createState() => _TabFuelState();
}

String _convertDriveLink(String driveUrl) {
  final fileId = driveUrl.split('/d/')[1].split('/')[0];
  return 'https://drive.google.com/uc?export=view&id=$fileId';
}

class _TabFuelState extends State<TabFuel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 21, 38),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: AppDefaults.borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: _convertDriveLink(
                          "https://drive.google.com/file/d/1rkT2KfZCAvLZynktuLueuFQJJiczTqC3/view?usp=sharing"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white,
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'PRODUK KAMI',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'ONE STOP SOLUTION',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 2.5,
              children: [
                _buildProductCard('RPM Monitoring', Icons.speed),
                _buildProductCard('Bunker Monitoring System', Icons.camera_alt),
                _buildProductCard('Fuel Monitoring System', Icons.wifi),
                _buildProductCard('Tank Monitoring System',
                    Icons.battery_charging_full_rounded),
                _buildProductCard(
                    'Engine Monitoring System', Icons.engineering),
                _buildProductCard('Flowmeter', Icons.water),
              ],
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'BENEFIT FTM',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'OPTIMALISASI & EFISIENSI',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            Column(
              children: [
                _buildBenefitItem(
                    'Easy to Analyze', Icons.directions_car_filled_rounded),
                _buildBenefitItem('Cost Awareness', Icons.settings),
                _buildBenefitItem('Optimizing Cost', Icons.engineering_rounded),
                _buildBenefitItem('Protecting Asset', FontAwesomeIcons.shield),
                _buildBenefitItem('After Sales Support', Icons.support_agent),
                _buildBenefitItem('Investment in Technology', Icons.grade),
                _buildBenefitItem('Daily Reporting', Icons.book),
                _buildBenefitItem('Engineering Teams', Icons.people),
              ],
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'MENGENAL FTMS',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'FUEL TRACK MONITORING SYSTEM',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Fuel Monitoring System adalah solusi teknologis canggih yang dirancang untuk melacak, menganalisis, dan mengelola konsumsi bahan bakar dalam berbagai aplikasi. Sistem ini menggunakan kombinasi komponen keras dan perangkat lunak untuk memberikan wawasan real-time terhadap pola penggunaan bahan bakar, mengidentifikasi ketidakefisienan, dan pada akhirnya mengurangi biaya operasional. Komponen inti dari FMS meliputi sensor bahan bakar, teknologi GPS, perekam data, dan platform perangkat lunak terpusat.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: 20,
                  bottom: 20,
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: AppDefaults.borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: _convertDriveLink(
                          "https://drive.google.com/file/d/1uZCnR8QTvdatMIKCsyRViPvyGt_U9vZ3/view?usp=sharing"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white,
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Pemantauan bahan bakar menjadi faktor kunci dalam manajemen armada kendaraan. Fuel Track Monitoring System (FTMS) hadir sebagai solusi cerdas yang mampu memberikan kontrol dan juga pengelolaan penggunaan bahan bakar yang lebih efektif termasuk digital fuel meter.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'CARA KERJA',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'MENGENAL CARA KERJA FTMS',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'FMS terdiri dari beberapa komponen utama yang bekerja secara bersamaan untuk memberikan informasi yang akurat dan real-time mengenai konsumsi bahan bakar. Berikut adalah langkah-langkah umum dalam cara kerja fuel monitoring:',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: 20,
                  bottom: 20,
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: AppDefaults.borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: _convertDriveLink(
                          "https://drive.google.com/file/d/1ybcAgHKgUcBpxkMn-6KUwRSbWBnsidv8/view?usp=sharing"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white,
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                '''
• Fuel Sensor: FMS umumnya menggunakan sensor bahan bakar yang dipasang di tangki bahan bakar kendaraan atau mesin. Sensor ini mengukur level bahan bakar dan mengirimkan data real-time ke sistem pemantauan pusat.
• Teknologi GPS: Integrasi teknologi GPS memungkinkan FMS tidak hanya memantau konsumsi bahan bakar, tetapi juga melacak lokasi dan pergerakan kendaraan atau peralatan. Fitur ini menambah lapisan visibilitas ekstra, membantu dalam optimasi rute, dan meningkatkan efisiensi operasional secara keseluruhan.
• Perekam Data: Perekam data mengumpulkan dan menyimpan informasi yang dikumpulkan oleh sensor bahan bakar dan teknologi GPS. Data ini menjadi dasar untuk laporan dan analisis yang mendalam, memungkinkan pengambilan keputusan yang berbasis informasi.
• Pengiriman Data: Data yang telah di olah dalam perekaman data akan di kirim secara berkala dengan interval sesuai kebutuhan untuk dapat di sajikan dalam informasi perangkat lunak (Aplikasi GeoTraking)
Platform Perangkat Lunak Terpusat: Inti dari Setiap Fuel Monitoring System adalah platform perangkat lunak terpusatnya. Platform ini memproses data yang masuk, menghasilkan laporan, dan menyediakan antarmuka yang ramah pengguna bagi administrator untuk memantau dan mengelola aktivitas terkait bahan bakar.
''',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: 20,
                  bottom: 20,
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: AppDefaults.borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: _convertDriveLink(
                          "https://drive.google.com/file/d/1922Ih6cmAmmCgvQ8mcRUB0XRF2iSlsJJ/view?usp=sharing"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white,
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'PELAPORAN',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'LAPORAN PEMANTAUAN BAHAN BAKAR',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Konsumsi Bahan Bakar Bulanan',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Laporan Grafis tentang perubahan volume bahan bakar di tangki bahan bakar kendaraan dalam interval waktu yang dipilih.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(height: 7),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Laporan Jarak Tempuh',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Laporan grafis tentang efisiensi bahan bakar armada Anda dari data yang tersedia tentang bahan bakar yang dikonsumsi sesuai dengan jarak.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(height: 7),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Laporan Pengurasan Bahan Bakar',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Informasi tentang pengurasan bahan bakar dalam laporan tabel statistik dan kuantitas kejadian pengurasan serta total volume bahan bakar yang terkuras dari tangki.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(height: 7),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Laporan Isi Ulang Bahan Bakar',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Tabel laporan kejadian pengisian ulang (fill-up) dalam interval waktu yang dipilih. Setiap pengisian ulang yang terdeteksi memiliki info tentang: tanggal, waktu dan tempat kejadian, volume bahan bakar di awal/akhir kejadian, total volume bahan bakar yang diisi.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: 20,
                  bottom: 20,
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: AppDefaults.borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: _convertDriveLink(
                          "https://drive.google.com/file/d/1Q5xeTW3B3dOeEKNOBcwPO0J4O3JAWWWL/view?usp=sharing"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white,
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'SOLUSI SENSOR',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'JENIS TEKNOLOGI FLOWMETER',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                '1. OVAL FLOWMETER',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Oval Flowmeters adalah Flowmeter perpindahan positif akurasi tinggi untuk berbagai cairan termasuk air, minyak bumi, pelarut. Penghitung mekanis memungkinkan pemeriksaan debit total di lapangan. Flowmeter yang dilengkapi keluaran juga tersedia secara opsional.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      '''Oval Flowmeter (PD)
–Trough pipe technology; 
  Gear Operation
–Error Rates +/- 1%
–Volume and flowrate display
''',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 20,
                        bottom: 20,
                      ),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: AppDefaults.borderRadius,
                          child: CachedNetworkImage(
                            imageUrl: _convertDriveLink(
                                "https://drive.google.com/file/d/1kvuTQqgdF9Y3pVBI1cKnGmIBrAux-T3n/view?usp=sharing"),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.white,
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                '2. MACNAUGHT FLOWMETER',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Macnaught Flowmeter adalah alat pengukur aliran cairan yang menggunakan roda gigi oval perpindahan positif (positive displacement). Alat ini cocok untuk mengukur bahan bakar dan oli',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      '''KELEBIHAN
• Akurasi baik 
• Mampu mengukur cairan kental 
• Instalasi mudah 
• Tersedia dalam dua tipe counter 
• Tersedia dalam ukuran ½ Inch sampai 4 Inch 
• Jarang perlu di maintenance
''',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 20,
                        bottom: 20,
                      ),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: AppDefaults.borderRadius,
                          child: CachedNetworkImage(
                            imageUrl: _convertDriveLink(
                                "https://drive.google.com/file/d/13VWuk9_xYysIfsbz9eK0E1ALLCM0UdyH/view?usp=sharing"),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.white,
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                '3. CORIOLISFLOWMETER (MICROMOTION)',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 182, 100)),
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Flowmeter Coriolis adalah flowmeter massa untuk mengukur "massa" secara langsung dan terus-menerus, satu-satunya karakteristik fluida yang tidak terpengaruh oleh perubahan suhu, tekanan, viskositas, dan kepadatannya. Berdasarkan prinsip unik yang memanfaatkan gaya Coriolis, berbagai macam sistem berbasis laju aliran massa dapat dikonfigurasi dengan mendeteksi laju aliran massa dengan akurasi dan sensitivitas tinggi dan mengubahnya menjadi keluaran analog atau frekuensi. Selain cairan umum, laju aliran makanan, bahan kimia, bubur, gas dengan kepadatan tinggi, dll. dapat diukur. Fitur utama flowmeter Coriolis adalah sensor kompleks yang dapat mengukur suhu dan kepadatan secara bersamaan dengan laju aliran.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: AppDefaults.borderRadius,
                    child: CachedNetworkImage(
                      imageUrl: _convertDriveLink(
                          "https://drive.google.com/file/d/1SfxBQi06HP9h7jomRqDpOpdXL3cdMXI6/view?usp=sharing"),
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 130,
                        width: 130,
                        color: Colors.white,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white,
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 7),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                'Keunggulan Coriolis :',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                '''• Akurasi tinggi: Coriolis memiliki tingkat akurasi yang tinggi, biasanya mencapai 0,1% atau lebih. Akurasi ini lebih baik dibandingkan teknologi pengukur aliran lainnya, seperti pengukur aliran roda dayung yang biasanya hanya memiliki akurasi 2,5% hingga 5%.
• Fleksibilitas: Coriolis dapat mengukur berbagai jenis media, seperti cairan, gas, dan padatan.
• Pengukuran langsung: Coriolis dapat mengukur aliran massa secara langsung, tanpa perlu menambahkan instrumen pengukuran eksternal.
• Rentang suhu yang lebar: Coriolis dapat mengukur aliran cairan panas maupun dingin.
• Tidak memerlukan perawatan rutin: Coriolis tidak memerlukan perawatan rutin.
• Konstruksi kokoh: Coriolis memiliki konstruksi yang kokoh sehingga dapat bekerja dengan baik di lingkungan yang menuntut.
• Tidak memiliki penghalang internal: Coriolis tidak memiliki penghalang internal yang bisa rusak atau tersumbat.''',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildProductCard(String title, IconData icon) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
    ),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 25,
          ),
        ),
        Expanded(
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 3, 52, 110),
                  Color.fromARGB(255, 110, 172, 218),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBenefitItem(String title, IconData icon) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
    ),
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(15),
    child: Row(
      children: [

        Icon(
          icon,
          color: Colors.blue.shade900,
          size: 30,
        ),
        SizedBox(width: 13),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 17,
            ),
          ),
        ),
        Icon(Icons.check_circle, color: Colors.green),
      ],
    ),
  );
}