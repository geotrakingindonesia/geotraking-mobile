// ignore_for_file: library_private_types_in_public_api, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';

class BbmKapalPage extends StatefulWidget {
  const BbmKapalPage({super.key});

  @override
  _BbmKapalPageState createState() => _BbmKapalPageState();
}

class _BbmKapalPageState extends State<BbmKapalPage> {
  final _formKey = GlobalKey<FormState>();
  double _jumlahMesin = 0.0;
  double _jumlahHpMesin = 0.0;
  double _usiaMesin = 0.0;
  double _waktuBerlayar = 0.0;
  double _bbmKapal = 0.0;
  double _hasil = 0.0;

  void _calculateBBM() {
    setState(() {
      double umurKoefisien = _usiaMesin < 5 ? 0.08 : 0.20;
      if (_jumlahMesin != 0 && _jumlahHpMesin != 0) {
        _bbmKapal = (_jumlahMesin * _jumlahHpMesin) * 0.85 * umurKoefisien;
        _hasil = _bbmKapal * _waktuBerlayar;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Note:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 3),
                const Text(
                    'HP: daya maksimal yang mampu dikeluarkan oleh mesin kapal (dalam HP – horse power)'),
                const Text(
                    'BJ: berat jenis bahan bakar. Untuk solar, berat jenisnya adalah 0,8-0,86 kg/liter, tergantung suhu dan tekanan. Tapi, untuk mudahnya, kita ambil 0,85 kg/liter.'),
                const Text(
                    'KoM: koefisien umur mesin. Angkanya bervariasi dari 0,08 untuk mesin di bawah 5 tahun, hingga 0,20 untuk mesin usia 20 tahun.'),
                const SizedBox(height: 5),
                Text(
                  'Contoh:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 3),
                const Text(
                    'Kapal Permata Nusantara memiliki 2 mesin kapal, masing-masing 500 HP. Berapa konsumsi solar mesin tersebut untuk waktu pelayaran 8 jam. Diketahui usia mesin kapal 2 tahun.'),
                const SizedBox(height: 5),
                Text(
                  'Penyelesaian:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const Text('- Konsumsi BBM per jam = HP x BJ x KoM'),
                const Text(
                    '- Konsumsi BBM = (2 x 500) x 0,85 x 0,08 = 1.000 x 0,85 x 0,08 = 68 liter/jam.'),
                const Text(
                    '- Jika kapal berlayar selama 8 jam, maka butuh bahan bakar solar minimal = 68 x 8 = 544 liter.'),
                const Divider(thickness: 0.5),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Jumlah Mesin',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan Jumlah Mesin Kapal';
                          }
                          return null;
                        },
                        onSaved: (value) => _jumlahMesin = double.parse(value!),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Jumlah Hp Mesin',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan Jumlah Hp Mesin';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _jumlahHpMesin = double.parse(value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Waktu Berlayar (Jam)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Waktu Berlayar';
                    }
                    return null;
                  },
                  onSaved: (value) => _waktuBerlayar = double.parse(value!),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Usia Mesin(Pertahun)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Usia Mesin';
                    }
                    return null;
                  },
                  onSaved: (value) => _usiaMesin = double.parse(value!),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _jumlahMesin = 0.0;
                            _jumlahHpMesin = 0.0;
                            _waktuBerlayar = 0.0;
                            _usiaMesin = 0.0;
                            _bbmKapal = 0.0;
                          });
                          _formKey.currentState!.reset();
                        },
                        style: ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets.all(AppDefaults.padding * 1.2),
                            backgroundColor: Colors.black12),
                        child: Text(
                          'Reset',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _calculateBBM();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets.all(AppDefaults.padding * 1.2),
                            backgroundColor:
                                const Color.fromARGB(200, 0, 173, 72)),
                        child: Text(
                          'Hitung',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 0.5),
                Text(
                  'BBM: ${_hasil} L',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
