// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_field, prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/localization_language.dart';
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
            centerTitle: false,
          ),
        ),
      ),
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
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 22, 66, 60),
                          Colors.greenAccent
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              _user!.avatar == null || _user!.avatar!.isEmpty
                                  // ? AssetImage('assets/images/user.png')
                                  ? CachedNetworkImageProvider(
                                      'https://drive.google.com/uc?export=view&id=1xkE-1cZfmNIwNnXwMxGF1ltw4vKkdhGS',
                                    )
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
                    padding: const EdgeInsets.all(6),
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ProfileListTile(
                              title: Localization.preferences(
                                  widget.selectedLanguage),
                              // 'Map Preferences',
                              icon: Icons.room_preferences_rounded,
                              onTap: () => Navigator.pushNamed(
                                  context, AppRoutes.preferences),
                            ),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                            ProfileListTile(
                              title: Localization.getHelpCenter(
                                  widget.selectedLanguage),
                              icon: Icons.live_help_outlined,
                              onTap: () => Navigator.pushNamed(
                                  context, AppRoutes.supportPage),
                            ),
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
                  Container(
                    padding: const EdgeInsets.all(6),
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
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
                  ContactCard(),
                  SizedBox(
                    child: Container(
                      height: 6,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  Container(
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
                                    'Version 1.0.13',
                                    style: TextStyle(color: Colors.black54),
                                  )),
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
                  SizedBox(
                    child: Container(
                      height: 6,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  SizedBox(height: 75),
                ],
              ),
            ),

      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       pinned: false,
      //       floating: true,
      //       snap: false,
      //       title: RichText(
      //         text: TextSpan(
      //           children: [
      //             TextSpan(
      //               text: 'Geo',
      //               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
      //                     color: Colors.black,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //             ),
      //             TextSpan(
      //               text: 'Profile',
      //               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
      //                     color: Color.fromARGB(255, 13, 124, 102),
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       // flexibleSpace: FlexibleSpaceBar(
      //       //   title: RichText(
      //       //     text: TextSpan(
      //       //       children: [
      //       //         TextSpan(
      //       //           text: 'Geo',
      //       //           style:
      //       //               Theme.of(context).textTheme.headlineMedium?.copyWith(
      //       //                     color: Colors.black,
      //       //                     fontWeight: FontWeight.bold,
      //       //                   ),
      //       //         ),
      //       //         TextSpan(
      //       //           text: 'Profile',
      //       //           style:
      //       //               Theme.of(context).textTheme.headlineMedium?.copyWith(
      //       //                     color: Color.fromARGB(255, 13, 124, 102),
      //       //                     fontWeight: FontWeight.bold,
      //       //                   ),
      //       //         ),
      //       //       ],
      //       //     ),
      //       //   ),
      //       // ),
      //       automaticallyImplyLeading: false,
      //       backgroundColor: Colors.white,
      //       // elevation: 0,
      //       // expandedHeight: 60.0,
      //     ),
      //     SliverList(
      //       delegate: SliverChildListDelegate(
      //         [
      //           if (!_isLoggedIn)
      //             Center(
      //               child: FutureBuilder(
      //                 future: Future.delayed(const Duration(seconds: 3)),
      //                 builder: (context, snapshot) {
      //                   return Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Text(
      //                         'Getting Data',
      //                         style: Theme.of(context)
      //                             .textTheme
      //                             .bodyLarge
      //                             ?.copyWith(color: Colors.black),
      //                       ),
      //                       SizedBox(width: 8),
      //                       SizedBox(
      //                         width: 18,
      //                         height: 18,
      //                         child: CircularProgressIndicator(
      //                           color: Colors.black,
      //                           strokeWidth: 2,
      //                         ),
      //                       ),
      //                     ],
      //                   );
      //                 },
      //               ),
      //             )
      //           else
      //             Column(
      //               children: [
      //                 Container(
      //                   margin: EdgeInsets.all(16),
      //                   padding: EdgeInsets.all(16),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.all(Radius.circular(10)),
      //                     gradient: LinearGradient(
      //                       begin: Alignment.topLeft,
      //                       end: Alignment.bottomRight,
      //                       colors: [
      //                         Color.fromARGB(255, 22, 66, 60),
      //                         Colors.greenAccent
      //                       ],
      //                     ),
      //                   ),
      //                   child: Row(
      //                     children: [
      //                       CircleAvatar(
      //                         radius: 30,
      //                         backgroundImage: _user!.avatar == null ||
      //                                 _user!.avatar!.isEmpty
      //                             // ? AssetImage('assets/images/user.png')
      //                             ? CachedNetworkImageProvider(
      //                                 'https://drive.google.com/uc?export=view&id=1xkE-1cZfmNIwNnXwMxGF1ltw4vKkdhGS',
      //                               )
      //                             : FileImage(
      //                                 File(
      //                                     '${_directory?.path}/avatar_${_user!.id}.jpg'),
      //                               ),
      //                       ),
      //                       SizedBox(width: 16),
      //                       Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Text(
      //                             _user!.name.length > 20
      //                                 ? _user!.name.substring(0, 20) + '...'
      //                                 : _user!.name,
      //                             style: TextStyle(
      //                                 color: Colors.white,
      //                                 fontSize: 18,
      //                                 fontWeight: FontWeight.bold),
      //                           ),
      //                           SizedBox(height: 4),
      //                           Text(
      //                             _user!.noHp,
      //                             style: TextStyle(
      //                                 color: Colors.white, fontSize: 14),
      //                           ),
      //                         ],
      //                       ),
      //                       Spacer(),
      //                       IconButton(
      //                         icon: const Icon(
      //                           Icons.arrow_forward_ios,
      //                           color: Colors.white,
      //                         ),
      //                         onPressed: () {
      //                           Navigator.pushNamed(
      //                               context, AppRoutes.editMyProfile);
      //                         },
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 ProfileInfoCard(),
      //                 SizedBox(
      //                   child: Container(
      //                     height: 6,
      //                     color: Colors.grey.shade200,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: const EdgeInsets.all(6),
      //                   child: _user!.isAdmin == 1
      //                       ? ProfileAdminMenuOptions(
      //                           selectedLanguage: widget.selectedLanguage)
      //                       : _user!.isAdmin == 2
      //                           ? ProfileAPNMenuOptions()
      //                           : ProfileMemberMenuOptions(
      //                               selectedLanguage: widget.selectedLanguage),
      //                 ),
      //                 SizedBox(
      //                   child: Container(
      //                     height: 6,
      //                     color: Colors.grey.shade200,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: const EdgeInsets.all(6),
      //                   child: SizedBox(
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(10),
      //                       child: Column(
      //                         children: [
      //                           ProfileListTile(
      //                             title: Localization.preferences(
      //                                 widget.selectedLanguage),
      //                             // 'Map Preferences',
      //                             icon: Icons.room_preferences_rounded,
      //                             onTap: () => Navigator.pushNamed(
      //                                 context, AppRoutes.preferences),
      //                           ),
      //                           const Divider(
      //                             thickness: 0.5,
      //                             color: Colors.black,
      //                           ),
      //                           ProfileListTile(
      //                             title: Localization.getHelpCenter(
      //                                 widget.selectedLanguage),
      //                             icon: Icons.live_help_outlined,
      //                             onTap: () => Navigator.pushNamed(
      //                                 context, AppRoutes.supportPage),
      //                           ),
      //                           const Divider(
      //                             thickness: 0.5,
      //                             color: Colors.black,
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   child: Container(
      //                     height: 6,
      //                     color: Colors.grey.shade200,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: const EdgeInsets.all(6),
      //                   child: SizedBox(
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(10),
      //                       child: Column(
      //                         children: [
      //                           ProfileListTile(
      //                             title: Localization.privacyPolice(
      //                                 widget.selectedLanguage),
      //                             icon: Icons.privacy_tip_outlined,
      //                             onTap: () => Navigator.pushNamed(
      //                                 context, AppRoutes.privacyPolice),
      //                           ),
      //                           const Divider(
      //                             thickness: 0.5,
      //                             color: Colors.black,
      //                           ),
      //                           MediaSosialRow(),
      //                           const Divider(
      //                             thickness: 0.5,
      //                             color: Colors.black,
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   child: Container(
      //                     height: 6,
      //                     color: Colors.grey.shade200,
      //                   ),
      //                 ),
      //                 ContactCard(),
      //                 SizedBox(
      //                   child: Container(
      //                     height: 6,
      //                     color: Colors.grey.shade200,
      //                   ),
      //                 ),
      //                 Container(
      //                   padding: const EdgeInsets.all(6),
      //                   child: Ink(
      //                     height: 55,
      //                     child: InkWell(
      //                       onTap: _logout,
      //                       borderRadius: AppDefaults.borderRadius,
      //                       child: Padding(
      //                         padding: const EdgeInsets.all(8.0),
      //                         child: Row(
      //                           children: [
      //                             Container(
      //                                 padding: const EdgeInsets.all(8),
      //                                 decoration: BoxDecoration(
      //                                   color: Colors.white,
      //                                   borderRadius: AppDefaults.borderRadius,
      //                                 ),
      //                                 child: Text(
      //                                   'Version 1.0.5',
      //                                   style: TextStyle(color: Colors.black54),
      //                                 )),
      //                             Spacer(),
      //                             Text(
      //                               Localization.logout(
      //                                   widget.selectedLanguage),
      //                               // 'Logout',
      //                               style: Theme.of(context)
      //                                   .textTheme
      //                                   .bodyLarge
      //                                   ?.copyWith(color: Colors.red),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(height: 110),
      //               ],
      //             ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
