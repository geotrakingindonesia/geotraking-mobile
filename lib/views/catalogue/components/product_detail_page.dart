// import 'dart:io';

// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/views/catalogue/components/hubungi_kami_button.dart';
import 'package:geotraking/views/catalogue/components/see_more_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_defaults.dart';
import '../../../core/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: false,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Details'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        // centerTitle: true,
        // backgroundColor: const Color.fromARGB(185, 113, 201, 206),
        backgroundColor: const Color.fromARGB(255, 196, 218, 210),
      ),
      body: Container(
        // color: const Color.fromARGB(185, 113, 201, 206),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 196, 218, 210),
              Color.fromARGB(255, 113, 201, 206),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          // child: Image.network(
                          //   product.image,
                          //   fit: BoxFit.cover,
                          // ),
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.nama_product,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.deskripsi,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SeeMoreDetailPage(link: product.link),
                          ),
                        );
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'See More..',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: HubungiKamiButton(
            onHubungiKamiButtonTap: () async {
              String whatsAppUrl =
                  'https://wa.me/6281908192559?text=Hallo+Geomatika+Satelit+Indonesia';
              if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
                await launchUrl(Uri.parse(whatsAppUrl));
              } else {
                throw 'Could not launch $whatsAppUrl';
              }
            },
          ),
        ),
      ),
    );
  }
}
