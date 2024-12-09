// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geotraking/views/auth/components/sign_up_form.dart';
import 'package:geotraking/views/auth/components/sign_up_page_header.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topRight, colors: [
              Color.fromARGB(255, 227, 253, 253),
              Color.fromARGB(255, 166, 227, 233)
            ]),
          ),
          child: Center(
            child: SizedBox(
              width: width,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // FadeInDown(
                      //   duration: Duration(milliseconds: 1300),
                      //   child: const SignUpPageHeader(),
                      // ),
                      const SignUpPageHeader(),
                      // FadeInUp(
                      //   duration: Duration(milliseconds: 1300),
                      //   child: const SignUpForm(),
                      // ),
                      const SignUpForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
