import 'package:flutter/material.dart';
import 'package:geotraking/core/models/member.dart';
import 'package:geotraking/core/routes/app_routes.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/views/auth/login_page.dart';
import 'package:geotraking/views/profile/profile_page.dart';
import 'icon_categories.dart';

class Categories extends StatefulWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late ScrollController _scrollController;
  final AuthService _authService = AuthService();
  MemberUser? _user;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
    _scrollController = ScrollController();
  }

  _checkLoggedIn() async {
    final user = await _authService.getCurrentUser();

    if (user != null) {
      print(
          'Current User: ${user.id}, ${user.name}, ${user.email}, ${user.noHp}, ${user.isAdmin}, ${user.avatar}');
      setState(() {
        _user = user;
        // if (_user!.isAdmin == 1) {
        _isLoggedIn = true;
        // }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _scrollController = ScrollController();
  // }

  void _showBottomSheetForOthers(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(6.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 16.0, left: 16.0, right: 16.0, top: 16.0),
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 10,
                    children: [
                      IconsCategories(
                        label: 'Airtime',
                        icon: 'assets/icons/card.svg',
                        onTap: () {
                          _isLoggedIn
                              ? Navigator.pushNamed(
                                  context, AppRoutes.airtimePage)
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Not Logged In'),
                                      content: Text(
                                          'Please log in to access the Airtime.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Close'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()));
                                          },
                                          child: Text('Login'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                        },
                      ),
                      IconsCategories(
                        label: 'TopUp',
                        icon: 'assets/icons/money.svg',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.topUpPage);
                        },
                      ),
                      IconsCategories(
                        label: 'IoT',
                        icon: 'assets/icons/iot.svg',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.iotPage);
                        },
                      ),
                      IconsCategories(
                        label: 'Salmon',
                        icon: 'assets/icons/gps.svg',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.salmonPage);
                        },
                      ),
                      IconsCategories(
                        label: 'Iridium',
                        icon: 'assets/icons/chat.svg',
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.iridiumMessagingWebviewPage);
                        },
                      ),
                      IconsCategories(
                        label: 'WppRI',
                        icon: 'assets/icons/map.svg',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.wppPage);
                        },
                      ),
                      IconsCategories(
                        label: 'BasarnasRI',
                        icon: 'assets/icons/lifebuoy.svg',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.basarnasPage);
                        },
                      ),
                      IconsCategories(
                        label: 'PortRI',
                        icon: 'assets/icons/harbor.svg',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.portRiPage);
                        },
                      ),
                      IconsCategories(
                        label: 'BBM',
                        icon: 'assets/icons/fuel.svg',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.calcBbmPage);
                        },
                      ),
                    ].map((widget) {
                      return Container(
                        width:
                            (MediaQuery.of(context).size.width - 32 - 30) / 4,
                        child: widget,
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          // if (_isLoggedIn)
          IconsCategories(
            label: 'Airtime',
            icon: 'assets/icons/card.svg',
            onTap: () {
              _isLoggedIn
                  ? Navigator.pushNamed(context, AppRoutes.airtimePage)
                  : showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Not Logged In'),
                          content: Text('Please log in to access the Airtime.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Close'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              child: Text('Login'),
                            ),
                          ],
                        );
                      },
                    );
            },
          ),
          IconsCategories(
            label: 'TopUp',
            icon: 'assets/icons/money.svg',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.topUpPage);
            },
          ),
          IconsCategories(
            label: 'IoT',
            icon: 'assets/icons/iot.svg',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.iotPage);
            },
          ),
          IconsCategories(
            label: 'Salmon',
            icon: 'assets/icons/gps.svg',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.salmonPage);
            },
          ),
          IconsCategories(
            label: 'Iridium',
            icon: 'assets/icons/chat.svg',
            onTap: () {
              Navigator.pushNamed(
                  context, AppRoutes.iridiumMessagingWebviewPage);
            },
          ),
          IconsCategories(
            label: 'WppRI',
            icon: 'assets/icons/map.svg',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.wppPage);
            },
          ),
          IconsCategories(
            label: 'BasarnasRI',
            icon: 'assets/icons/lifebuoy.svg',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.basarnasPage);
            },
          ),
          IconsCategories(
            label: 'Others',
            icon: 'assets/icons/others.svg',
            onTap: () {
              _showBottomSheetForOthers(context);
            },
          ),
        ].map((widget) {
          return Container(
            width: (MediaQuery.of(context).size.width - 32 - 30) / 4,
            child: widget,
          );
        }).toList(),
      ),
    );
  }
}
