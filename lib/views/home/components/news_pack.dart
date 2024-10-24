// ignore_for_file: prefer_interpolation_to_compose_strings, depend_on_referenced_packages, unnecessary_string_interpolations, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/localization_language.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
// import 'package:geotraking/core/models/news.dart';
import 'package:geotraking/core/routes/app_routes.dart';
// import 'package:geotraking/core/services/news_service.dart';
import 'package:geotraking/views/home/components/news_detail_page.dart';
import 'package:intl/intl.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// class NewsPacks extends StatelessWidget {
//   NewsPacks({
//     Key? key,
//   }) : super(key: key);

//   final NewsService newsService = NewsService();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 5),
//         TitleAndActionButton(
//           title: 'Our Galleries',
//           onTap: () => Navigator.pushNamed(context, AppRoutes.home),
//         ),
//         const SizedBox(height: 5),
//         FutureBuilder<List<News>>(
//           future: newsService.fetchAllNews(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: snapshot.data!
//                       .map((news) => Padding(
//                             padding: const EdgeInsets.only(right: 5),
//                             child: NewsPackCard(
//                               title: news.title,
//                               image: news.image,
//                               pubdate: news.pubdate,
//                               link: news.link,
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Text('${snapshot.error}');
//             }
//             return Opacity(
//               opacity:
//                   snapshot.connectionState == ConnectionState.waiting ? 1 : 0,
//               child: Container(
//                 width: 20,
//                 height: 20,
//                 color: Colors.white,
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

class NewsPacks extends StatefulWidget {
  final String selectedLanguage;
  NewsPacks({
    Key? key, required this.selectedLanguage,
  }) : super(key: key);

  @override
  _NewsPacksState createState() => _NewsPacksState();
}

class _NewsPacksState extends State<NewsPacks> {
  // String _selectedLanguage = 'English';

  // @override
  // void initState() {
  //   super.initState();
  //   _loadLanguageFromSharedPreferences();
  // }

  // _loadLanguageFromSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final language = prefs.getString('language');
  //   if (language != null) {
  //     setState(() {
  //       _selectedLanguage = language;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        // TitleAndActionButton(
        //   title: Localization.getGallery(widget.selectedLanguage),
        //   onTap: () => Navigator.pushNamed(context, AppRoutes.home),
        // ),
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
    if (title.length > 20) {
      return title.substring(0, 20) + "...";
    } else {
      return title;
    }
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
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: 280,
                  height: 110,
                ),
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
