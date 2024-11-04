// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_field, prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/localization_language.dart';
// import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/models/member.dart';
import 'package:geotraking/core/routes/app_routes.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/core/services/vessel_service.dart';
import 'package:geotraking/views/auth/login_page.dart';
import 'package:geotraking/views/profile/apn/components/profile_apn_menu_options.dart';
import 'package:geotraking/views/profile/components/card/contact_card.dart';
import 'package:geotraking/views/profile/components/card/media_sosial_row.dart';
import 'package:geotraking/views/profile/components/card/profile_info_card.dart';
import 'package:geotraking/views/profile/components/profile_list_tile.dart';
import 'package:geotraking/views/profile/components/profile_menu_options.dart';
import 'package:geotraking/views/profile/geosat/components/profile_admin_menu_options.dart';

import 'package:path_provider/path_provider.dart';

class ProfilePage extends StatefulWidget {
  final String selectedLanguage;
  ProfilePage({super.key, required this.selectedLanguage});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _authService = AuthService();
  MemberUser? _user;
  bool _isLoggedIn = false;

  Directory? _directory;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
    _getDirectory();
  }

  _getDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    setState(() {
      _directory = directory;
    });
  }

  _checkLoggedIn() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      setState(() {
        _isLoggedIn = true;
        _user = user;
      });
    }
  }

  _logout() async {
    try {
      final vesselService = VesselService();
      await _authService.logout();
      await _authService.updateLogoutHistory(_user!.id);
      await vesselService.resetCountCache();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    text: 'Profile',
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
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 15),
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Color.fromARGB(255, 127, 183, 126),
            //         shape: BoxShape.circle,
            //       ),
            //       child: IconButton(
            //         icon: Icon(Icons.mode_edit_outlined, color: Colors.white),
            //         onPressed: () {
            //           Navigator.pushNamed(context, AppRoutes.editMyProfile);
            //         },
            //         tooltip: 'Edit Profile',
            //       ),
            //     ),
            //   ),
            //   // Padding(
            //   //   padding: const EdgeInsets.only(right: 15),
            //   //   child: ElevatedButton(
            //   //     onPressed: () {
            //   //       Navigator.pushNamed(context, AppRoutes.editMyProfile);
            //   //     },
            //   //     style: ElevatedButton.styleFrom(
            //   //       backgroundColor: Colors.orangeAccent,
            //   //       shape: CircleBorder(),
            //   //     ),
            //   //     child: const Icon(
            //   //       Icons.mode_edit_outlined,
            //   //       color: Colors.black87,
            //   //     ),
            //   //   ),
            //   // ),
            // ],
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: Text(Localization.getProfile(widget.selectedLanguage)),
      //   titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
      //         color: Colors.black,
      //       ),
      //   backgroundColor: Color.fromARGB(255, 196, 218, 210),
      //   automaticallyImplyLeading: false,
      // ),
      body: _isLoggedIn == false
          ? Center(
              child: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 3)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Getting Data',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Getting Data',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //         bottomLeft: Radius.circular(40),
                  //         bottomRight: Radius.circular(40)),
                  //     gradient: LinearGradient(
                  //       colors: [
                  //         Color.fromARGB(255, 196, 218, 210),
                  //         Color.fromARGB(255, 113, 201, 206),
                  //       ],
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //     ),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.all(AppDefaults.padding),
                  //         child: Center(
                  //           child: Stack(
                  //             alignment: Alignment.bottomRight,
                  //             children: [
                  //               SizedBox(
                  //                 width: 125,
                  //                 height: 125,
                  //                 child: ClipOval(
                  //                   child: AspectRatio(
                  //                     aspectRatio: 1 / 1,
                  //                     child: _user!.avatar != null &&
                  //                             _user!.avatar!.isNotEmpty
                  //                         ? CircleAvatar(
                  //                             radius: 25,
                  //                             backgroundImage: FileImage(
                  //                               File(
                  //                                   '${_directory?.path}/avatar_${_user!.id}.jpg'),
                  //                             ),
                  //                           )
                  //                         : CircleAvatar(
                  //                             radius: 25,
                  //                             backgroundImage: AssetImage(
                  //                                 'assets/images/user.png'),
                  //                           ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               Positioned(
                  //                 bottom: 0,
                  //                 right: 0,
                  //                 child: ElevatedButton(
                  //                   onPressed: () {
                  //                     Navigator.pushNamed(
                  //                         context, AppRoutes.editMyProfile);
                  //                   },
                  //                   style: ElevatedButton.styleFrom(
                  //                     backgroundColor: Colors.orangeAccent,
                  //                     shape: CircleBorder(),
                  //                   ),
                  //                   child: const Icon(
                  //                     Icons.mode_edit_outlined,
                  //                     color: Colors.black87,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Align(
                  //         alignment: Alignment.center,
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Text(
                  //               _user!.name.length > 20
                  //                   ? _user!.name.substring(0, 20) + '...'
                  //                   : _user!.name,
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .titleLarge
                  //                   ?.copyWith(
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black,
                  //                   ),
                  //               maxLines: 2,
                  //               overflow: TextOverflow.ellipsis,
                  //             ),
                  //             const SizedBox(height: 3),
                  //             Text(
                  //               _user!.email,
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .bodyLarge
                  //                   ?.copyWith(color: Colors.black87),
                  //             ),
                  //             Text(
                  //               _user!.noHp,
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .bodyLarge
                  //                   ?.copyWith(color: Colors.black87),
                  //             ),
                  //             const SizedBox(height: 10),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   height: 80,
                  //   margin: const EdgeInsets.all(16.0),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 16.0, vertical: 8.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.red,
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.2),
                  //         spreadRadius: 1,
                  //         blurRadius: 5,
                  //         offset: Offset(0, 2),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Total Kapal',
                  //         style: TextStyle(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //       Text(
                  //         '5',
                  //         style: TextStyle(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(40),
                  //         topRight: Radius.circular(40)),
                  //     gradient: LinearGradient(
                  //       colors: [
                  //         Color.fromARGB(255, 113, 201, 206),
                  //         Color.fromARGB(255, 196, 218, 210),
                  //       ],
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //     ),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       _user!.isAdmin == 1
                  //           ? ProfileAdminMenuOptions(
                  //               selectedLanguage: widget.selectedLanguage)
                  //           : _user!.isAdmin == 2
                  //               ? ProfileAPNMenuOptions()
                  //               : ProfileMemberMenuOptions(
                  //                   selectedLanguage: widget.selectedLanguage),
                  //       SizedBox(
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 15, right: 15),
                  //           child: Column(
                  //             children: [
                  //               ProfileListTile(
                  //                 title: Localization.getSetting(
                  //                     widget.selectedLanguage),
                  //                 icon: Icons.settings,
                  //                 onTap: () => Navigator.pushNamed(
                  //                     context, AppRoutes.settingMyProfile),
                  //               ),
                  //               SizedBox(height: 5),
                  //               ProfileListTile(
                  //                 title: Localization.getLogout(
                  //                     widget.selectedLanguage),
                  //                 icon: Icons.logout_rounded,
                  //                 onTap: _logout,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(height: 130),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.all(15),
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 10, horizontal: 15),
                  //   decoration: BoxDecoration(
                  //     color: Colors.green,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       // Circle Avatar on the left
                  //       Padding(
                  //         padding: const EdgeInsets.all(5),
                  //         child: SizedBox(
                  //           width: 68,
                  //           height: 68,
                  //           child: ClipOval(
                  //             child: AspectRatio(
                  //               aspectRatio: 1 / 1,
                  //               child: _user!.avatar != null &&
                  //                       _user!.avatar!.isNotEmpty
                  //                   ? CircleAvatar(
                  //                       radius: 25,
                  //                       backgroundImage: FileImage(
                  //                         File(
                  //                             '${_directory?.path}/avatar_${_user!.id}.jpg'),
                  //                       ),
                  //                     )
                  //                   : CircleAvatar(
                  //                       radius: 25,
                  //                       backgroundImage: AssetImage(
                  //                           'assets/images/user.png'),
                  //                     ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),

                  //       const SizedBox(width: 12),

                  //       // Name and phone number column
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               _user!.name.length > 20
                  //                   ? _user!.name.substring(0, 20) + '...'
                  //                   : _user!.name,
                  //               style: const TextStyle(
                  //                 fontSize: 16,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //             const SizedBox(height: 3),
                  //             Text(
                  //               // 'phoneNumber',
                  //               _user!.noHp,
                  //               style: const TextStyle(
                  //                 fontSize: 14,
                  //                 color: Colors.white70,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),

                  //       // Arrow icon on the right
                  //       IconButton(
                  //         icon: Icon(Icons.arrow_forward_ios,
                  //             color: Colors.white),
                  //         onPressed: () {
                  //           Navigator.pushNamed(
                  //               context, AppRoutes.editMyProfile);
                  //         },
                  //         tooltip: 'Edit Profile',
                  //       ),
                  //       // Icon(
                  //       //   Icons.arrow_forward_ios,
                  //       //   color: Colors.white,
                  //       //   size: 20,
                  //       // ),
                  //     ],
                  //   ),
                  // ),

                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background_user.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              _user!.avatar == null || _user!.avatar!.isEmpty
                                  ? AssetImage('assets/images/user.png')
                                  : FileImage(
                                      File(
                                          '${_directory?.path}/avatar_${_user!.id}.jpg'),
                                    ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _user!.name.length > 20
                                  ? _user!.name.substring(0, 20) + '...'
                                  : _user!.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              _user!.noHp,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.editMyProfile);
                          },
                        ),
                      ],
                    ),
                  ),
                  ProfileInfoCard(),
                  SizedBox(
                    child: Container(
                      height: 6,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  Container(
                    // margin: const EdgeInsets.all(6.0),
                    padding: const EdgeInsets.all(6),
                    child: _user!.isAdmin == 1
                        ? ProfileAdminMenuOptions(
                            selectedLanguage: widget.selectedLanguage)
                        : _user!.isAdmin == 2
                            ? ProfileAPNMenuOptions()
                            : ProfileMemberMenuOptions(
                                selectedLanguage: widget.selectedLanguage),
                  ),
                  SizedBox(
                    child: Container(
                      height: 6,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  Container(
                    // margin: const EdgeInsets.all(6.0),
                    padding: const EdgeInsets.all(6),
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            // ProfileListTile(
                            //   title: 'Panduan Layanan',
                            //   icon: Icons.info_outline_rounded,
                            //   onTap: () => Navigator.pushNamed(
                            //       context, AppRoutes.logBookHasilPenangkapan),
                            // ),
                            // const Divider(
                            //   thickness: 0.5,
                            //   color: Colors.black,
                            // ),
                            ProfileListTile(
                              title: Localization.privacyPolice(
                                  widget.selectedLanguage),
                              icon: Icons.privacy_tip_outlined,
                              onTap: () => Navigator.pushNamed(
                                  context, AppRoutes.privacyPolice),
                            ),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                            MediaSosialRow(),
                            // ProfileListTile(
                            //   title: 'Media Sosial',
                            //   icon: Icons.perm_media_outlined,
                            //   onTap: () => Navigator.pushNamed(context,
                            //       AppRoutes.logBookHistoryHasilPenangkapan),
                            // ),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      height: 6,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(6),
                  //   child: Column(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 16),
                  //         child: Align(
                  //           alignment: Alignment.topLeft,
                  //           child: Text(
                  //             'Hubungi Kami',
                  //             style: TextStyle(
                  //                 fontSize: 22,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.black,
                  //                 fontStyle: FontStyle.italic),
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(
                  //             right: 16.0, left: 16, bottom: 16, top: 10),
                  //         child: Container(
                  //           padding: EdgeInsets.all(16),
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(8),
                  //             boxShadow: [
                  //               BoxShadow(
                  //                   color: Colors.grey.shade400,
                  //                   blurRadius: 5,
                  //                   spreadRadius: 1),
                  //             ],
                  //           ),
                  //           child: Row(
                  //             children: [
                  //               Icon(FontAwesomeIcons.whatsapp,
                  //                   size: 40, color: Colors.green),
                  //               SizedBox(width: 16),
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     'Geosat',
                  //                     style: TextStyle(
                  //                         fontSize: 16,
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                   SizedBox(height: 4),
                  //                   Text(
                  //                     '+6281908192559',
                  //                     style: TextStyle(
                  //                         color: Colors.grey, fontSize: 14),
                  //                   ),
                  //                 ],
                  //               ),
                  //               Spacer(),
                  //               IconButton(
                  //                 icon: const Icon(
                  //                   Icons.arrow_forward_ios,
                  //                   color: Colors.black,
                  //                 ),
                  //                 onPressed: () {
                  //                   Navigator.pushNamed(
                  //                       context, AppRoutes.editMyProfile);
                  //                 },
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  ContactCard(),
                  SizedBox(
                    child: Container(
                      height: 6,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  Container(
                    // margin: const EdgeInsets.all(6.0),
                    padding: const EdgeInsets.all(6),
                    child: Ink(
                      height: 55,
                      child: InkWell(
                        onTap: _logout,
                        borderRadius: AppDefaults.borderRadius,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: AppDefaults.borderRadius,
                                  ),
                                  child: Text(
                                    'Version 1.0.4',
                                    style: TextStyle(color: Colors.black54),
                                  )),
                              // const SizedBox(width: 16),
                              Spacer(),
                              Text(
                                Localization.logout(widget.selectedLanguage),
                                // 'Logout',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   child: Container(
                  //     height: 6,
                  //     color: Colors.grey.shade200,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(AppDefaults.padding),
                  //   child: Center(
                  //     child: Stack(
                  //       alignment: Alignment.bottomRight,
                  //       children: [
                  //         SizedBox(
                  //           width: 125,
                  //           height: 125,
                  //           child: ClipOval(
                  //             child: AspectRatio(
                  //               aspectRatio: 1 / 1,
                  //               child: _user!.avatar != null &&
                  //                       _user!.avatar!.isNotEmpty
                  //                   ? CircleAvatar(
                  //                       radius: 25,
                  //                       backgroundImage: FileImage(
                  //                         File(
                  //                             '${_directory?.path}/avatar_${_user!.id}.jpg'),
                  //                       ),
                  //                     )
                  //                   : CircleAvatar(
                  //                       radius: 25,
                  //                       backgroundImage: AssetImage(
                  //                           'assets/images/user.png'),
                  //                     ),
                  //             ),
                  //           ),
                  //         ),
                  //         // Positioned(
                  //         //   bottom: 0,
                  //         //   right: 0,
                  //         //   child: ElevatedButton(
                  //         //     onPressed: () {
                  //         //       Navigator.pushNamed(
                  //         //           context, AppRoutes.editMyProfile);
                  //         //     },
                  //         //     style: ElevatedButton.styleFrom(
                  //         //       backgroundColor: Colors.orangeAccent,
                  //         //       shape: CircleBorder(),
                  //         //     ),
                  //         //     child: const Icon(
                  //         //       Icons.mode_edit_outlined,
                  //         //       color: Colors.black87,
                  //         //     ),
                  //         //   ),
                  //         // ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         _user!.name.length > 20
                  //             ? _user!.name.substring(0, 20) + '...'
                  //             : _user!.name,
                  //         style:
                  //             Theme.of(context).textTheme.titleLarge?.copyWith(
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.black,
                  //                 ),
                  //         maxLines: 2,
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //       const SizedBox(height: 3),
                  //       Text(
                  //         _user!.email,
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodyLarge
                  //             ?.copyWith(color: Colors.black87),
                  //       ),
                  //       Text(
                  //         _user!.noHp,
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodyLarge
                  //             ?.copyWith(color: Colors.black87),
                  //       ),
                  //       const SizedBox(height: 10),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 30, top: 20),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           Localization.account(widget.selectedLanguage),
                  //           // 'Account',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .titleMedium
                  //               ?.copyWith(color: Colors.black54),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.all(16.0),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 16.0, vertical: 8.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.withOpacity(0.2),
                  //     borderRadius: BorderRadius.circular(40),
                  //   ),
                  //   child: _user!.isAdmin == 1
                  //       ? ProfileAdminMenuOptions(
                  //           selectedLanguage: widget.selectedLanguage)
                  //       : _user!.isAdmin == 2
                  //           ? ProfileAPNMenuOptions()
                  //           : ProfileMemberMenuOptions(
                  //               selectedLanguage: widget.selectedLanguage),
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.only(left: 30),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           'Console',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .titleMedium
                  //               ?.copyWith(color: Colors.black54),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.all(16.0),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 16.0, vertical: 8.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.withOpacity(0.2),
                  //     borderRadius: BorderRadius.circular(40),
                  //   ),
                  //   child: SizedBox(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(10),
                  //       child: Column(
                  //         children: [
                  //           ProfileListTile(
                  //             title: 'Console',
                  //             icon: Icons.terminal,
                  //             onTap: () => Navigator.pushNamed(context,
                  //                 AppRoutes.consolePage),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 30),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           Localization.report(widget.selectedLanguage),
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .titleMedium
                  //               ?.copyWith(color: Colors.black54),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.all(16.0),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 16.0, vertical: 8.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.withOpacity(0.2),
                  //     borderRadius: BorderRadius.circular(40),
                  //   ),
                  //   child: SizedBox(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(10),
                  //       child: Column(
                  //         children: [
                  //           // ProfileListTile(
                  //           //   title: 'Running Hours',
                  //           //   icon: Icons.lock_clock,
                  //           //   onTap: () => Navigator.pushNamed(
                  //           //       context, AppRoutes.logBookHasilPenangkapan),
                  //           // ),
                  //           // const Divider(
                  //           //   thickness: 0.5,
                  //           //   color: Colors.black,
                  //           // ),
                  //           ProfileListTile(
                  //             title: Localization.jarakTempuh(widget.selectedLanguage),
                  //             // title: 'Jarak Tempuh',
                  //             icon: Icons.track_changes,
                  //             onTap: () => Navigator.pushNamed(context,
                  //                 AppRoutes.reportHistoryTrakingJarakTempuh),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 30),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           Localization.logBook(widget.selectedLanguage),
                  //           // 'Log Book',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .titleMedium
                  //               ?.copyWith(color: Colors.black54),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.all(16.0),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 16.0, vertical: 8.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.withOpacity(0.2),
                  //     borderRadius: BorderRadius.circular(40),
                  //   ),
                  //   child: SizedBox(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(10),
                  //       child: Column(
                  //         children: [
                  //           ProfileListTile(
                  //             title: 'Hasil Tangkapan',
                  //             icon: Icons.archive,
                  //             onTap: () => Navigator.pushNamed(
                  //                 context, AppRoutes.logBookHasilPenangkapan),
                  //           ),
                  //           const Divider(
                  //             thickness: 0.5,
                  //             color: Colors.black,
                  //           ),
                  //           ProfileListTile(
                  //             title: 'Histori Tangkapan',
                  //             icon: Icons.history,
                  //             onTap: () => Navigator.pushNamed(context,
                  //                 AppRoutes.logBookHistoryHasilPenangkapan),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 30),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           Localization.preferences(widget.selectedLanguage),
                  //           // 'Preferences',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .titleMedium
                  //               ?.copyWith(color: Colors.black54),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.all(16.0),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 16.0, vertical: 8.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.withOpacity(0.2),
                  //     borderRadius: BorderRadius.circular(40),
                  //   ),
                  //   child: SizedBox(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(10),
                  //       child: Column(
                  //         children: [
                  //           ProfileListTile(
                  //             title: Localization.getNotification(
                  //                 widget.selectedLanguage),
                  //             icon: Icons.notifications,
                  //             onTap: () => Navigator.pushNamed(
                  //                 context, AppRoutes.notificationPage),
                  //           ),
                  //           const Divider(
                  //             thickness: 0.5,
                  //             color: Colors.black,
                  //           ),
                  //           ProfileListTile(
                  //             title: Localization.getHelpCenter(
                  //                 widget.selectedLanguage),
                  //             icon: Icons.live_help_outlined,
                  //             onTap: () => Navigator.pushNamed(
                  //                 context, AppRoutes.supportPage),
                  //           ),
                  //           const Divider(
                  //             thickness: 0.5,
                  //             color: Colors.black,
                  //           ),
                  //           ProfileListTile(
                  //             title: Localization.getSetting(
                  //                 widget.selectedLanguage),
                  //             icon: Icons.settings,
                  //             onTap: () => Navigator.pushNamed(
                  //                 context, AppRoutes.settingMyProfile),
                  //           ),
                  //           const Divider(
                  //             thickness: 0.5,
                  //             color: Colors.black,
                  //           ),
                  //           Ink(
                  //             height: 55,
                  //             child: InkWell(
                  //               onTap: _logout,
                  //               borderRadius: AppDefaults.borderRadius,
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 child: Row(
                  //                   children: [
                  //                     Container(
                  //                       padding: const EdgeInsets.all(8),
                  //                       decoration: BoxDecoration(
                  //                         color: Colors.white,
                  //                         borderRadius:
                  //                             AppDefaults.borderRadius,
                  //                       ),
                  //                       child: Icon(
                  //                         Icons.logout_rounded,
                  //                         size: 20,
                  //                         color: Colors.red,
                  //                       ),
                  //                     ),
                  //                     const SizedBox(width: 16),
                  //                     Text(
                  //                       Localization.logout(
                  //                           widget.selectedLanguage),
                  //                       // 'Logout',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .bodyLarge
                  //                           ?.copyWith(color: Colors.red),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.all(AppDefaults.padding),
                  //   child: Row(
                  //     children: [
                  //       const SizedBox(width: AppDefaults.padding),
                  //       SizedBox(
                  //         width: 50,
                  //         height: 50,
                  //         child: ClipOval(
                  //           child: AspectRatio(
                  //             aspectRatio: 1 / 1,
                  //             child: _user!.avatar != null &&
                  //                     _user!.avatar!.isNotEmpty
                  //                 ? CircleAvatar(
                  //                     radius: 25,
                  //                     backgroundImage: FileImage(
                  //                       File(
                  //                           '${_directory?.path}/avatar_${_user!.id}.jpg'),
                  //                     ),
                  //                   )
                  //                 : CircleAvatar(
                  //                     radius: 25,
                  //                     backgroundImage:
                  //                         AssetImage('assets/images/user.png'),
                  //                   ),
                  //           ),
                  //         ),
                  //       ),
                  //       // SizedBox(
                  //       //     width: 50,
                  //       //     height: 50,
                  //       //     child: CircleAvatar(
                  //       //       radius: 25,
                  //       //       backgroundImage: _user!.avatar != null
                  //       //           ? FileImage(File(
                  //       //               '${_directory?.path}/avatar_${_user!.id}.jpg'))
                  //       //           : AssetImage('assets/images/user.png')
                  //       //               as ImageProvider,
                  //       //     )),
                  //       const SizedBox(width: AppDefaults.padding),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             // _user!.name,
                  //             _user!.name.length > 20
                  //                 ? _user!.name.substring(0, 20) + '...'
                  //                 : _user!.name,
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .titleMedium
                  //                 ?.copyWith(
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.black,
                  //                 ),
                  //             maxLines: 2,
                  //             overflow: TextOverflow.ellipsis,
                  //           ),
                  //           const SizedBox(height: 1),
                  //           Text(
                  //             _user!.email,
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyMedium
                  //                 ?.copyWith(color: Colors.black87),
                  //           ),
                  //           Text(
                  //             _user!.noHp,
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyMedium
                  //                 ?.copyWith(color: Colors.black87),
                  //           ),
                  //         ],
                  //       ),
                  //       const Spacer(),
                  //       SizedBox(
                  //         width: 50,
                  //         height: 50,
                  //         child: Center(
                  //           child: ElevatedButton(
                  //             onPressed: () {
                  //               Navigator.pushNamed(
                  //                   context, AppRoutes.editMyProfile);
                  //             },
                  //             style: ElevatedButton.styleFrom(
                  //               backgroundColor: Colors.grey.shade300,
                  //             ),
                  //             child: const Icon(
                  //               Icons.mode_edit_outlined,
                  //               color: Colors.black,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const Padding(
                  //   padding: EdgeInsets.only(
                  //     left: 15,
                  //     right: 15,
                  //   ),
                  //   child: Divider(
                  //     thickness: 0.6,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // _user!.isAdmin == 1
                  //     ? ProfileAdminMenuOptions(
                  //         selectedLanguage: widget.selectedLanguage)
                  //     : _user!.isAdmin == 2
                  //         ? ProfileAPNMenuOptions()
                  //         : ProfileMemberMenuOptions(
                  //             selectedLanguage: widget.selectedLanguage),
                  // SizedBox(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 15, right: 15),
                  //     child: Column(
                  //       children: [
                  //         ProfileListTile(
                  //           title: Localization.getSetting(
                  //               widget.selectedLanguage),
                  //           icon: Icons.settings,
                  //           onTap: () => Navigator.pushNamed(
                  //               context, AppRoutes.settingMyProfile),
                  //         ),
                  //         SizedBox(height: 5),
                  //         ProfileListTile(
                  //           title:
                  //               Localization.getLogout(widget.selectedLanguage),
                  //           icon: Icons.logout_rounded,
                  //           onTap: _logout,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 110),
                ],
              ),
            ),
    );
  }
}
