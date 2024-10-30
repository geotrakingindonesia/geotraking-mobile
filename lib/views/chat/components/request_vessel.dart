// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/services/vessel_service.dart';

class RequestVessel extends StatefulWidget {
  const RequestVessel({super.key});

  @override
  _RequestVesselState createState() => _RequestVesselState();
}

class _RequestVesselState extends State<RequestVessel> {
  final VesselService vesselService = VesselService();
  List<Map<String, dynamic>>? _vesselList;
  List<String> selectedVessels = [];

  @override
  void initState() {
    super.initState();
    _fetchVessel();
  }

  Future _fetchVessel() async {
    try {
      final vesselList = await vesselService.getDataKapal();
      print(vesselList);
      setState(() {
        _vesselList = vesselList;
      });
    } catch (e) {
      setState(() {
        print('Error fetching kapal: $e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Request Iridium EGDE'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Cari kapal yang ingin menggunakan Iridium EDGE.',
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              DropdownSearch<String>.multiSelection(
                items: (filter, s) =>
                    _vesselList
                        ?.map((vessel) => vessel['nama_kapal'] as String)
                        .toList() ??
                    [],
                onChanged: (value) {
                  setState(() {
                    selectedVessels = value;
                  });
                },
                popupProps: PopupPropsMultiSelection.bottomSheet(
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.red, width: 1),
                      ),
                    ),
                  ),
                  bottomSheetProps: BottomSheetProps(
                    backgroundColor: Colors.white,
                  ),
                  showSearchBox: true,
                ),
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Kapal yang anda pilih',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ...selectedVessels.map((vessel) => Text(vessel)).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(AppDefaults.padding),
              backgroundColor: Color.fromARGB(255, 243, 182, 100),
              minimumSize: Size(double.infinity, 0),
            ),
            child: Text(
              'Ajukan Permintaan',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
