// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/constants.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
    required this.onPostDataRegist,
  }) : super(key: key);

  final void Function() onPostDataRegist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding * 2),
      child: Row(
        children: [
          Text(
            'Sign Up',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: onPostDataRegist,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              elevation: 1
            ),
            child: SvgPicture.asset(
              AppIcons.arrowForward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
