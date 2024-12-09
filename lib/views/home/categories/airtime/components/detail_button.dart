// ignore_for_file: prefer_function_declarations_over_variables, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';

class DetailButton extends StatelessWidget {
  const DetailButton({
    Key? key,
    required this.onSeeDetailAirtime,
    required this.onPembayaranAirtime,
  }) : super(key: key);

  final void Function() onSeeDetailAirtime;
  final void Function() onPembayaranAirtime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onSeeDetailAirtime,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  backgroundColor: Colors.blueAccent),
              child: Text(
                'Show List Airtime',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: onPembayaranAirtime,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  backgroundColor: Colors.redAccent),
              child: Text(
                'Perpanjang Airtime',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
