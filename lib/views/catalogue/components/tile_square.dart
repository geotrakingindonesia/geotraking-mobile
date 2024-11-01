// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
// import 'package:geotraking/core/components/network_image.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/models/catalog_model.dart';

// class TileSquareProduct extends StatelessWidget {
//   const TileSquareProduct({
//     Key? key,
//     required this.data,
//   }) : super(key: key);

//   final BundleModel data;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 176,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Material(
//             color: const Color.fromARGB(185, 113, 201, 206),
//             borderRadius: AppDefaults.borderRadius,
//             child: InkWell(
//               borderRadius: AppDefaults.borderRadius,
//               child: Center(
//                 child: AspectRatio(
//                   aspectRatio: 1.02,
//                   child: Container(
//                     padding: const EdgeInsets.all(AppDefaults.padding),
//                     // child: NetworkImageWithLoader(
//                     //   data.cover,
//                     //   fit: BoxFit.cover,
//                     // ),
//                     child: Image.asset(
//                       data.cover,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             data.name,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyLarge
//                 ?.copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }

class TileSquareProduct extends StatelessWidget {
  const TileSquareProduct({
    Key? key,
    required this.data,
  }) : super(key: key);

  final CatalogModel data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 176,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: AppDefaults.borderRadius,
            child: InkWell(
              borderRadius: AppDefaults.borderRadius,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1.02,
                  child: Container(
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    decoration: BoxDecoration(
                      borderRadius: AppDefaults.borderRadius,
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 196, 218, 210),
                          Color.fromARGB(255, 113, 201, 206),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    // child: Image.asset(
                    //   data.cover,
                    //   fit: BoxFit.cover,
                    // ),
                    child: Image.network(
                      data.cover,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.error)),
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: progress.expectedTotalBytes != null
                                ? progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.name,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
