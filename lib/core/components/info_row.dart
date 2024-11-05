import 'package:flutter/material.dart';

Widget buildInfoRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(fontSize: 12),
        ),
      ),
    ],
  );
}

Widget buildInfoColumnInRow(
    String leftLabel, String leftValue, String rightLabel, String rightValue) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leftLabel,
              style: TextStyle(fontSize: 10),
            ),
            Text(
              leftValue,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rightLabel,
              style: TextStyle(fontSize: 10),
            ),
            Text(
              rightValue,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    ],
    // children: [
    //   Expanded(
    //     child: Text(
    //       label,
    //       style: TextStyle(fontSize: 12),
    //     ),
    //   ),
    //   Expanded(
    //     child: Text(
    //       value,
    //       style: TextStyle(fontSize: 12),
    //     ),
    //   ),
    // ],
  );
}
