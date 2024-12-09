// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// import '../../../core/constants/constants.dart';

class IconsCategories extends StatelessWidget {
  const IconsCategories({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final String icon;
  // final IconData icon;
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
    // return InkWell(
    //   onTap: onTap,
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Container(
    //         width: 60,
    //         height: 60,
    //         decoration: BoxDecoration(
    //           color: Colors.blue[50],
    //           shape: BoxShape.circle,
    //         ),
    //         child: Icon(
    //           icon,
    //           color: Color.fromARGB(255, 113, 201, 206),
    //           size: 25,
    //         ),
    //       ),
    //       SizedBox(height: 8),
    //       Text(label, style: TextStyle(fontSize: 14, color: Colors.black87)),
    //     ],
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
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Color.fromARGB(255, 127, 183, 126),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: SvgPicture.asset(
              icon,
              color: Colors.white,
              width: 25,
              height: 25,
            ),
            // child: Icon(
            //   icon,
            //   // color: Color.fromARGB(255, 127, 183, 126),
            //   color: Colors.white,
            //   size: 25,
            // ),
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
