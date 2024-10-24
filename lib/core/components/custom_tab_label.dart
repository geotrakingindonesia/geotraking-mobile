import 'package:flutter/material.dart';

class CustomTabLabel extends StatelessWidget {
  final String label;

  const CustomTabLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
