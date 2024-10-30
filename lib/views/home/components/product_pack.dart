// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geotraking/core/models/catalog_model.dart';
import 'package:geotraking/core/models/product.dart';
import 'package:geotraking/views/catalogue/components/product_detail_page.dart';
import 'package:geotraking/views/catalogue/components/tile_square.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ProductPacks extends StatefulWidget {
  final String selectedLanguage;
  const ProductPacks({Key? key, required this.selectedLanguage}) : super(key: key);

  @override
  _ProductPacksState createState() => _ProductPacksState();
}

class _ProductPacksState extends State<ProductPacks> {
  late Future<List<Product>> futureProducts;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    futureProducts = _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final jsonString =
        await rootBundle.loadString('assets/jsons/catalogue.json');
    final jsonData = jsonDecode(jsonString) as List<dynamic>;
    final products =
        jsonData.map((jsonProduct) => Product.fromJson(jsonProduct)).toList();
    products.shuffle(random);
    return products.take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        FutureBuilder<List<Product>>(
          future: futureProducts,
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
                    4,
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
        const SizedBox(height: 5),
      ],
    );
  }
}
