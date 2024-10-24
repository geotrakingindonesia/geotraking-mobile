import 'package:flutter/material.dart';

class CustomTabLabel extends StatelessWidget {
  const CustomTabLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
        ),
      ],
    );
  }
}
