// ignore_for_file: prefer_interpolation_to_compose_strings, depend_on_referenced_packages, unnecessary_string_interpolations, prefer_const_constructors, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/views/home/components/news_detail_page.dart';
import 'package:intl/intl.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class NewsPacks extends StatefulWidget {
  final String selectedLanguage;
  NewsPacks({
    Key? key,
    required this.selectedLanguage,
  }) : super(key: key);

  @override
  _NewsPacksState createState() => _NewsPacksState();
}

class _NewsPacksState extends State<NewsPacks> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        FutureBuilder<List<dynamic>>(
          future: _loadGalleryData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.data!
                      .map((news) => Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: NewsPackCard(
                              title: news["title"],
                              image: news["image"],
                              pubdate: DateTime.parse(news["pubdate"]),
                              link: news["link"],
                            ),
                          ))
                      .toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Opacity(
              opacity:
                  snapshot.connectionState == ConnectionState.waiting ? 1 : 0,
              child: Container(
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            );
          },
        ),
      ],
    );
  }

  Future<List<dynamic>> _loadGalleryData() async {
    final jsonString = await rootBundle.loadString('assets/jsons/gallery.json');
    final jsonData = jsonDecode(jsonString);
    return jsonData;
  }
}

class NewsPackCard extends StatelessWidget {
  const NewsPackCard({
    Key? key,
    required this.title,
    required this.image,
    required this.pubdate,
    required this.link,
  }) : super(key: key);

  final String title, image, link;
  final DateTime pubdate;

  String get formattedPubdate {
    return DateFormat('MMMM d, y').format(pubdate);
  }

  String get shortTitle {
    return title.length > 20 ? '${title.substring(0, 20)}...' : title;
  }

  String get directImageUrl {
    final driveFileId = image.split('/d/')[1].split('/')[0];
    return 'https://drive.google.com/uc?export=view&id=$driveFileId';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppDefaults.padding),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailPage(link: link),
            ),
          );
        },
        child: SizedBox(
          width: 280,
          height: 110,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: directImageUrl,
                  fit: BoxFit.cover,
                  width: 280,
                  height: 110,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error),
                  ),
                ),
                // Image.network(
                //   directImageUrl,
                //   fit: BoxFit.cover,
                //   width: 280,
                //   height: 110,
                //   errorBuilder: (context, error, stackTrace) =>
                //       const Center(child: Icon(Icons.error)),
                //   loadingBuilder: (context, child, progress) {
                //     if (progress == null) return child;
                //     return Center(
                //       child: CircularProgressIndicator(
                //         value: progress.expectedTotalBytes != null
                //             ? progress.cumulativeBytesLoaded /
                //                 progress.expectedTotalBytes!
                //             : null,
                //       ),
                //     );
                //   },
                // ),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white70),
                      children: [
                        TextSpan(
                          text: "$shortTitle\n",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        TextSpan(text: formattedPubdate)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
