// ignore_for_file: prefer_function_declarations_over_variables, deprecated_member_use, unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';

class DetailButtonWpp extends StatefulWidget {
  const DetailButtonWpp({
    Key? key,
    required this.onSeeDetailWpp,
    required this.onSeeDetailLatLong,
  }) : super(key: key);

  final VoidCallback onSeeDetailWpp;
  final VoidCallback onSeeDetailLatLong;

  @override
  _DetailButtonWppState createState() => _DetailButtonWppState();
}

class _DetailButtonWppState extends State<DetailButtonWpp> {
  bool _isDetailVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                widget.onSeeDetailWpp();
                setState(() {
                  _isDetailVisible = true;
                });
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  backgroundColor: Colors.blueAccent),
              child: Text(
                'Show Detail',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          // Spacer(),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                widget.onSeeDetailLatLong();
                setState(() {
                  _isDetailVisible = true;
                });
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  backgroundColor: Colors.pinkAccent),
              child: Text(
                'Show LatLong',
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


// import 'package:flutter/material.dart';
// import 'package:geotraking/core/constants/app_defaults.dart';

// class DetailButtonWpp extends StatefulWidget {
//   const DetailButtonWpp({
//     Key? key,
//     required this.onSeeDetailWpp,
//     required this.onSeeDetailLatLong,
//   }) : super(key: key);

//   final VoidCallback onSeeDetailWpp;
//   final VoidCallback onSeeDetailLatLong;

//   @override
//   _DetailButtonWppState createState() => _DetailButtonWppState();
// }

// class _DetailButtonWppState extends State<DetailButtonWpp> {
//   bool _isDetailVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: Row(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: ElevatedButton(
//                 onPressed: () {
//                   widget.onSeeDetailWpp();
//                   setState(() {
//                     _isDetailVisible = true;
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.all(AppDefaults.padding),
//                   backgroundColor: Colors.blueAccent,
//                 ),
//                 child: Text(
//                   'Show Detail',
//                   style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                         color: Colors.white,
//                       ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: ElevatedButton(
//                 onPressed: () {
//                   widget.onSeeDetailLatLong();
//                   setState(() {
//                     _isDetailVisible = true;
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.all(AppDefaults.padding),
//                   backgroundColor: Colors.pinkAccent,
//                 ),
//                 child: Text(
//                   'Show LatLong',
//                   style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                         color: Colors.white,
//                       ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
