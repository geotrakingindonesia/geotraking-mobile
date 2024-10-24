import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/routes/app_routes.dart';
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
    //       // padding: const EdgeInsets.only(left: 5, right: 5),
    //       child: Container(
    //         decoration: const BoxDecoration(
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(5),
    //             bottomLeft: Radius.circular(5),
    //             topRight: Radius.circular(5),
    //             bottomRight: Radius.circular(5),
    //           ),
    //         ),
    //         child: SingleChildScrollView(
    //           scrollDirection: Axis.horizontal,
    //           controller: _scrollController,
    //           child: Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   IconsCategories(
    //                     label: 'Airtime',
    //                     icon: FontAwesomeIcons.moneyBillTransfer,
    //                     onTap: () {
    //                       Navigator.pushNamed(context, AppRoutes.airtimePage);
    //                     },
    //                   ),
    //                   IconsCategories(
    //                     label: 'Pulsa',
    //                     icon: Icons.wifi_calling_3,
    //                     onTap: () {
    //                       Navigator.pushNamed(context, AppRoutes.pulsaPage);
    //                     },
    //                   ),
    //                   IconsCategories(
    //                     label: 'IoT',
    //                     icon: Icons.calculate,
    //                     onTap: () {
    //                       Navigator.pushNamed(context, AppRoutes.iotPage);
    //                     },
    //                   ),
    //                   IconsCategories(
    //                     label: 'Salmon',
    //                     icon: FontAwesomeIcons.locationCrosshairs,
    //                     onTap: () {
    //                       Navigator.pushNamed(context, AppRoutes.salmonPage);
    //                     },
    //                   ),
    //                   IconsCategories(
    //                     label: 'WppRI',
    //                     icon: FontAwesomeIcons.mapLocationDot,
    //                     onTap: () {
    //                       Navigator.pushNamed(context, AppRoutes.wppPage);
    //                     },
    //                   ),
    //                   IconsCategories(
    //                     label: 'BasarnasRI',
    //                     icon: FontAwesomeIcons.lifeRing,
    //                     onTap: () {
    //                       Navigator.pushNamed(context, AppRoutes.basarnasPage);
    //                     },
    //                   ),
    //                   IconsCategories(
    //                     label: 'PortRI',
    //                     icon: FontAwesomeIcons.towerObservation,
    //                     onTap: () {
    //                       Navigator.pushNamed(context, AppRoutes.portRiPage);
    //                     },
    //                   ),

    //                   IconsCategories(
    //                     label: 'BBM',
    //                     icon: FontAwesomeIcons.oilWell,
    //                     onTap: () {
    //                       Navigator.pushNamed(context, AppRoutes.calcBbmPage);
    //                     },
    //                   ),
    //                   // IconsCategories(
    //                   //   label: 'OpenFiber',
    //                   //   icon: FontAwesomeIcons.wifi,
    //                   //   onTap: () {
    //                   //     Navigator.pushNamed(context, AppRoutes.openFiberPage);
    //                   //   },
    //                   // ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
    return Padding(
      // padding: EdgeInsets.all(16.0),
      padding: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          IconsCategories(
            label: 'Airtime',
            icon: FontAwesomeIcons.moneyBillTransfer,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.airtimePage);
            },
          ),
          IconsCategories(
            label: 'TopUp',
            icon: Icons.smartphone_rounded,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.topUpPage);
            },
          ),
          IconsCategories(
            label: 'IoT',
            icon: Icons.calculate,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.iotPage);
            },
          ),
          IconsCategories(
            label: 'Salmon',
            icon: FontAwesomeIcons.locationCrosshairs,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.salmonPage);
            },
          ),
          IconsCategories(
            label: 'WppRI',
            icon: FontAwesomeIcons.mapLocationDot,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.wppPage);
            },
          ),
          IconsCategories(
            label: 'BasarnasRI',
            icon: FontAwesomeIcons.lifeRing,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.basarnasPage);
            },
          ),
          IconsCategories(
            label: 'PortRI',
            icon: FontAwesomeIcons.towerObservation,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.portRiPage);
            },
          ),
          IconsCategories(
            label: 'BBM',
            icon: FontAwesomeIcons.oilWell,
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.calcBbmPage);
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
