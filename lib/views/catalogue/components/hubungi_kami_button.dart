// ignore_for_file: prefer_function_declarations_over_variables, deprecated_member_use, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import '../../../core/constants/app_defaults.dart';

class HubungiKamiButton extends StatelessWidget {
  HubungiKamiButton({
    Key? key,
    required this.onHubungiKamiButtonTap,
  }) : super(key: key);

  final void Function() onHubungiKamiButtonTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onHubungiKamiButtonTap,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(AppDefaults.padding * 1.2),
                  backgroundColor: const Color.fromARGB(255, 113, 201, 206)),
              child: Text(
                'Hubungi Kami',
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
