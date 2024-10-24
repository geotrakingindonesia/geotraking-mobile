// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/constants.dart';

class TabPenangkapan extends StatelessWidget {
  const TabPenangkapan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text('Back'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 127, 183, 126),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data Penangkapan',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Colors.white60,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Jenis Ikan',
                                  style: TextStyle(color: Colors.white60),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ': Salmon',
                                  style: TextStyle(color: Colors.white60),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Dimensi rerata Ikan',
                                  style: TextStyle(color: Colors.white60),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ': 20(cm)',
                                  style: TextStyle(color: Colors.white60),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Tanggal Tangkap',
                                  style: TextStyle(color: Colors.white60),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ': 10 January 2024',
                                  style: TextStyle(color: Colors.white60),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Bobot Estimasi Keseluruhan',
                                  style: TextStyle(color: Colors.white60),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ': 100 Kg',
                                  style: TextStyle(color: Colors.white60),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Area Penangkapan',
                                  style: TextStyle(color: Colors.white60),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ': WppRi-571',
                                  style: TextStyle(color: Colors.white60),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
