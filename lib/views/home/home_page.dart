// // // ignore_for_file: unused_field, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

// // import 'dart:async';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:geotraking/core/components/localization_language.dart';
// // import 'package:geotraking/core/routes/app_routes.dart';
// // import 'package:geotraking/core/services/auth/authenticate_service.dart';
// // import 'package:geotraking/core/services/notification_member_service.dart';
// // import 'package:geotraking/views/home/components/categories.dart';
// // import 'package:geotraking/views/home/components/news_pack.dart';
// // import 'package:geotraking/views/home/components/product_pack.dart';
// // import 'package:intl/intl.dart';
// // import 'package:latlong2/latlong.dart';

// // class HomePage extends StatefulWidget {
// //   final String selectedLanguage;
// //   const HomePage({Key? key, required this.selectedLanguage}) : super(key: key);

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   final NotificationMemberService notificationMemberService =
// //       NotificationMemberService();
// //   bool _isLoggedIn = false;
// //   Timer? _timer;
// //   int _unreadNotifications = 0;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _checkLoggedIn();
// //     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
// //       setState(() {});
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _timer!.cancel();
// //     super.dispose();
// //   }

// //   _checkLoggedIn() async {
// //     final authService = AuthService();
// //     final user = await authService.getCurrentUser();
// //     if (user != null) {
// //       setState(() {
// //         _isLoggedIn = true;
// //       });

// //       final notifications = await notificationMemberService.getNotification();
// //       _unreadNotifications =
// //           notifications.where((n) => n.readStatus == 0).length;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: LayoutBuilder(
// //         builder: (context, constraints) {
// //           return SingleChildScrollView(
// //             child: ConstrainedBox(
// //               constraints: BoxConstraints(maxWidth: constraints.maxWidth),
// //               child: Column(
// //                 children: <Widget>[
// //                   Container(
// //                     padding: EdgeInsets.only(top: 30),
// //                     width: double.infinity,
// //                     // decoration: BoxDecoration(
// //                     //   color: Colors.blue,
// //                     // ),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Padding(
// //                           padding: const EdgeInsets.only(left: 2),
// //                           child: ElevatedButton(
// //                             onPressed: () {
// //                               Navigator.pushNamed(
// //                                   context, AppRoutes.drawerPage);
// //                             },
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.transparent,
// //                             ),
// //                             child: const Icon(
// //                               FontAwesomeIcons.bars,
// //                               color: Colors.black54,
// //                               size: 20,
// //                             ),
// //                           ),
// //                         ),
// //                         Padding(
// //                           padding: const EdgeInsets.only(right: 2),
// //                           child: Stack(
// //                             children: [
// //                               ElevatedButton(
// //                                 onPressed: () {
// //                                   Navigator.pushNamed(
// //                                       context, AppRoutes.notificationPage);
// //                                 },
// //                                 style: ElevatedButton.styleFrom(
// //                                   backgroundColor: Colors.transparent,
// //                                 ),
// //                                 child: const Icon(
// //                                   Icons.notifications,
// //                                   color: Colors.black54,
// //                                 ),
// //                               ),
// //                               if (_unreadNotifications > 0)
// //                                 Positioned(
// //                                   top: 6,
// //                                   right: 15,
// //                                   child: Container(
// //                                     width: 14,
// //                                     height: 14,
// //                                     decoration: BoxDecoration(
// //                                       shape: BoxShape.circle,
// //                                       color: Colors.red,
// //                                     ),
// //                                     child: Center(
// //                                       child: Text(
// //                                         _unreadNotifications.toString(),
// //                                         style: TextStyle(
// //                                           fontSize: 12,
// //                                           color: Colors.white,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   Container(
// //                     width: double.infinity,
// //                     // padding: EdgeInsets.only(top: 40),
// //                     // decoration: BoxDecoration(
// //                     //   color: Colors.red,
// //                     // ),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(15.0),
// //                       child: Row(
// //                         children: <Widget>[
// //                           Expanded(
// //                             flex: 1,
// //                             child: Container(
// //                               constraints: BoxConstraints(
// //                                 maxHeight: 100,
// //                               ),
// //                               decoration: BoxDecoration(
// //                                 color: const Color.fromARGB(255, 4, 35, 236),
// //                                 borderRadius: BorderRadius.circular(10.0),
// //                               ),
// //                               child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 crossAxisAlignment: CrossAxisAlignment.center,
// //                                 children: <Widget>[
// //                                   Text(
// //                                     'Sunday',
// //                                     style: TextStyle(
// //                                       fontSize: 12.0,
// //                                       color: Colors.white60,
// //                                     ),
// //                                   ),
// //                                   SizedBox(height: 6.0),
// //                                   Text(
// //                                     '24',
// //                                     style: TextStyle(
// //                                       fontSize: 20.0,
// //                                       fontWeight: FontWeight.bold,
// //                                       color: Colors.white,
// //                                     ),
// //                                   ),
// //                                   Text(
// //                                     'Aug',
// //                                     style: TextStyle(
// //                                       fontSize: 11.0,
// //                                       color: Colors.white60,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                           SizedBox(width: 16.0),
// //                           Expanded(
// //                             flex: 3,
// //                             child: GestureDetector(
// //                               onTap: () {},
// //                               child: ClipRRect(
// //                                 borderRadius: BorderRadius.circular(10.0),
// //                                 child: Container(
// //                                   constraints: BoxConstraints(
// //                                     maxHeight: 100,
// //                                   ),
// //                                   child: FlutterMap(
// //                                     options: MapOptions(
// //                                       initialCenter: LatLng(
// //                                           -4.4511412299261, 111.082877130109),
// //                                       initialZoom: 4,
// //                                       interactiveFlags:
// //                                           InteractiveFlag.pinchZoom |
// //                                               InteractiveFlag.drag |
// //                                               InteractiveFlag.doubleTapZoom,
// //                                     ),
// //                                     children: [
// //                                       TileLayer(
// //                                         urlTemplate:
// //                                             "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
// //                                         subdomains: ['a', 'b', 'c'],
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   Container(
// //                     width: double.infinity,
// //                     decoration: BoxDecoration(
// //                       color: Colors.grey.shade400,
// //                     ),
// //                     child: SizedBox(height: 5),
// //                   ),
// //                   Container(
// //                     width: double.infinity,
// //                     // decoration: BoxDecoration(
// //                     //   color: Colors.blue,
// //                     // ),
// //                     child: const Categories(),
// //                   ),
// //                   Container(
// //                     width: double.infinity,
// //                     decoration: BoxDecoration(
// //                       color: Colors.grey.shade400,
// //                     ),
// //                     child: SizedBox(height: 5),
// //                   ),
// //                   Container(
// //                     width: double.infinity,
// //                     // decoration: BoxDecoration(
// //                     //   color: Colors.green,
// //                     // ),
// //                     child:
// //                         ProductPacks(selectedLanguage: widget.selectedLanguage),
// //                   ),
// //                   Container(
// //                     width: double.infinity,
// //                     decoration: BoxDecoration(
// //                       color: Colors.grey.shade400,
// //                     ),
// //                     child: SizedBox(height: 5),
// //                   ),
// //                   Container(
// //                     width: double.infinity,
// //                     // decoration: BoxDecoration(
// //                     //   color: Colors.orange,
// //                     // ),
// //                     child: NewsPacks(selectedLanguage: widget.selectedLanguage),
// //                   ),
// //                   SizedBox(
// //                     height: constraints.maxHeight * 0.12,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // ignore_for_file: unused_field, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// // import 'package:flutter_map/flutter_map.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geotraking/core/components/localization_language.dart';
// import 'package:geotraking/core/routes/app_routes.dart';
// import 'package:geotraking/core/services/auth/authenticate_service.dart';
// import 'package:geotraking/core/services/notification_member_service.dart';
// import 'package:geotraking/views/home/components/categories.dart';
// import 'package:geotraking/views/home/components/news_pack.dart';
// import 'package:geotraking/views/home/components/product_pack.dart';
// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';
// // import 'package:latlong2/latlong.dart';

// class HomePage extends StatefulWidget {
//   final String selectedLanguage;
//   const HomePage({Key? key, required this.selectedLanguage}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final NotificationMemberService notificationMemberService =
//       NotificationMemberService();
//   bool _isLoggedIn = false;
//   Timer? _timer;
//   int _unreadNotifications = 0;

//   @override
//   void initState() {
//     super.initState();
//     _checkLoggedIn();
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _timer!.cancel();
//     super.dispose();
//   }

//   _checkLoggedIn() async {
//     final authService = AuthService();
//     final user = await authService.getCurrentUser();
//     if (user != null) {
//       setState(() {
//         _isLoggedIn = true;
//       });

//       final notifications = await notificationMemberService.getNotification();
//       _unreadNotifications =
//           notifications.where((n) => n.readStatus == 0).length;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Color.fromARGB(255, 166, 227, 233),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(maxWidth: constraints.maxWidth),
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     // height: constraints.maxHeight * 0.34,
//                     height: constraints.maxHeight * 0.30,
//                     width: double.infinity,
//                     padding: EdgeInsets.only(top: 40),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         // bottomRight: Radius.circular(40.0),
//                         // bottomLeft: Radius.circular(40.0),
//                         bottomRight: Radius.circular(25.0),
//                         bottomLeft: Radius.circular(25.0),
//                       ),
//                       // color: Colors.white
//                       gradient: LinearGradient(
//                         begin: Alignment.topRight,
//                         colors: [
//                           Color.fromARGB(255, 227, 253, 253),
//                           Color.fromARGB(255, 166, 227, 233),
//                         ],
//                       ),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 2),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.pushNamed(
//                                       context, AppRoutes.drawerPage);
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                 ),
//                                 child: const Icon(
//                                   FontAwesomeIcons.bars,
//                                   color: Colors.black54,
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 2),
//                               child: Stack(
//                                 children: [
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.pushNamed(
//                                           context, AppRoutes.notificationPage);
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.transparent,
//                                     ),
//                                     child: const Icon(
//                                       Icons.notifications,
//                                       color: Colors.black54,
//                                     ),
//                                   ),
//                                   if (_unreadNotifications > 0)
//                                     Positioned(
//                                       top: 6,
//                                       right: 15,
//                                       child: Container(
//                                         width: 14,
//                                         height: 14,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: Colors.red,
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             _unreadNotifications.toString(),
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   left: constraints.maxWidth * 0.05),
//                               child: Text(
//                                 Localization.getHomePagePriview(
//                                     widget.selectedLanguage),
//                                 style: TextStyle(
//                                     fontSize: constraints.maxWidth * 0.06,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black54),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   right: constraints.maxWidth * 0.05),
//                               child: Image.asset(
//                                 'assets/images/ic_launcher.png',
//                                 width: constraints.maxWidth * 0.3,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Transform.translate(
//                     offset: Offset(0, -constraints.maxHeight * 0.04),
//                     child: Container(
//                       height: 55,
//                       margin: EdgeInsets.symmetric(
//                         horizontal: constraints.maxWidth * 0.05,
//                       ),
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.shade300,
//                             blurRadius: 20.0,
//                             offset: Offset(0, 10.0),
//                           ),
//                         ],
//                         borderRadius: BorderRadius.circular(5.0),
//                         color: Colors.white,
//                       ),
//                       child: Center(
//                         child: Text(
//                           '${DateFormat('EEEE, dd MMMM yy (HH:mm:ss)').format(DateTime.now())}',
//                           style: TextStyle(fontSize: 16, color: Colors.black54),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const Categories(),
//                   ProductPacks(selectedLanguage: widget.selectedLanguage),
//                   NewsPacks(selectedLanguage: widget.selectedLanguage),
//                   SizedBox(
//                     height: constraints.maxHeight * 0.12,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// ignore_for_file: unused_field

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/routes/app_routes.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/views/home/components/categories.dart';
import 'package:geotraking/views/home/components/news_pack.dart';
import 'package:geotraking/views/home/components/product_pack.dart';
// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  final String selectedLanguage;
  const HomePage({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final NotificationMemberService notificationMemberService =
  //     NotificationMemberService();
  bool _isLoggedIn = false;
  int _unreadNotifications = 0;

  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
    _startBannerAutoScroll();

    // _timer = Timer.periodic(Duration(seconds: 3), (timer) {
    //   _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
    // });
  }

  void _startBannerAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      int currentPage = _pageController.page?.round() ?? 0;
      int totalPages = 3;

      if (currentPage == totalPages - 1) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    _pageController.dispose();
    super.dispose();
  }

  _checkLoggedIn() async {
    final authService = AuthService();
    final user = await authService.getCurrentUser();
    if (user != null) {
      setState(() {
        _isLoggedIn = true;
      });

      // final notifications = await notificationMemberService.getNotification();
      // _unreadNotifications =
      //     notifications.where((n) => n.readStatus == 0).length;
    }
  }

  Widget _buildCachedImage(String url) {
    return ClipRRect(
      borderRadius: AppDefaults.borderRadius,
      child: CachedNetworkImage(
        imageUrl: url,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white, // White background for loading state
          child: Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.white,
          child: Icon(Icons.error, color: Colors.red),
        ),
        // placeholder: (context, url) =>
        //     Center(child: CircularProgressIndicator()),
        // errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: RichText(
      //     text: TextSpan(
      //       children: [
      //         TextSpan(
      //           text: 'Geo',
      //           style: Theme.of(context).textTheme.headlineLarge?.copyWith(
      //                 color: Colors.black,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //         ),
      //         TextSpan(
      //           text: 'Traking',
      //           style: Theme.of(context).textTheme.headlineLarge?.copyWith(
      //                 color: Color.fromARGB(255, 13, 124, 102),
      //                 fontWeight: FontWeight.bold,
      //               ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.red,
      //   elevation: 0,
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 15),
      //       child: Row(
      //         children: [
      //           ElevatedButton(
      //             onPressed: () {
      //               Navigator.pushNamed(context, AppRoutes.drawerPage);
      //             },
      //             style: ElevatedButton.styleFrom(
      //               backgroundColor: Colors.blue[50],
      //               shape: const CircleBorder(),
      //               padding: const EdgeInsets.all(10),
      //             ),
      //             child: SvgPicture.asset(
      //               'assets/icons/menu_bar.svg',
      //               color: Colors.black87,
      //               width: 25,
      //               height: 25,
      //             ),
      //           ),
      //           Stack(
      //             children: [
      //               ElevatedButton(
      //                 onPressed: () {
      //                   Navigator.pushNamed(
      //                       context, AppRoutes.notificationPage);
      //                 },
      //                 style: ElevatedButton.styleFrom(
      //                   backgroundColor: Colors.blue[50],
      //                   shape: const CircleBorder(),
      //                   padding: const EdgeInsets.all(10),
      //                 ),
      //                 child: const Icon(
      //                   Icons.notifications,
      //                   color: Colors.black87,
      //                 ),
      //               ),
      //               if (_unreadNotifications > 0)
      //                 Positioned(
      //                   top: 6,
      //                   right: 15,
      //                   child: Container(
      //                     width: 14,
      //                     height: 14,
      //                     decoration: BoxDecoration(
      //                       shape: BoxShape.circle,
      //                       color: Colors.orange,
      //                     ),
      //                     child: Center(
      //                       child: Text(
      //                         _unreadNotifications.toString(),
      //                         style: TextStyle(
      //                           fontSize: 12,
      //                           color: Colors.white,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          child: AppBar(
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Geo',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextSpan(
                    text: 'Home',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Color.fromARGB(255, 13, 124, 102),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  children: [
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, AppRoutes.drawerPage);
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.blue[50],
                    //     shape: const CircleBorder(),
                    //     padding: const EdgeInsets.all(10),
                    //   ),
                    //   child: SvgPicture.asset(
                    //     'assets/icons/menu_bar.svg',
                    //     color: Colors.black87,
                    //     width: 25,
                    //     height: 25,
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.drawerPage);
                      },
                      child: Container(
                        height: 37,
                        width: 37,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 127, 183, 126),
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/menu_bar.svg',
                          color: Colors.white,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, AppRoutes.drawerPage);
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.blue[50],
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     // padding: const EdgeInsets.all(5),
                    //   ),
                    //   child: SvgPicture.asset(
                    //     'assets/icons/menu_bar.svg',
                    //     color: Colors.black87,
                    //     width: 25,
                    //     height: 25,
                    //   ),
                    // ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.notificationPage);
                      },
                      child: Container(
                        height: 37,
                        width: 37,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 127, 183, 126),
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                      ),
                    ),
                    // Stack(
                    //   children: [
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         Navigator.pushNamed(
                    //             context, AppRoutes.notificationPage);
                    //       },
                    //       // style: ElevatedButton.styleFrom(
                    //       //   backgroundColor: Colors.blue[50],
                    //       //   shape: const CircleBorder(),
                    //       //   padding: const EdgeInsets.all(10),
                    //       // ),
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.blue[50],
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         // padding: const EdgeInsets.all(10),
                    //       ),
                    //       child: const Icon(
                    //         Icons.notifications,
                    //         color: Colors.black87,
                    //       ),
                    //     ),
                    //     // if (_unreadNotifications > 0)
                    //     //   Positioned(
                    //     //     top: 6,
                    //     //     right: 15,
                    //     //     child: Container(
                    //     //       width: 14,
                    //     //       height: 14,
                    //     //       decoration: BoxDecoration(
                    //     //         shape: BoxShape.circle,
                    //     //         color: Colors.orange,
                    //     //       ),
                    //     //       child: Center(
                    //     //         child: Text(
                    //     //           _unreadNotifications.toString(),
                    //     //           style: TextStyle(
                    //     //             fontSize: 12,
                    //     //             color: Colors.white,
                    //     //           ),
                    //     //         ),
                    //     //       ),
                    //     //     ),
                    //     //   ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  height: 190,
                  child: PageView(
                    controller: _pageController,
                    children: <Widget>[
                      _buildCachedImage(
                        'https://drive.google.com/uc?export=view&id=1K6UvoXjKhJ-ZbQm8HjwVk155MLO_96wY',
                      ),
                      _buildCachedImage(
                        'https://drive.google.com/uc?export=view&id=1AXul2oZglfxWK5klsgoEFZ73GXmCoq3d',
                      ),
                      _buildCachedImage(
                        'https://drive.google.com/uc?export=view&id=1mmtL8farG62HR8x0gWLSQKb4zUuSt3VH',
                      ),
                      // Container(
                      //   child: ClipRRect(
                      //     borderRadius: AppDefaults.borderRadius,
                      //     child: Image.asset(
                      //       'assets/images/banner1.jpg',
                      //       width: double.infinity,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   child: ClipRRect(
                      //     borderRadius: AppDefaults.borderRadius,
                      //     child: Image.asset(
                      //       'assets/images/banner2.jpg',
                      //       width: double.infinity,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   child: ClipRRect(
                      //     borderRadius: AppDefaults.borderRadius,
                      //     child: Image.asset(
                      //       'assets/images/banner3.jpg',
                      //       width: double.infinity,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              color: Colors.white,
              child: const Categories(),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ProductPacks(selectedLanguage: widget.selectedLanguage),
                  SizedBox(height: 10),
                  NewsPacks(selectedLanguage: widget.selectedLanguage),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _HomePageState extends State<HomePage> {
//   final NotificationMemberService notificationMemberService =
//       NotificationMemberService();
//   bool _isLoggedIn = false;
//   int _unreadNotifications = 0;

//   @override
//   void initState() {
//     super.initState();
//     _checkLoggedIn();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   _checkLoggedIn() async {
//     final authService = AuthService();
//     final user = await authService.getCurrentUser();
//     if (user != null) {
//       setState(() {
//         _isLoggedIn = true;
//       });

//       final notifications = await notificationMemberService.getNotification();
//       _unreadNotifications =
//           notifications.where((n) => n.readStatus == 0).length;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final DateTime now = DateTime.now();
//     final String currentDay = DateFormat('EEEE').format(now);
//     final String currentDate = DateFormat('d').format(now);
//     final String currentMonth = DateFormat('MMM').format(now);

//     return Scaffold(
//       backgroundColor: Colors.black12,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               color: Colors.white,
//               child: Padding(
//                 padding: EdgeInsets.all(15.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 2),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pushNamed(
//                                   context, AppRoutes.drawerPage);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.transparent,
//                             ),
//                             child: SvgPicture.asset(
//                               'assets/icons/menu_bar.svg',
//                               color: Colors.black87,
//                               width: 25,
//                               height: 25,
//                             ),
//                           ),
//                         ),
//                         Text('hi user'),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 2),
//                           child: Stack(
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.pushNamed(
//                                       context, AppRoutes.notificationPage);
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                 ),
//                                 child: const Icon(
//                                   Icons.notifications,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                               if (_unreadNotifications > 0)
//                                 Positioned(
//                                   top: 6,
//                                   right: 15,
//                                   child: Container(
//                                     width: 14,
//                                     height: 14,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: Colors.orange,
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         _unreadNotifications.toString(),
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: TextField(
//                         readOnly: true,
//                         decoration: InputDecoration(
//                           hintText: 'GeoTraking Mobile App..',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none,
//                           ),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 15),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             flex: 1,
//                             child: Container(
//                               constraints: BoxConstraints(
//                                 maxHeight: 100,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: const Color.fromARGB(255, 92, 131, 116),
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: <Widget>[
//                                   Text(
//                                     currentDay,
//                                     style: TextStyle(
//                                       fontSize: 12.0,
//                                       color: Colors.white60,
//                                     ),
//                                   ),
//                                   SizedBox(height: 6.0),
//                                   Text(
//                                     currentDate,
//                                     style: TextStyle(
//                                       fontSize: 20.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   Text(
//                                     '< ${currentMonth} >',
//                                     style: TextStyle(
//                                       fontSize: 11.0,
//                                       color: Colors.white60,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 16.0),
//                           // Expanded(
//                           //   flex: 3,
//                           //   child: GestureDetector(
//                           //     onTap: () {
//                           //       print("Container clicked");
//                           //       Navigator.pushNamed(
//                           //           context, AppRoutes.myProfileTrackKapal);
//                           //     },
//                           //     child: ClipRRect(
//                           //       borderRadius: BorderRadius.circular(10.0),
//                           //       child: Container(
//                           //         constraints: BoxConstraints(
//                           //           maxHeight: 100,
//                           //         ),
//                           //         child: FlutterMap(
//                           //           options: MapOptions(
//                           //             initialCenter: LatLng(
//                           //                 -4.4511412299261, 111.082877130109),
//                           //             initialZoom: 4,
//                           //             interactiveFlags:
//                           //                 InteractiveFlag.pinchZoom |
//                           //                     InteractiveFlag.drag |
//                           //                     InteractiveFlag.doubleTapZoom,
//                           //           ),
//                           //           children: [
//                           //             TileLayer(
//                           //               urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                           //               userAgentPackageName: 'com.example.app',
//                           //             ),
//                           //           ],
//                           //         ),
//                           //       ),
//                           //     ),
//                           //   ),
//                           // ),
//                           Expanded(
//                             flex: 3,
//                             child: GestureDetector(
//                               onTap: () {
//                                 print("Container clicked");
//                                 Navigator.pushNamed(
//                                     context, AppRoutes.myProfileTrackKapalDemo);
//                               },
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 child: Stack(
//                                   children: [
//                                     Container(
//                                       constraints: BoxConstraints(
//                                         maxHeight: 100,
//                                       ),
//                                       child: FlutterMap(
//                                         options: MapOptions(
//                                           initialCenter: LatLng(
//                                               -4.4511412299261,
//                                               111.082877130109),
//                                           initialZoom: 4,
//                                           interactiveFlags:
//                                               InteractiveFlag.pinchZoom |
//                                                   InteractiveFlag.drag |
//                                                   InteractiveFlag.doubleTapZoom,
//                                         ),
//                                         children: [
//                                           TileLayer(
//                                             urlTemplate:
//                                                 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                                             userAgentPackageName:
//                                                 'com.example.app',
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Positioned.fill(
//                                       child: Material(
//                                         color: Colors.transparent,
//                                         child: InkWell(
//                                           onTap: () {
//                                             print("Container clicked");
//                                             Navigator.pushNamed(context,
//                                                 AppRoutes.myProfileTrackKapalDemo);
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 5),
//             Container(
//               color: Colors.white,
//               child: const Categories(),
//             ),
//             SizedBox(height: 5),
//             Container(
//               color: Colors.white,
//               child: Column(
//                 children: [
//                   SizedBox(height: 5),
//                   ProductPacks(selectedLanguage: widget.selectedLanguage),
//                   NewsPacks(selectedLanguage: widget.selectedLanguage),
//                   SizedBox(height: 100),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
