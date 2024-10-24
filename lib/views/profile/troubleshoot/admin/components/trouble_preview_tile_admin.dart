// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';

class TroublePreviewTileAdmin extends StatelessWidget {
  const TroublePreviewTileAdmin({
    Key? key,
    required this.idfull,
    this.namaKapal,
    this.nameMember,
    this.custamer,
    this.date,
    this.time,
    this.status,
    this.onTap,
    this.onFinished,
  }) : super(key: key);

  final String idfull;
  final String? namaKapal;
  final String? nameMember;
  final String? custamer;
  final String? date;
  final String? time;
  final int? status;
  final void Function()? onTap;
  final void Function()? onFinished;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: 6,
      ),
      child: Material(
        borderRadius: AppDefaults.borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppDefaults.borderRadius,
          child: Container(
            padding: const EdgeInsets.all(AppDefaults.padding),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: AppDefaults.borderRadius,
              gradient: LinearGradient(begin: Alignment.bottomLeft, colors: [
                Color.fromARGB(255, 203, 241, 245),
                Color.fromARGB(255, 227, 253, 253),
                Colors.white
              ]),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          idfull,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '(${nameMember!})',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(namaKapal ?? '-'),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(custamer ?? '-'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 16,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          date!,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        // Text(date),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_alarm_rounded,
                          size: 16,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          time!,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: _orderColor(status!),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getStatusText(status!),
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                if (status != 2)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          // onPressed: () {},
                          onPressed: onFinished,
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.all(AppDefaults.padding),
                              backgroundColor:
                                  Color.fromARGB(255, 113, 201, 206)
                                      .withOpacity(0.8)),
                          child: Text(
                            'Finished',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return 'Sent';
      case 1:
        return 'In Process';
      case 2:
        return 'Finished';
      default:
        return 'Unknown';
    }
  }

  Color _orderColor(int status) {
    switch (status) {
      case 0:
        return const Color(0xFFE19603);
      case 1:
        return const Color(0xFF41A954);
      case 2:
        return const Color(0xFF4044AA);
      default:
        return Colors.red;
    }
  }
}
