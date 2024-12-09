import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class SupportTile extends StatelessWidget {
  final String title;
  final String contact;
  final String imageUrl;

  const SupportTile({
    Key? key,
    required this.title,
    required this.contact,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDefaults.padding,
        vertical: AppDefaults.padding / 2,
      ),
      child: ClipRRect(
        borderRadius: AppDefaults.borderRadius,
        child: Stack(
          children: [
            Image.asset(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              height: 120,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: AppDefaults.borderRadius,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        contact,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
