// import 'package:flutter/material.dart';
// import 'package:geotraking/core/constants/constants.dart';

// class ProfileListTile extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Function() onTap;

//   const ProfileListTile({
//     Key? key,
//     required this.title,
//     required this.icon,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Ink(
//       height: 55,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: AppDefaults.borderRadius,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: AppDefaults.borderRadius,
//                 ),
//                 child: Icon(
//                   icon,
//                   size: 20,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Text(
//                 title,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyLarge
//                     ?.copyWith(color: Colors.black),
//               ),
//               const SizedBox(width: 10),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 196, 218, 210),
//                   borderRadius: AppDefaults.borderRadius,

//                 ),
//                 child: Text(
//                   '11',
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyLarge
//                       ?.copyWith(color: Colors.black),
//                 ),
//               ),
//               const Spacer(),
//               const Icon(
//                 Icons.arrow_right_alt_rounded,
//                 size: 35,
//                 color: Colors.black54,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/constants.dart';

class ProfileListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;
  final int? jumlahData;

  const ProfileListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.jumlahData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String displayData = jumlahData! > 99 ? '99+' : jumlahData.toString();
    // String? displayData;
    // if (displayData != null) {
    //   displayData = jumlahData! > 99 ? '99+' : jumlahData.toString();
    // }

    return Ink(
      // height: 55,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDefaults.borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppDefaults.borderRadius,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black),
              ),
              // const SizedBox(width: 10),
              // if (displayData != null)
              //   Container(
              //     padding: const EdgeInsets.all(8),
              //     decoration: BoxDecoration(
              //       color: const Color.fromARGB(255, 196, 218, 210),
              //       borderRadius: AppDefaults.borderRadius,
              //     ),
              //     child: Text(
              //       displayData,
              //       style: Theme.of(context)
              //           .textTheme
              //           .bodyLarge
              //           ?.copyWith(color: Colors.black),
              //     ),
              //   ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
