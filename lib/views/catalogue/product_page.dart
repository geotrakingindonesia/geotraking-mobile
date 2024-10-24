// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/models/catalog_model.dart';
import 'package:geotraking/core/models/product.dart';
import 'package:geotraking/views/catalogue/components/hubungi_kami_button.dart';
import 'package:geotraking/views/catalogue/components/product_detail_page.dart';
import 'package:geotraking/views/catalogue/components/tile_square.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatefulWidget {
  // final String selectedLanguage;
  // const ProductPage({Key? key, required this.selectedLanguage})
  const ProductPage({
    Key? key,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<List<Product>> _loadProducts() async {
    final jsonString =
        await rootBundle.loadString('assets/jsons/catalogue.json');
    final jsonData = jsonDecode(jsonString) as List<dynamic>;
    final products =
        jsonData.map((jsonProduct) => Product.fromJson(jsonProduct)).toList();
    return products;
  }

  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startBannerAutoScroll();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    text: 'Catalog',
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
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // SizedBox(
            //   height: 20,
            // ),
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
                      Container(
                        child: ClipRRect(
                          borderRadius: AppDefaults.borderRadius,
                          child: Image.asset(
                            'assets/images/banner1.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        child: ClipRRect(
                          borderRadius: AppDefaults.borderRadius,
                          child: Image.asset(
                            'assets/images/banner2.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        child: ClipRRect(
                          borderRadius: AppDefaults.borderRadius,
                          child: Image.asset(
                            'assets/images/banner3.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            FutureBuilder<List<Product>>(
              future: _loadProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 25,
                      children: snapshot.data!
                          .map(
                            (product) => InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailPage(product: product),
                                  ),
                                );
                              },
                              child: TileSquareProduct(
                                data: CatalogModel(
                                  id: product.id,
                                  name: product.nama_product,
                                  cover: product.image,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 25,
                      children: List.generate(
                        8,
                        (index) => TileSquareProduct(
                          data: CatalogModel(
                            id: 0,
                            name: '',
                            cover: '',
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            // SizedBox(
            //   height: 120,
            // ),
            Padding(
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
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
      // bottomNavigationBar: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      //     child: HubungiKamiButton(
      //       onHubungiKamiButtonTap: () async {
      //         String whatsAppUrl =
      //             'https://wa.me/6281908192559?text=Hallo+Geomatika+Satelit+Indonesia';
      //         if (await canLaunchUrl(Uri.parse(whatsAppUrl))) {
      //           await launchUrl(Uri.parse(whatsAppUrl));
      //         } else {
      //           throw 'Could not launch $whatsAppUrl';
      //         }
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
