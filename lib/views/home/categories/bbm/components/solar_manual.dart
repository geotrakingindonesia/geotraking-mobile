// ignore_for_file: library_private_types_in_public_api, unnecessary_brace_in_string_interps, prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class SolarManualPage extends StatefulWidget {
  const SolarManualPage({super.key});

  @override
  _SolarManualPageState createState() => _SolarManualPageState();
}

class _SolarManualPageState extends State<SolarManualPage> {
  final _formKey = GlobalKey<FormState>();
  double _robSebelumBerlayar = 0.0;
  double _robSesudahBerlayar = 0.0;
  DateTime _waktuBerlayarAwal = DateTime.now();
  DateTime _waktuBerlayarAkhir = DateTime.now();
  double _letakWaktuBerangkat = 0.0;
  double _letakWaktuSampai = 0.0;
  double _bbmKapal = 0.0;
  double totalHours = 0.0;
  double _totalHours = 0.0;
  double _hasil = 0.0;

  void _calculateBBM() {
    setState(() {
      final difference = _waktuBerlayarAkhir.difference(_waktuBerlayarAwal);
      double totalHours = difference.inHours.toDouble();

      if (_letakWaktuBerangkat == 0 && _letakWaktuSampai == 1) {
        totalHours -= 1;
      } else if (_letakWaktuBerangkat == 0 && _letakWaktuSampai == 2) {
        totalHours -= 2;
      } else if (_letakWaktuBerangkat == 1 && _letakWaktuSampai == 0) {
        totalHours += 1;
      } else if (_letakWaktuBerangkat == 1 && _letakWaktuSampai == 2) {
        totalHours -= 1;
      } else if (_letakWaktuBerangkat == 2 && _letakWaktuSampai == 0) {
        totalHours += 2;
      } else if (_letakWaktuBerangkat == 2 && _letakWaktuSampai == 1) {
        totalHours += 1;
      }

      if (_robSebelumBerlayar != 0 && _robSesudahBerlayar != 0) {
        _bbmKapal = _robSebelumBerlayar - _robSesudahBerlayar;
        _totalHours = totalHours;
        _hasil = _bbmKapal / _totalHours;
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
                    'Kapal Intan Berlian berlayar dari pelabuhan Tanjung Priok di Jakarta menuju Pelabuhan Makassar. Waktu berangkat di hari Sabtu, jam 13.00 WIB dan sampai di tujuan pada hari Senin, jam 18.00 WITA. Hasil sounding sebelum berlayar menunjukkan ROB solar = 4.196 liter, sedangkan hasil sounding setelah sampai di Makassar menunjukkan ROB = 1.344 liter. Berapa konsumsi solar kapal Intan Berlian pada perjalanan tersebut?'),
                const SizedBox(height: 5),
                Text(
                  'Penyelesaian:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const Text(
                    '- Konsumsi BBM = ROB sebelum berlayar – ROB sesudah berlayar = 4.196 – 1.344 = 2.852 liter'),
                const Text(
                    '- Total waktu berlayar =\nSabtu: pukul 13.00 – 24.00 = 11 jam\nMinggu = 24 jam\nSenin: 13 jam\nMinus 1 jam karena menembus 1 zona waktu yang lebih cepat.\nTotal waktu berlayar = (11 + 24 + 13) – 1 = 46 jam.'),
                const Text(
                    '- Jadi, konsumsi solar kapal Intan Berlian = 2.852 liter : 46 jam = 62 liter per jam.'),
                const Divider(thickness: 0.5),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'ROB Sebelum Berlayar',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan ROB Sebelum Berlayar';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _robSebelumBerlayar = double.parse(value!),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'ROB Sesudah Berlayar',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan ROB Sesudah Berlayar';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _robSesudahBerlayar = double.parse(value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Waktu Awal Berlayar'),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderDateTimePicker(
                        name: 'waktu_berangkat_berlayar',
                        initialValue: DateTime.now(),
                        decoration: const InputDecoration(
                          labelText: 'Waktu Berangkat Berlayar',
                        ),
                        inputType: InputType.both,
                        format: DateFormat('yyyy-MM-dd HH:mm'),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              _waktuBerlayarAwal = value;
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: 'WIB', // set the initial value
                        onChanged: (value) {
                          setState(() {
                            if (value == 'WIB') {
                              _letakWaktuBerangkat = 0;
                            } else if (value == 'WITA') {
                              _letakWaktuBerangkat = 1;
                            } else if (value == 'WIT') {
                              _letakWaktuBerangkat = 2;
                            }
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'WIB',
                            child: Text('WIB'),
                          ),
                          DropdownMenuItem(
                            value: 'WITA',
                            child: Text('WITA'),
                          ),
                          DropdownMenuItem(
                            value: 'WIT',
                            child: Text('WIT'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Waktu Akhir Berlayar'),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderDateTimePicker(
                        name: 'waktu_sampai_berlayar',
                        initialValue: DateTime.now(),
                        decoration: const InputDecoration(
                          labelText: 'Waktu Sampai Berlayar',
                        ),
                        inputType: InputType.both,
                        format: DateFormat('yyyy-MM-dd HH:mm'),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              _waktuBerlayarAkhir = value;
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: 'WIB', // set the initial value
                        onChanged: (value) {
                          setState(() {
                            if (value == 'WIB') {
                              _letakWaktuSampai = 0;
                            } else if (value == 'WITA') {
                              _letakWaktuSampai = 1;
                            } else if (value == 'WIT') {
                              _letakWaktuSampai = 2;
                            }
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            value: 'WIB',
                            child: Text('WIB'),
                          ),
                          DropdownMenuItem(
                            value: 'WITA',
                            child: Text('WITA'),
                          ),
                          DropdownMenuItem(
                            value: 'WIT',
                            child: Text('WIT'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _robSebelumBerlayar = 0.0;
                            _robSesudahBerlayar = 0.0;
                            _waktuBerlayarAwal = DateTime.now();
                            _waktuBerlayarAkhir = DateTime.now();
                            _letakWaktuBerangkat = 0.0;
                            _letakWaktuSampai = 0.0;
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
                  'BBM: ${_hasil} L/Jam',
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
