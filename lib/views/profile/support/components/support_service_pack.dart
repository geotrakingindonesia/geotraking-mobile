// ignore_for_file: prefer_const_constructors

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/views/profile/support/components/support_tile.dart';

class SupportServicePack extends StatelessWidget {
  const SupportServicePack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: Duration(milliseconds: 1000),
      child: ListView(
        padding: const EdgeInsets.only(top: 8),
        children: const [
          SupportTile(
            title: 'Staff Marketing',
            contact: 'sales@geosat.co.id\n081908192559',
            imageUrl: 'assets/images/banner_marketing.png',
          ),
          SupportTile(
            title: 'Customer Care',
            contact: 'technical.support@geosat.co.id\n085951306522',
            imageUrl: 'assets/images/banner_customer_care.png',
          ),
          // SupportTile(
          //   title: 'Contact Directly',
          //   contact: 'sales@geosat.co.id\n(021) 4205309',
          //   imageUrl: 'assets/images/banner_contact.png',
          // ),
          SupportTile(
            title: 'Technical Support',
            contact: 'geotrakingindonesia@gmail.com\n082114113827 / 081282222951',
            imageUrl: 'assets/images/banner_tech_support.png',
          ),
          // SupportTile(
          //   title: 'Technical Support 2',
          //   contact: 'geotrakingindonesia@gmail.com\n081282222951',
          //   imageUrl: 'assets/images/banner_tech_support.png',
          // ),
          SupportTile(
            title: 'IT Support',
            contact: 'geotrakingindonesia@gmail.com\n081384197696',
            imageUrl: 'assets/images/banner_contact.png',
          ),
        ],
      ),
    );
  }
}
