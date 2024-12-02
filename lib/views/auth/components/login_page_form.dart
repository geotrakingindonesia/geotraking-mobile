// ignore_for_file: use_build_context_synchronously, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geotraking/core/constants/app_icons.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/core/themes/app_themes.dart';
import 'package:geotraking/core/utils/validators.dart';
import 'package:geotraking/views/auth/components/login_button.dart';
import 'package:geotraking/views/entrypoint/entrypoint_ui.dart';

class LoginPageForm extends StatefulWidget {
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const LoginPageForm({
    Key? key,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  }) : super(key: key);

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final _key = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _otp = '';
  bool _isOtpSent = false;
  final _authService = AuthService();

  bool isPasswordShown = false;
  String? _errorMessage;

  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  Future<void> sendOtp() async {
    try {
      bool isOtpSent = await _authService.sendOtp(_email);
      if (isOtpSent) {
        setState(() {
          _isOtpSent = true;
          _errorMessage = null;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to send OTP';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error sending OTP: $e';
      });
    }
  }

  // onLogin() async {
  //   if (_key.currentState!.validate()) {
  //     _key.currentState!.save();
  //     try {
  //       bool isValid = await _authService.validateLogin(_email, _password);
  //       if (isValid) {
  //         setState(() {
  //           _errorMessage = null;
  //         });
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => EntryPointUI()),
  //         );
  //       }
  //     } catch (e) {
  //       setState(() {
  //         _errorMessage = e.toString();
  //       });
  //     }
  //   }
  // }

  Future<void> onLogin() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      if (!_isOtpSent) {
        // If OTP hasn't been sent yet, send OTP first
        await sendOtp();
      } else {
        // Verify OTP after it's sent
        bool otpVerified = await _authService.verifyOtp(_email, _otp);
        if (otpVerified) {
          try {
            bool isValid = await _authService.validateLogin(_email, _password);
            if (isValid) {
              setState(() {
                _errorMessage = null;
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => EntryPointUI()),
              );
            }
          } catch (e) {
            setState(() {
              _errorMessage = e.toString();
            });
          }
        } else {
          setState(() {
            _errorMessage = 'Invalid OTP';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // email
              TextFormField(
                focusNode: widget.emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validator: (value) => Validators.required(value),
                onSaved: (value) => _email = value!,
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
              // password
              const SizedBox(height: 8),
              TextFormField(
                focusNode: widget.passwordFocusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                obscureText: !isPasswordShown,
                validator: (value) => Validators.required(value),
                onSaved: (value) => _password = value!,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon:
                      const Icon(Icons.password_rounded, color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              if (_isOtpSent) ...[
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: (value) => Validators.required(value),
                  onSaved: (value) => _otp = value!,
                  decoration: InputDecoration(
                    labelText: 'Enter OTP',
                    prefixIcon: const Icon(Icons.security, color: Colors.black),
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
                SizedBox(height: 5),
                if (_errorMessage != null) ...[
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                LoginButton(onPressed: onLogin),
                // ],
              ],
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     if (_errorMessage != null) ...[
              //       Text(
              //         'Gagal login.',
              //         style: const TextStyle(color: Colors.red),
              //       ),
              //     ] else ...[
              //       Spacer(),
              //     ],
              //   ],
              // ),
              // LoginButton(onPressed: onLogin),
            ],
          ),
        ),
      ),
    );
  }
}
