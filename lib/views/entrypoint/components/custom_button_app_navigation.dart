//   // // ignore: must_be_immutable
//   // // ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, deprecated_member_use

//   // import 'package:flutter/material.dart';
//   // import 'package:flutter_svg/svg.dart';

//   // class CustomBottomNavigationBar extends StatefulWidget {
//   //   const CustomBottomNavigationBar({
//   //     Key? key,
//   //     required this.selectedIndex,
//   //     required this.onItemTapped,
//   //   }) : super(key: key);

//   //   final int selectedIndex;
//   //   final void Function(int) onItemTapped;

//   //   @override
//   //   _CustomBottomNavigationBarState createState() =>
//   //       _CustomBottomNavigationBarState();
//   // }

//   // class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   //   final double iconSize = 30.0;
//   //   final double unselectedIconColorOpacity = 0.5;

//   //   @override
//   //   Widget build(BuildContext context) {
//   //     return Container(
//   //       padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
//   //       color: Colors.transparent,
//   //       child: ClipRRect(
//   //         borderRadius: BorderRadius.circular(20),
//   //         child: SizedBox(
//   //           height: 70,
//   //           // height: MediaQuery.of(context).size.height * 0.15,
//   //           child: BottomNavigationBar(
//   //             currentIndex: widget.selectedIndex,
//   //             onTap: widget.onItemTapped,
//   //             showSelectedLabels: false,
//   //             showUnselectedLabels: false,
//   //             elevation: 0,
//   //             type: BottomNavigationBarType.fixed,
//   //             items: [
//   //               BottomNavigationBarItem(
//   //                 icon: SvgPicture.asset(
//   //                   'assets/icons/home.svg',
//   //                   color: widget.selectedIndex == 0
//   //                       ? Color.fromARGB(255, 113, 201, 206)
//   //                       : Colors.black.withOpacity(unselectedIconColorOpacity),
//   //                   width: 30,
//   //                   height: 30,
//   //                 ),
//   //                 label: '',
//   //               ),
//   //               BottomNavigationBarItem(
//   //                 icon: SvgPicture.asset(
//   //                   'assets/icons/bag.svg',
//   //                   color: widget.selectedIndex == 1
//   //                       ? Color.fromARGB(255, 113, 201, 206)
//   //                       : Colors.black.withOpacity(unselectedIconColorOpacity),
//   //                   width: 30,
//   //                   height: 30,
//   //                 ),
//   //                 label: '',
//   //               ),
//   //               BottomNavigationBarItem(
//   //                 icon: Icon(
//   //                   Icons.location_pin,
//   //                   color: widget.selectedIndex == 2
//   //                       ? Color.fromARGB(255, 113, 201, 206)
//   //                       : Colors.black.withOpacity(unselectedIconColorOpacity),
//   //                   size: iconSize,
//   //                 ),
//   //                 label: '',
//   //               ),
//   //               BottomNavigationBarItem(
//   //                 icon: Icon(
//   //                   Icons.person,
//   //                   color: widget.selectedIndex == 3
//   //                       ? Color.fromARGB(255, 113, 201, 206)
//   //                       : Colors.black.withOpacity(unselectedIconColorOpacity),
//   //                   size: iconSize,
//   //                 ),
//   //                 label: '',
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     );
//   //   }
//   // }

// // ignore: must_be_immutable
// // ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class CustomBottomNavigationBar extends StatefulWidget {
//   const CustomBottomNavigationBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//   }) : super(key: key);

//   final int selectedIndex;
//   final void Function(int) onItemTapped;

//   @override
//   _CustomBottomNavigationBarState createState() =>
//       _CustomBottomNavigationBarState();
// }

// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   final double iconSize = 30.0;
//   final double unselectedIconColorOpacity = 0.5;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       child: ClipRRect(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         child: SizedBox(
//           height: 70,
//           child: BottomNavigationBar(
//             currentIndex: widget.selectedIndex,
//             onTap: widget.onItemTapped,
//             showSelectedLabels: false,
//             showUnselectedLabels: false,
//             elevation: 0,
//             type: BottomNavigationBarType.fixed,
//             items: [
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(
//                   'assets/icons/home.svg',
//                   color: widget.selectedIndex == 0
//                       ? Color.fromARGB(255, 113, 201, 206)
//                       : Colors.black.withOpacity(unselectedIconColorOpacity),
//                   width: 30,
//                   height: 30,
//                 ),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(
//                   'assets/icons/bag.svg',
//                   color: widget.selectedIndex == 1
//                       ? Color.fromARGB(255, 113, 201, 206)
//                       : Colors.black.withOpacity(unselectedIconColorOpacity),
//                   width: 30,
//                   height: 30,
//                 ),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(
//                   'assets/icons/location.svg',
//                   color: widget.selectedIndex == 1
//                       ? Color.fromARGB(255, 113, 201, 206)
//                       : Colors.black.withOpacity(unselectedIconColorOpacity),
//                   width: 30,
//                   height: 30,
//                 ),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: SvgPicture.asset(
//                   'assets/icons/profile.svg',
//                   color: widget.selectedIndex == 1
//                       ? Color.fromARGB(255, 113, 201, 206)
//                       : Colors.black.withOpacity(unselectedIconColorOpacity),
//                   width: 30,
//                   height: 30,
//                 ),
//                 label: '',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore: must_be_immutable
// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  final int selectedIndex;
  final void Function(int) onItemTapped;

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final double iconSize = 30.0;
  final double unselectedIconColorOpacity = 0.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ClipRRect(
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(40),
        //   topRight: Radius.circular(40),
        // ),
        child: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: widget.selectedIndex,
            onTap: widget.onItemTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  color: widget.selectedIndex == 0
                      ? Color.fromARGB(255, 113, 201, 206)
                      : Colors.black.withOpacity(unselectedIconColorOpacity),
                  width: 30,
                  height: 30,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/archive.svg',
                  color: widget.selectedIndex == 1
                      ? Color.fromARGB(255, 113, 201, 206)
                      : Colors.black.withOpacity(unselectedIconColorOpacity),
                  width: 30,
                  height: 30,
                ),
                label: '',
              ),
              // BottomNavigationBarItem(
              //   icon: SizedBox.shrink(),
              //   label: '',
              // ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/message.svg',
                  color: widget.selectedIndex == 2
                      ? Color.fromARGB(255, 113, 201, 206)
                      : Colors.black.withOpacity(unselectedIconColorOpacity),
                  width: 30,
                  height: 30,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/location.svg',
                  color: widget.selectedIndex == 3
                      ? Color.fromARGB(255, 113, 201, 206)
                      : Colors.black.withOpacity(unselectedIconColorOpacity),
                  width: 30,
                  height: 30,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  color: widget.selectedIndex == 4
                      ? Color.fromARGB(255, 113, 201, 206)
                      : Colors.black.withOpacity(unselectedIconColorOpacity),
                  width: 30,
                  height: 30,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   final double iconSize = 30.0;
//   final double unselectedIconColorOpacity = 0.5;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           color: Colors.transparent,
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(40),
//               topRight: Radius.circular(40),
//             ),
//             child: SizedBox(
//               height: 70,
//               child: BottomNavigationBar(
//                 backgroundColor: Colors.white,
//                 currentIndex: widget.selectedIndex,
//                 onTap: widget.onItemTapped,
//                 showSelectedLabels: false,
//                 showUnselectedLabels: false,
//                 elevation: 0,
//                 type: BottomNavigationBarType.fixed,
//                 items: [
//                   BottomNavigationBarItem(
//                     icon: SvgPicture.asset(
//                       'assets/icons/home.svg',
//                       color: widget.selectedIndex == 0
//                           ? Color.fromARGB(255, 113, 201, 206)
//                           : Colors.black.withOpacity(unselectedIconColorOpacity),
//                       width: 30,
//                       height: 30,
//                     ),
//                     label: '',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: SvgPicture.asset(
//                       'assets/icons/archive.svg',
//                       color: widget.selectedIndex == 1
//                           ? Color.fromARGB(255, 113, 201, 206)
//                           : Colors.black.withOpacity(unselectedIconColorOpacity),
//                       width: 30,
//                       height: 30,
//                     ),
//                     label: '',
//                   ),
//                   // Menambahkan item kosong untuk mengimbangi FAB
//                   BottomNavigationBarItem(
//                     icon: SizedBox.shrink(),
//                     label: '',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: SvgPicture.asset(
//                       'assets/icons/location.svg',
//                       color: widget.selectedIndex == 2
//                           ? Color.fromARGB(255, 113, 201, 206)
//                           : Colors.black.withOpacity(unselectedIconColorOpacity),
//                       width: 30,
//                       height: 30,
//                     ),
//                     label: '',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: SvgPicture.asset(
//                       'assets/icons/profile.svg',
//                       color: widget.selectedIndex == 3
//                           ? Color.fromARGB(255, 113, 201, 206)
//                           : Colors.black.withOpacity(unselectedIconColorOpacity),
//                       width: 30,
//                       height: 30,
//                     ),
//                     label: '',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         // FAB tetap di tengah
//         // Positioned(
//         //   bottom: 30,
//         //   left: MediaQuery.of(context).size.width / 2 - 30, // FAB centered
//         //   child: FloatingActionButton(
//         //     onPressed: () {
//         //       // Aksi untuk FAB
//         //     },
//         //     backgroundColor: Colors.transparent,
//         //     elevation: 0,
//         //     child: Container(
//         //       decoration: BoxDecoration(
//         //         shape: BoxShape.circle,
//         //         gradient: LinearGradient(
//         //           colors: [
//         //             Color.fromARGB(255, 196, 218, 210),
//         //             Color.fromARGB(255, 113, 201, 206),
//         //           ],
//         //           begin: Alignment.topCenter,
//         //           end: Alignment.bottomCenter,
//         //         ),
//         //       ),
//         //       child: SvgPicture.asset(
//         //         'assets/icons/message.svg',
//         //         color: Colors.black.withOpacity(0.5),
//         //         width: 30,
//         //         height: 30,
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
