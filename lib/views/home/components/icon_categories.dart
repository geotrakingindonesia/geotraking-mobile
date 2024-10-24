// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// import '../../../core/constants/constants.dart';

class IconsCategories extends StatelessWidget {
  const IconsCategories({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    // return Material(
    //   color: Colors.transparent,
    //   child: InkWell(
    //     onTap: onTap,
    //     borderRadius: AppDefaults.borderRadius,
    //     child: Padding(
    //       padding: const EdgeInsets.all(AppDefaults.padding),
    //       child: Column(
    //         children: [
    //           Container(
    //             width: 60,
    //             height: 60,
    //             decoration: const BoxDecoration(
    //               shape: BoxShape.circle,
    //               // color: Color.fromARGB(255, 100, 153, 233),
    //               color: Color.fromARGB(255, 113, 201, 206),
    //             ),
    //             child: Icon(
    //               icon,
    //               size: 20,
    //               // color: Colors.white,
    //               color: Color.fromARGB(255, 227, 253, 253),
    //             ),
    //           ),
    //           const SizedBox(height: 8),
    //           Text(label, style: TextStyle(fontSize: 12)
    //               // style: Theme.of(context)
    //               //     .textTheme
    //               //     .bodyMedium
    //               //     ?.copyWith(color: Colors.black),
    //               ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[50], 
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Color.fromARGB(255, 113, 201, 206),
              size: 25,
            ),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:geotraking/core/constants/app_defaults.dart';

// class IconsCategories extends StatelessWidget {
//   const IconsCategories({
//     Key? key,
//     required this.label,
//     required this.icon,
//     required this.onTap,
//   }) : super(key: key);

//   final String label;
//   final Widget icon; // Change IconData to Widget
//   final void Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: AppDefaults.borderRadius,
//         child: Padding(
//           padding: const EdgeInsets.all(AppDefaults.padding),
//           child: Column(
//             children: [
//               Container(
//                 width: 60,
//                 height: 60,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   // color: Color.fromARGB(255, 100, 153, 233),
//                   color: Color.fromARGB(255, 113, 201, 206),
//                 ),
//                 child: icon, // Use the icon widget directly
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 label,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(color: Colors.black),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
