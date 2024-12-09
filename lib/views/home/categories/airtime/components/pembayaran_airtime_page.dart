// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, library_private_types_in_public_api, unused_local_variable, unnecessary_null_comparison, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/models/airtime.dart';
import 'package:geotraking/core/services/airtime_service.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
// import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/components/banner_rekening.dart';

class PembayaranAirtimePage extends StatefulWidget {
  final Airtime airtime;
  // final String idFull;
  // final String namaKapal;
  // final String atpEnd;

  const PembayaranAirtimePage({
    Key? key,
    required this.airtime,
    // required this.idFull,
    // required this.namaKapal,
    // required this.atpEnd,
  }) : super(key: key);

  @override
  _PembayaranAirtimePageState createState() => _PembayaranAirtimePageState();
}

class _PembayaranAirtimePageState extends State<PembayaranAirtimePage> {
  // String? _namaKapal;
  final _key = GlobalKey<FormState>();
  // final statusPaymentMemberService = StatusPaymentMemberService();
  AirtimeService airtimeService = AirtimeService();
  String? _errorMessage;

  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // _fetchData();
  }

  _checkLoggedIn() async {
    final authService = AuthService();
    final user = await authService.getCurrentUser();
    if (user != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  onSimpanPerpanjanganAirtime() async {
    // if (_key.currentState!.validate()) {
    //   _key.currentState?.save();
    // }
    try {
      await airtimeService.storePembayaranAirtime(widget.airtime.mobileId!);
      _onSuccess();
      setState(() {});
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  _onSuccess() {
    _showSnackbar(
        'Berhasil konfirmasi, lihat di menu status payment pada profile untuk detailnya.');
  }

  void _launchWhatsApp() async {
    final namaKapal = 'Kapal A';
    final snImeiId = '123456789 (SN/IMEI/ID)';
    final owner = 'John Doe';

    final message = '''
Hi Admin,
Saya sudah membayar airtime,
Mohon konfirmasi.
''';

    final phoneNumber = '628111313081';
    final whatsappUrl =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    bool _isExpired = widget.airtime.atp_end != null &&
        DateTime.parse(widget.airtime.atp_end!.toString()).isBefore(now);

    DateTime atpSelanjutnya = DateTime.parse(widget.airtime.atp_end!.toString())
        .add(const Duration(days: 365));

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Perpanjang Airtime'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const BannerRekening(),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
            child: Card(
              color: _isExpired ? Colors.red.shade100 : Colors.orange.shade200,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID Kapal',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(':',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.airtime.idfull ?? '',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 0.5, color: Colors.black),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama Kapal',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(':',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.airtime.namaKapal ?? '',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 0.5, color: Colors.black),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Atp End',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(':',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.airtime.atp_end != null
                                    ? DateFormat('d MMMM y')
                                        // .format(widget.airtime.atp_end!)
                                        .format(DateTime.parse(
                                            widget.airtime.atp_end!))
                                    : '',
                                style: const TextStyle(color: Colors.black),
                              ),
                              // Text(
                              //   DateFormat('d MMMM y')
                              //       .format(DateTime.parse(widget.airtime.atp_end)),
                              //   style: const TextStyle(color: Colors.black),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 0.5, color: Colors.black),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Atp Selanjutnya',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(':',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('d MMMM y').format(atpSelanjutnya),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Tunggu sudah ada pembayaran-nya

                    // const SizedBox(height: 5),
                    // const Divider(thickness: 0.5, color: Colors.black),
                    // const SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     Form(
                    //       key: _key,
                    //       child: _isLoggedIn
                    //           ? Expanded(child: Container())
                    //           : Expanded(
                    //               child: Column(
                    //                 children: [
                    //                   ElevatedButton(
                    //                     // onPressed: onSimpanPerpanjanganAirtime,
                    //                     onPressed: _launchWhatsApp,
                    //                     style: ElevatedButton.styleFrom(
                    //                       padding: const EdgeInsets.all(
                    //                           AppDefaults.padding),
                    //                       backgroundColor: Colors.redAccent,
                    //                       minimumSize:
                    //                           Size(double.infinity, 40),
                    //                     ),
                    //                     child: Text(
                    //                       'Konfirmasi',
                    //                       style: Theme.of(context)
                    //                           .textTheme
                    //                           .titleSmall
                    //                           ?.copyWith(
                    //                             color: Colors.white,
                    //                           ),
                    //                     ),
                    //                   ),
                    //                   SizedBox(height: 10),
                    //                   ElevatedButton(
                    //                     onPressed: onSimpanPerpanjanganAirtime,
                    //                     style: ElevatedButton.styleFrom(
                    //                       padding: const EdgeInsets.all(
                    //                           AppDefaults.padding),
                    //                       backgroundColor: Colors.green,
                    //                       minimumSize:
                    //                           Size(double.infinity, 40),
                    //                     ),
                    //                     child: Text(
                    //                       'Lanjutkan Pembayaran',
                    //                       style: Theme.of(context)
                    //                           .textTheme
                    //                           .titleSmall
                    //                           ?.copyWith(
                    //                             color: Colors.white,
                    //                           ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
