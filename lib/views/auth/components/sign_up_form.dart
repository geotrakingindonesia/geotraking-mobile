// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, prefer_const_constructors, unnecessary_brace_in_string_interps, unused_catch_clause

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/constants/app_icons.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/core/utils/validators.dart';
import 'package:geotraking/views/auth/components/already_have_accout.dart';
import 'package:geotraking/views/auth/components/sign_up_button.dart';
import 'package:geotraking/views/auth/login_page.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isPasswordShown = false;

  void onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      try {
        await _authService.register(
          _nameController.text,
          _emailController.text,
          _phoneNumberController.text,
          _passwordController.text,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign Up Successfully, please try to login!')),
        );
      } on Exception catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Failed to register')),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        padding: const EdgeInsets.all(AppDefaults.padding),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: AppDefaults.boxShadow,
          borderRadius: AppDefaults.borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              validator: (value) => Validators.required(value),
              onSaved: (value) => _nameController.text = value!,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon:
                    const Icon(Icons.person_2_rounded, color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: AppDefaults.padding),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => Validators.required(value),
              onSaved: (value) => _emailController.text = value!,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email, color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: AppDefaults.padding),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                PhoneNumberInputFormatter(),
              ],
              validator: (value) => Validators.required(value),
              onSaved: (value) => _phoneNumberController.text = value!,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'No. Handphone',
                prefixIcon: const Icon(Icons.phone, color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: AppDefaults.padding),
            TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: !isPasswordShown,
              validator: (value) => Validators.required(value),
              onSaved: (value) => _passwordController.text = value!,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon:
                    const Icon(Icons.password_rounded, color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                suffixIcon: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: onPassShowClicked,
                    icon: SvgPicture.asset(
                      AppIcons.eye,
                      width: 24,
                    ),
                  ),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: AppDefaults.padding),
            SignUpButton(
              onPostDataRegist: _submitForm,
            ),
            const AlreadyHaveAnAccount(),
            const SizedBox(height: AppDefaults.padding),
          ],
        ),
      ),
    );
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final StringBuffer newText = StringBuffer();
    int selectionIndex = newValue.selection.baseOffset;

    for (int i = 0; i < newValue.text.length; i++) {
      if (i == 4) {
        newText.write('-');
        selectionIndex++;
      } else if (i == 8) {
        newText.write('-');
        selectionIndex++;
      }
      newText.write(newValue.text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
