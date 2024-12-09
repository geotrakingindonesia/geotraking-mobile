// // marker_image_widget.dart
// import 'dart:math';

// import 'package:flutter/material.dart';

// class MarkerImageWidget extends StatelessWidget {
//   final String? timestamp;
//   final String? heading;

//   MarkerImageWidget({this.timestamp, this.heading});

//   @override
//   Widget build(BuildContext context) {
//     if (timestamp == null) return Container();

//     final dateTime = DateTime.parse(timestamp!);
//     final now = DateTime.now();
//     final difference = now.difference(dateTime);

//     Widget _rotatedContainer(Widget child) {
//       return Transform.rotate(
//         angle: heading != null? double.parse(heading!) * pi / 180 : 0,
//         child: Container(
//           width: 30,
//           height: 30,
//           child: child,
//         ),
//       );
//     }

//     if (difference.inMinutes < 72) {
//       return _rotatedContainer(
//         Image.asset('assets/images/kapal-hijau.png', fit: BoxFit.contain),
//       );
//     } else if (difference.inMinutes < 120) {
//       return _rotatedContainer(
//         Image.asset('assets/images/kapal-kuning.png', fit: BoxFit.contain),
//       );
//     } else if (difference.inHours < 168) {
//       return _rotatedContainer(
//         Image.asset('assets/images/kapal-orange.png', fit: BoxFit.contain),
//       );
//     } else {
//       return _rotatedContainer(
//         Image.asset('assets/images/kapal-abu.png', fit: BoxFit.contain),
//       );
//     }
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';

class MarkerImageWidget extends StatelessWidget {
  final String? timestamp;
  final String? heading;

  MarkerImageWidget({this.timestamp, this.heading});

  @override
  Widget build(BuildContext context) {
    if (timestamp == null) return Container();

    final dateTime = DateTime.parse(timestamp!);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    double parseHeading(String? heading) {
      if (heading == null || heading.isEmpty) {
        return 0.0; // default 0 jika heading null or empty
      }
      try {
        return double.parse(heading);
      } catch (e) {
        print('Error parsing heading: $e');
        return 0.0; // default 0 jika parsing err
      }
    }

    Widget _rotatedContainer(Widget child) {
      final angle = parseHeading(heading) * pi / 180;
      return Transform.rotate(
        angle: angle,
        child: Container(
          width: 30,
          height: 30,
          child: child,
        ),
      );
    }

    if (difference.inMinutes < 72) {
      return _rotatedContainer(
        Image.asset('assets/images/kapal-hijau.png', fit: BoxFit.contain),
      );
    } else if (difference.inMinutes < 120) {
      return _rotatedContainer(
        Image.asset('assets/images/kapal-kuning.png', fit: BoxFit.contain),
      );
    } else if (difference.inHours < 168) {
      return _rotatedContainer(
        Image.asset('assets/images/kapal-orange.png', fit: BoxFit.contain),
      );
    } else {
      return _rotatedContainer(
        Image.asset('assets/images/kapal-abu.png', fit: BoxFit.contain),
      );
    }
  }
}
