import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Container(
            height: 125,
            width: 125,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ic_launcher.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Welcome back!',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Sign in to your existant account',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black38,
              ),
        )
      ],
    );
  }
}
