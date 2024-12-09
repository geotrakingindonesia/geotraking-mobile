// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, library_private_types_in_public_api, sized_box_for_whitespace, prefer_const_constructors, unused_local_variable, avoid_print

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/models/airtime.dart';
import 'package:geotraking/core/models/history_airtime.dart';
import 'package:geotraking/core/services/airtime_service.dart';
import 'package:geotraking/core/components/banner_rekening.dart';
import 'package:geotraking/views/home/categories/airtime/components/detail_button.dart';
import 'package:geotraking/views/home/categories/airtime/components/pembayaran_airtime_page.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class SearchAirtimePage extends StatefulWidget {
  const SearchAirtimePage({super.key});

  @override
  _SearchAirtimePageState createState() => _SearchAirtimePageState();
}

class _SearchAirtimePageState extends State<SearchAirtimePage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic>? _searchResult;
  List<HistoryAirtime>? history;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Row(
          children: [
            const Text('Airtime'),
            const SizedBox(width: 30),
            Expanded(
              child: Container(
                height: 40,
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Search ID..',
                    labelStyle: TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                      color: Colors.black,
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _search();
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.blue.shade100,
                  ),
                  onSubmitted: (value) {
                    _search();
                  },
                ),
              ),
            ),
          ],
        ),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
      ),
      body: Column(
        children: [
          const BannerRekening(),
          if (_searchResult != null)
            Expanded(
              child: ListView.builder(
                itemCount: _searchResult!.length,
                itemBuilder: (context, index) {
                  final result = _searchResult![index];
                  return _SearchResultLayout(
                    result: result,
                    history: history ?? [],
                    onPembayaranAirtime: () {
                      _showPembayaranAirtimePage(context, result);
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void _search() async {
    String idFull = _searchController.text;

    if (idFull.isNotEmpty) {
      try {
        final airtimeService = AirtimeService();
        final airtime = await airtimeService.getAirtime(idFull);
        final historyAirtime = await airtimeService.getHistoryAirtime(idFull);

        if (airtime != null) {
          print('Airtime data found: $airtime');
          final DateFormat formatter = DateFormat.yMd().add_Hms();
          setState(() {
            _searchResult = [airtime];
            history = historyAirtime;
          });
        } else {
          setState(() {
            _searchResult = null;
          });

          ElegantNotification.info(
            title: Text('Data not found.',
                style: TextStyle(color: Colors.white)),
            description: Text('May be because the ID is wrong or the ID is not your ship.',
                style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.info, color: Colors.white),
            background: Colors.transparent,
            position: Alignment.topCenter,
            animation: AnimationType.fromTop,
            showProgressIndicator: true,
            displayCloseButton: false,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70,
            borderRadius: BorderRadius.circular(10),
          ).show(context);

          print('Data tidak ditemukan');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void _showPembayaranAirtimePage(BuildContext context, result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PembayaranAirtimePage(
          airtime: result,
        ),
      ),
    );
  }
}

class _SearchResultLayout extends StatelessWidget {
  final Airtime result;
  final List<HistoryAirtime> history;
  final VoidCallback onPembayaranAirtime;

  const _SearchResultLayout(
      {required this.result,
      required this.history,
      required this.onPembayaranAirtime});

  Future<void> _showDetailAirtime(BuildContext context) async {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 180, top: 5, right: 180),
              child: Divider(
                color: Colors.black54,
                thickness: 3,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Airtime Start:',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Airtime End:',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            final h = history[index];
                            return Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('d MMMM y').format(
                                            DateTime.parse(
                                                '${h.airtimestart}')),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('d MMMM y').format(
                                            DateTime.parse('${h.airtimeend}')),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime? atpEndDateTime;
    if (result.atp_end != null && result.atp_end!.isNotEmpty) {
      atpEndDateTime = DateTime.parse(result.atp_end!);
    }
    bool _isExpired = atpEndDateTime != null && atpEndDateTime.isBefore(now);
    // bool _isExpired = result.atp_end != null && result.atp_end!.isBefore(now);

    final lat = result.lat;
    final lon = result.lon;

    String _formatLatitude(double? lat) {
      if (lat == null) return '';
      int degrees = lat.toInt();
      double minutes = (lat - degrees) * 60;
      int minutesInt = minutes.toInt();
      double seconds = (minutes - minutesInt) * 60;
      return '${degrees.abs()} ${degrees < 0 ? 'S' : 'N'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
    }

    String _formatLongitude(double? lon) {
      if (lon == null) return '';
      int degrees = lon.toInt();
      double minutes = (lon - degrees) * 60;
      int minutesInt = minutes.toInt();
      double seconds = (minutes - minutesInt) * 60;
      return '${degrees.abs()} ${degrees < 0 ? 'W' : 'E'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
    }

    Widget _getMarkerImage(String? timestamp, String? heading) {
      if (timestamp == null) return Container();

      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      Widget _rotatedContainer(Widget child) {
        return Transform.rotate(
          angle: heading != null ? double.parse(heading) * pi / 180 : 0,
          child: Container(
            width: 30,
            height: 30,
            child: child,
          ),
        );
      }

      if (difference.inMinutes < 72) {
        return _rotatedContainer(
          Image.asset('assets/images/kapal-hijau.png', fit: BoxFit.contain),
        );
      } else if (difference.inMinutes < 120) {
        return _rotatedContainer(
          Image.asset('assets/images/kapal-kuning.png', fit: BoxFit.contain),
        );
      } else if (difference.inHours < 168) {
        return _rotatedContainer(
          Image.asset('assets/images/kapal-orange.png', fit: BoxFit.contain),
        );
      } else {
        return _rotatedContainer(
          Image.asset('assets/images/kapal-hijau.png', fit: BoxFit.contain),
        );
      }
    }

    return Padding(
      // padding: const EdgeInsets.all(AppDefaults.padding),
      padding: const EdgeInsets.only(
          left: AppDefaults.padding, right: AppDefaults.padding),
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
                        Text('ID:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${result.idfull}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nama Kapal:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${result.namaKapal}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.4, color: Colors.black),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SN:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${result.sn}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('IMEI:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${result.imei}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.4, color: Colors.black),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Latitude:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${_formatLatitude(result.lat)}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Longtitude:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${_formatLongitude(result.lon)}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.4, color: Colors.black),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Vessel Type:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${result.type}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Category:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${result.kategori}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.4, color: Colors.black),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Owner:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${result.custamer}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.4, color: Colors.black),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Received Date:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          DateFormat('d MMMM y (HH:mm:ss)')
                              .format(DateTime.parse('${result.timestamp}')),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.4, color: Colors.black),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Broadcast Date:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          DateFormat('d MMMM y (HH:mm:ss)')
                              .format(DateTime.parse('${result.broadcast}')),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.4, color: Colors.black),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Heading:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${result.heading}°',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Speed:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          // '${result.speed} knot',
                          '${result.speedKn} Knot/${result.speedKmh} Kmh',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.4, color: Colors.black),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Power Source:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${result.powerstatus}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Power Value:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          '${result.externalvoltage} kwh',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.4, color: Colors.black),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Atp Start:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          DateFormat('d MMMM y')
                              .format(DateTime.parse('${result.atp_start}')),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Atp End:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                        Text(
                          DateFormat('d MMMM y')
                              .format(DateTime.parse('${result.atp_end}')),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.4, color: Colors.black),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Container(
                        height: 150,
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(result.lat!, result.lon!),
                            initialZoom: 4,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(result.lat!, result.lon!),
                                  width: 30,
                                  height: 30,
                                  child: _getMarkerImage(
                                    result.timestamp!,
                                    result.heading!.toString(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 0.4, color: Colors.black),
              DetailButton(
                onSeeDetailAirtime: () async {
                  _showDetailAirtime(context);
                },
                onPembayaranAirtime: onPembayaranAirtime,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
