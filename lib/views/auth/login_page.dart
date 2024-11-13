// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/app_icons.dart';
import 'package:geotraking/views/auth/components/dont_have_account_row.dart';
import 'package:geotraking/views/auth/components/login_header.dart';
import 'package:geotraking/views/auth/components/login_page_form.dart';
import 'package:geotraking/views/entrypoint/entrypoint_ui.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//               height: 400,
//               width: double.infinity,
//               padding: EdgeInsets.only(top: 40),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(50.0),
//                     bottomLeft: Radius.circular(50.0)),
//                 gradient: LinearGradient(begin: Alignment.topRight, colors: [
//                   Color.fromARGB(255, 227, 253, 253),
//                   Color.fromARGB(255, 166, 227, 233)
//                 ]),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       FadeInLeft(
//                         duration: Duration(milliseconds: 1000),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 12),
//                           child: Row(
//                             children: [
//                               IconButton(
//                                 icon: SvgPicture.asset(AppIcons.arrowBackward),
//                                 onPressed: () => Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const EntryPointUI(),
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 'Back',
//                                 style: TextStyle(
//                                     fontSize: 15, color: Colors.black87),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Spacer(),
//                       Center(
//                         child: LoginPageHeader(),
//                       ),
//                       Spacer(),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Transform.translate(
//               offset: Offset(0, -60),
//               child: Container(
//                 height: 370,
//                 margin: EdgeInsets.symmetric(horizontal: 25),
//                 decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade300,
//                         blurRadius: 20.0,
//                         offset: Offset(0, 10.0),
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(5.0),
//                     color: Colors.white),
//                 child: SafeArea(
//                   child: Center(
//                     child: Column(
//                       children: [
//                         LoginPageForm(),
//                         SizedBox(height: 10),
//                         DontHaveAccountRow()
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 105,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   FocusNode _emailFocusNode = FocusNode();
//   FocusNode _passwordFocusNode = FocusNode();
//   double _translateOffset = -60;

//   @override
//   void initState() {
//     super.initState();

//     // Listener untuk email field
//     _emailFocusNode.addListener(() {
//       _updateOffset();
//     });

//     // Listener untuk password field
//     _passwordFocusNode.addListener(() {
//       _updateOffset();
//     });
//   }

//   void _updateOffset() {
//     // Cek apakah salah satu dari form mendapatkan fokus
//     if (_emailFocusNode.hasFocus || _passwordFocusNode.hasFocus) {
//       setState(() {
//         _translateOffset = -120; // Ubah offset menjadi -120 ketika fokus
//       });
//     } else {
//       setState(() {
//         _translateOffset =
//             -60; // Kembali ke default offset jika tidak ada fokus
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _emailFocusNode.dispose();
//     _passwordFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding:
//               EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Column(
//             children: <Widget>[
//               Container(
//                 height: 400,
//                 width: double.infinity,
//                 padding: EdgeInsets.only(top: 40),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(50.0),
//                       bottomLeft: Radius.circular(50.0)),
//                   gradient: LinearGradient(begin: Alignment.topRight, colors: [
//                     Color.fromARGB(255, 227, 253, 253),
//                     Color.fromARGB(255, 166, 227, 233)
//                   ]),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         FadeInLeft(
//                           duration: Duration(milliseconds: 1000),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 12),
//                             child: Row(
//                               children: [
//                                 IconButton(
//                                   icon:
//                                       SvgPicture.asset(AppIcons.arrowBackward),
//                                   onPressed: () => Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           const EntryPointUI(),
//                                     ),
//                                   ),
//                                 ),
//                                 Text(
//                                   'Back',
//                                   style: TextStyle(
//                                       fontSize: 15, color: Colors.black87),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Spacer(),
//                         Center(
//                           child: LoginPageHeader(),
//                         ),
//                         Spacer(),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               Transform.translate(
//                 // offset: Offset(0, -60),
//                 offset: Offset(0, _translateOffset),
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 25),
//                   decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.shade300,
//                           blurRadius: 20.0,
//                           offset: Offset(0, 10.0),
//                         ),
//                       ],
//                       borderRadius: BorderRadius.circular(5.0),
//                       color: Colors.white),
//                   child: SafeArea(
//                     child: Center(
//                       child: Column(
//                         children: [
//                           // LoginPageForm(),
//                           LoginPageForm(
//                             emailFocusNode: _emailFocusNode, // Kirim FocusNodes
//                             passwordFocusNode: _passwordFocusNode,
//                           ),
//                           SizedBox(height: 10),
//                           DontHaveAccountRow()
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 105,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  double _translateOffset = -60; // Default offset

  @override
  void initState() {
    super.initState();

    // Listener untuk email field
    _emailFocusNode.addListener(() {
      _updateOffset();
    });

    // Listener untuk password field
    _passwordFocusNode.addListener(() {
      _updateOffset();
    });
  }

  void _updateOffset() {
    // Cek apakah salah satu dari form mendapatkan fokus
    if (_emailFocusNode.hasFocus || _passwordFocusNode.hasFocus) {
      setState(() {
        _translateOffset = -120; // Ubah offset menjadi -120 ketika fokus
      });
    } else {
      setState(() {
        _translateOffset =
            -60; // Kembali ke default offset jika tidak ada fokus
      });
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   resizeToAvoidBottomInset: true,
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding:
    //           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    //       child: Column(
    //         children: <Widget>[
    //           Container(
    //             height: 400,
    //             width: double.infinity,
    //             padding: EdgeInsets.only(top: 40),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                 bottomRight: Radius.circular(50.0),
    //                 bottomLeft: Radius.circular(50.0),
    //               ),
    //               gradient: LinearGradient(
    //                 begin: Alignment.topRight,
    //                 colors: [
    //                   Color.fromARGB(255, 227, 253, 253),
    //                   Color.fromARGB(255, 166, 227, 233)
    //                 ],
    //               ),
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     FadeInLeft(
    //                       duration: Duration(milliseconds: 1000),
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(left: 12),
    //                         child: Row(
    //                           children: [
    //                             IconButton(
    //                               icon:
    //                                   SvgPicture.asset(AppIcons.arrowBackward),
    //                               onPressed: () => Navigator.pushReplacement(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                   builder: (context) =>
    //                                       const EntryPointUI(),
    //                                 ),
    //                               ),
    //                             ),
    //                             Text(
    //                               'Back',
    //                               style: TextStyle(
    //                                   fontSize: 15, color: Colors.black87),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(height: 15),
    //                 Row(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: <Widget>[
    //                     Spacer(),
    //                     Center(child: LoginPageHeader()),
    //                     Spacer(),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Transform.translate(
    //             offset: Offset(0, _translateOffset), // Offset untuk form juga
    //             child: Container(
    //               margin: EdgeInsets.symmetric(horizontal: 25),
    //               decoration: BoxDecoration(
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Colors.grey.shade300,
    //                       blurRadius: 20.0,
    //                       offset: Offset(0, 10.0),
    //                     ),
    //                   ],
    //                   borderRadius: BorderRadius.circular(5.0),
    //                   color: Colors.white),
    //               child: SafeArea(
    //                 child: Center(
    //                   child: Column(
    //                     children: [
    //                       LoginPageForm(
    //                         emailFocusNode: _emailFocusNode,
    //                         passwordFocusNode: _passwordFocusNode,
    //                       ),
    //                       SizedBox(height: 10),
    //                       DontHaveAccountRow(),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 105),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    // return Scaffold(
    //   backgroundColor: Colors.blue[50],
    //   body: Center(
    //     child: Padding(
    //       padding: const EdgeInsets.all(15),
    //       child: Container(
    //         height: 350,
    //         margin: EdgeInsets.symmetric(horizontal: 25),
    //         decoration: BoxDecoration(boxShadow: [
    //           BoxShadow(
    //             color: Colors.grey.shade300,
    //             blurRadius: 20.0,
    //             offset: Offset(0, 5),
    //           ),
    //         ], borderRadius: BorderRadius.circular(5.0), color: Colors.white),
    //         child: Center(
    //           child: Column(
    //             children: [
    //               LoginPageForm(
    //                 emailFocusNode: _emailFocusNode,
    //                 passwordFocusNode: _passwordFocusNode,
    //               ),
    //               SizedBox(height: 10),
    //               DontHaveAccountRow(),
    //               // LoginPageForm(),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    // return Scaffold(
    //   resizeToAvoidBottomInset: true,
    //   backgroundColor: Colors.blue[50],
    //   body: Center(
    //     child: Padding(
    //       padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Center(child: LoginPageHeader()),
    //           SizedBox(height: 20),
    //           Container(
    //             height: 350,
    //             margin: EdgeInsets.symmetric(horizontal: 25),
    //             decoration: BoxDecoration(
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.grey.shade300,
    //                   blurRadius: 20.0,
    //                   offset: Offset(0, 5),
    //                 ),
    //               ],
    //               borderRadius: BorderRadius.circular(5.0),
    //               color: Colors.white,
    //             ),
    //             child: Center(
    //               child: Column(
    //                 children: [
    //                   LoginPageForm(
    //                     emailFocusNode: _emailFocusNode,
    //                     passwordFocusNode: _passwordFocusNode,
    //                   ),
    //                   SizedBox(height: 10),
    //                   DontHaveAccountRow(),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    // return Scaffold(
    //   backgroundColor: Colors.blue[50],
    //   resizeToAvoidBottomInset: true,
    //   body: LayoutBuilder(
    //     builder: (context, constraints) {
    //       final availableHeight = constraints.maxHeight;
    //       return SingleChildScrollView(
    //         padding: EdgeInsets.only(
    //           top: availableHeight * 0.1,
    //           bottom: MediaQuery.of(context).viewInsets.bottom + 20,
    //         ),
    //         child: Center(
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 15),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Center(child: LoginPageHeader()),
    //                 SizedBox(height: 20),
    //                 Container(
    //                   // height: 350,
    //                   margin: EdgeInsets.symmetric(horizontal: 25),
    //                   decoration: BoxDecoration(
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Colors.grey.shade300,
    //                         blurRadius: 20.0,
    //                         offset: Offset(0, 5),
    //                       ),
    //                     ],
    //                     borderRadius: BorderRadius.circular(5.0),
    //                     color: Colors.white,
    //                   ),
    //                   child: Center(
    //                     child: Column(
    //                       children: [
    //                         LoginPageForm(
    //                           emailFocusNode: _emailFocusNode,
    //                           passwordFocusNode: _passwordFocusNode,
    //                         ),
    //                         SizedBox(height: 10),
    //                         DontHaveAccountRow(),
    //                         // SizedBox(height: 10),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );

    return Scaffold(
      backgroundColor: Colors.blue[50],
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final availableHeight = constraints.maxHeight;
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              top: availableHeight * 0.05,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FadeInLeft(
                      duration: Duration(milliseconds: 1000),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            IconButton(
                              icon: SvgPicture.asset(AppIcons.arrowBackward),
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EntryPointUI(),
                                ),
                              ),
                            ),
                            Text(
                              'Back',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 40), // Spacing for the back button
                      Center(child: LoginPageHeader()),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 20.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              LoginPageForm(
                                emailFocusNode: _emailFocusNode,
                                passwordFocusNode: _passwordFocusNode,
                              ),
                              SizedBox(height: 10),
                              DontHaveAccountRow(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   top: 20,
                //   left: 15,
                //   child: IconButton(
                //     icon: Icon(Icons.arrow_back, color: Colors.black),
                //     onPressed: () {
                //       Navigator.pop(context);
                //     },
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
