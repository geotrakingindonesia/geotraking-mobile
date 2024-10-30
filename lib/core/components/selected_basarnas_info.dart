// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/models/basarnas.dart';

class SelectedBasarnasInfo extends StatelessWidget {
  final Basarnas? selectedBasarnas;
  final VoidCallback onClose;

  const SelectedBasarnasInfo({
    Key? key,
    required this.selectedBasarnas,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedBasarnas == null) return Container();

    return Positioned(
      bottom: 10,
      left: 10,
      child: Stack(
        children: [
          FadeInLeft(
            duration: Duration(milliseconds: 1300),
            child: Container(
              width: 300,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nama Basarnas: ${selectedBasarnas?.namaBasarnas}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    Divider(thickness: 0.5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Tipe Basarnas: ${selectedBasarnas?.tipe}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    Divider(thickness: 0.5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Latitude: ${selectedBasarnas?.lat}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    Divider(thickness: 0.5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Longitude: ${selectedBasarnas?.lon}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: onClose,
            ),
          ),
        ],
      ),
    );
  }
}
