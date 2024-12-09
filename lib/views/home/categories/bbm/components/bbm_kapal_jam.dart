// ignore_for_file: library_private_types_in_public_api, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';

class BbmKapalPerJamPage extends StatefulWidget {
  const BbmKapalPerJamPage({super.key});

  @override
  _BbmKapalPerJamPageState createState() => _BbmKapalPerJamPageState();
}

class _BbmKapalPerJamPageState extends State<BbmKapalPerJamPage> {
  final _formKey = GlobalKey<FormState>();
  double _fuelConsumption = 0.0;
  double _travelTime = 0.0;
  double _bbmKapal = 0.0;

  void _calculateBBM() {
    setState(() {
      if (_travelTime != 0 && _fuelConsumption != 0) {
        _bbmKapal = _fuelConsumption / _travelTime;
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
                  'Contoh:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 3),
                const Text(
                    'Kapal Zamrud Khatulistiwa berlayar dari Tanjung Perak, Surabaya ke Makassar selama 30 jam. Total bahan bakar yang terpakai selama berlayar diketahui sebesar 1.800 liter. Berapakah konsumsi bahan bakar kapal Zamrud Khatulistiwa per jamnya?'),
                const SizedBox(height: 5),
                Text(
                  'Penyelesaian:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const Text(
                    '- Konsumsi BBM per jam = total konsumsi BBM : total waktu berlayar'),
                const Text(
                    '- Konsumsi BBM = 1.800 liter : 30 jam = 60 liter/jam.'),
                const Divider(thickness: 0.5),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Konsumsi BBM (L)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Penggunaan Konsumsi BBM';
                    }
                    return null;
                  },
                  onSaved: (value) => _fuelConsumption = double.parse(value!),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Waktu Berlayar (Jam)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Lama Waktu Berlayarnya';
                    }
                    return null;
                  },
                  onSaved: (value) => _travelTime = double.parse(value!),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _fuelConsumption = 0.0;
                            _travelTime = 0.0;
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
                  'BBM: ${_bbmKapal} L/Jam',
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
