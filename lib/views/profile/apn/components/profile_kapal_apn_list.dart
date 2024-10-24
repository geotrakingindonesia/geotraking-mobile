// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/views/profile/apn/components/profile_kapal_apn_preview_tile.dart';

class ProfileKapalAPNList extends StatefulWidget {
  const ProfileKapalAPNList({Key? key}) : super(key: key);

  @override
  State<ProfileKapalAPNList> createState() => _ProfileKapalAPNListState();
}

class _ProfileKapalAPNListState extends State<ProfileKapalAPNList> {
  final VesselService vesselService = VesselService();
  String? _errorMessage;
  String _searchQuery = '';

  List<Map<String, dynamic>> _kapalAPNList = [];
  List<Map<String, dynamic>> _pagedData = [];

  Future<void>? _fetchKapalAPNFuture;

  @override
  void initState() {
    super.initState();
    _fetchKapalAPNFuture = _fetchKapalAPN();
  }

  Future<void> _fetchKapalAPN() async {
    try {
      final kapalAPNList = await vesselService.getDataKapalAPN();
      setState(() {
        _kapalAPNList = kapalAPNList ?? [];
        _pagedData = kapalAPNList ?? [];
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  void _searchKapalAPN(String query) {
    setState(() {
      _pagedData = _kapalAPNList.where((element) {
        return (element['mobile_id']
                    ?.toLowerCase()
                    ?.contains(query.toLowerCase()) ??
                false) ||
            (element['vessel_name']
                    ?.toLowerCase()
                    ?.contains(query.toLowerCase()) ??
                false);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchKapalAPNFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Getting Data',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black),
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Cari Id Kapal / Nama kapal',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                        _searchKapalAPN(query);
                      });
                    },
                  ),
                ),
                Column(
                  children: [
                    Text(
                      _searchQuery.isEmpty
                          ? '${_kapalAPNList.length} Vessel Data'
                          : _pagedData.isEmpty
                              ? 'Vessel Not Found.'
                              : '${_pagedData.length} Vessel Found.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    ListView.builder(
                      itemCount: _pagedData.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: ProfileKapalAPNPreviewTile(
                            mobileId: _pagedData[index]['mobile_id'] ?? '-',
                            idfull: _pagedData[index]['idfull'] ?? '-',
                            legalName: _pagedData[index]['legal_name'] ?? '-',
                            sn: _pagedData[index]['sn'] ?? '-',
                            imei: _pagedData[index]['imei'] ?? '-',
                            namaKapal: _pagedData[index]['vessel_name'] ?? '-',
                            kategori: _pagedData[index]['category_name'] ?? '-',
                            type: _pagedData[index]['type_name'] ?? '-',
                            lat: _pagedData[index]['latitude'] ?? '0',
                            lon: _pagedData[index]['longitude'] ?? '0',
                            speed: _pagedData[index]['speed'] ?? '0',
                            heading: _pagedData[index]['heading'] ?? '0',
                            powerStatus:
                                _pagedData[index]['powerstatus'] ?? '-',
                            externalVoltage:
                                _pagedData[index]['externalvoltage'] ?? '0',
                            distance: _pagedData[index]['distance'] ?? '-',
                            flag: _pagedData[index]['flag_country_name'] ?? '-',
                            timestamp: _pagedData[index]['timestamp']
                                    ?.toIso8601String() ??
                                '-',
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }
}
