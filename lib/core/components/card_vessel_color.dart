import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

Color cardVesselColor(String timestamp) {
  final parsedTimestamp = DateTime.parse(timestamp);
  final now = DateTime.now();
  final difference = now.difference(parsedTimestamp);

  if (difference.inMinutes < 72) {
    return Color.fromARGB(255, 127, 183, 126);
  } else if (difference.inMinutes < 120) {
    return Color.fromARGB(255, 255, 222, 77);
  } else if (difference.inDays < 7) {
    return Color.fromARGB(255, 243, 182, 100);
  } else {
    return Color.fromARGB(255, 117, 134, 148);
  }
}

Color cardTextColor(String timestamp) {
  final parsedTimestamp = DateTime.parse(timestamp);
  final now = DateTime.now();
  final difference = now.difference(parsedTimestamp);

  if (difference.inMinutes < 72) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}

Color cardHeadlineTextColor(String timestamp) {
  final parsedTimestamp = DateTime.parse(timestamp);
  final now = DateTime.now();
  final difference = now.difference(parsedTimestamp);

  if (difference.inMinutes < 72) {
    return Colors.white60;
  } else {
    return Colors.black54;
  }
}

Color reportVesselColor(String speed) {
  double speedValue = double.tryParse(speed) ?? 0.0;
  if (speedValue < 1.0) {
    return Color.fromARGB(255, 249, 84, 84);
  } else {
    return Color.fromARGB(255, 127, 183, 126);
  }
}

// Color cardWeatherVessel(String receivedDate) {
//   DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(receivedDate);
//   int hour = dateTime.hour;

//   if (hour >= 18 || hour < 6) {
//     return Color.fromARGB(255, 27, 38, 44);
//   } else {
//     return Color.fromARGB(255, 50, 130, 184);
//   }
// }
