// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// class LegendVesselInformation extends StatelessWidget {
//   const LegendVesselInformation({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 5,
//       right: 10,
//       child: Container(
//         width: 300,
//         height: 40,
//         decoration: const BoxDecoration(
//           color: Colors.black45,
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.all(
//             Radius.circular(15),
//           ),
//         ),
//         padding: const EdgeInsets.all(3),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             color: Color.fromARGB(255, 127, 183, 126),
//                           ),
//                           SizedBox(width: 3),
//                           Text(
//                             'Received < 72 menit',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodySmall
//                                 ?.copyWith(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             color: Color.fromARGB(255, 255, 222, 77),
//                           ),
//                           SizedBox(width: 3),
//                           Text(
//                             'Received < 120 menit',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodySmall
//                                 ?.copyWith(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),

//                   SizedBox(width: 8),
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             color: Color.fromARGB(255, 243, 182, 100),
//                           ),
//                           SizedBox(width: 3),
//                           Text(
//                             'Received < 7 hari',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodySmall
//                                 ?.copyWith(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             width: 10,
//                             height: 10,
//                             color: Color.fromARGB(255, 117, 134, 148),
//                           ),
//                           SizedBox(width: 3),
//                           Text(
//                             'Received > 7 hari',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodySmall
//                                 ?.copyWith(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LegendVesselInformation extends StatelessWidget {
  const LegendVesselInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      right: 5,
      child: Container(
        // Remove the fixed width and use padding and constraints to make the container fit the content
        decoration: const BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(3),
        child: Row(
          // Align content starting from the left, as no width constraint is being applied.
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    // Container(
                    //   width: 10,
                    //   height: 10,
                    //   color: Color.fromARGB(255, 127, 183, 126),
                    // ),
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.asset('assets/images/kapal-hijau.png',
                          fit: BoxFit.contain),
                    ),
                    SizedBox(width: 3),
                    Text(
                      'Received < 72 menit',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Container(
                    //   width: 10,
                    //   height: 10,
                    //   color: Color.fromARGB(255, 255, 222, 77),
                    // ),
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.asset('assets/images/kapal-kuning.png',
                          fit: BoxFit.contain),
                    ),
                    SizedBox(width: 3),
                    Text(
                      'Received < 120 menit',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 5),
            Column(
              children: [
                Row(
                  children: [
                    // Container(
                    //   width: 10,
                    //   height: 10,
                    //   color: Color.fromARGB(255, 243, 182, 100),
                    // ),
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.asset('assets/images/kapal-orange.png',
                          fit: BoxFit.contain),
                    ),
                    SizedBox(width: 3),
                    Text(
                      'Received < 7 hari',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Container(
                    //   width: 10,
                    //   height: 10,
                    //   color: Color.fromARGB(255, 117, 134, 148),
                    // ),
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.asset('assets/images/kapal-abu.png',
                          fit: BoxFit.contain),
                    ),
                    SizedBox(width: 3),
                    Text(
                      'Received > 7 hari',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
