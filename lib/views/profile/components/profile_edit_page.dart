// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/constants.dart';
import 'package:geotraking/core/models/member.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/views/entrypoint/entrypoint_ui.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';

class ProfileMemberEditPage extends StatefulWidget {
  const ProfileMemberEditPage({Key? key}) : super(key: key);

  @override
  ProfileMemberEditPageState createState() => ProfileMemberEditPageState();
}

class ProfileMemberEditPageState extends State<ProfileMemberEditPage> {
  final _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _noHpController;

  String _nameUser = '';
  String _emailUser = '';
  String _noHpUser = '';
  // File _avatar;

  MemberUser? _user;
  bool _isLoggedIn = false;
  File? _avatar;

  Directory? _directory;

  _getDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    setState(() {
      _directory = directory;
    });
  }

  // String? _avatar;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn().then((_) {
      if (_user != null) {
        _nameController = TextEditingController(text: _user!.name);
        _emailController = TextEditingController(text: _user!.email);
        _noHpController = TextEditingController(text: _user!.noHp);
      }
    });
    _getDirectory();
  }

  _checkLoggedIn() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      setState(() {
        _isLoggedIn = true;
        _user = user;
      });
    }
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      setState(() {
        _avatar = File(pickedFile.path);
        // _avatar = pickedFile.path;
      });
    } else {
      _avatar = null;
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      setState(() {
        // _avatar = pickedFile.path;
        _avatar = File(pickedFile.path);
      });
    } else {
      _avatar = null;
    }
  }

  // onUpdateProfile(File? _avatar) async {
  Future<void> onUpdateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      try {
        await _authService.updateProfile(
            _nameUser, _emailUser, _noHpUser, _avatar);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EntryPointUI()),
        );
      } catch (e) {
        // Show error message
        print('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: const AppBackButton(),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
      ),
      body: _isLoggedIn == false
          ? Center(
              child: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 5)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return const Text('Failed to load user');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          _user!.avatar != null
                              ? _avatar != null
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(_avatar!),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(
                                        File(
                                            '${_directory?.path}/avatar_${_user!.id}.jpg'),
                                      ),
                                      // backgroundImage: NetworkImage(
                                      //   'https://office.geosat.co.id/public/public/avatars/${_user!.avatar}',
                                      // ),
                                    )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage('assets/images/user.png'),
                                ),
                          // _avatar != null
                          //     ? CircleAvatar(
                          //         radius: 50,
                          //         backgroundImage: FileImage(_avatar!),
                          //       )
                          //     : CircleAvatar(
                          //         radius: 50,
                          //         backgroundImage:
                          //             AssetImage('assets/images/user.png'),
                          //       ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.camera),
                                          title: Text('Camera'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _getImageFromCamera();
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.image),
                                          title: Text('Gallery'),
                                          onTap: () {
                                            Navigator.pop(context);
                                            _getImageFromGallery();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  color: Colors.blue,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDefaults.padding),
                    // name
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      onSaved: (value) => _nameUser = value!,
                      decoration: InputDecoration(
                        labelText: _user!.name,
                        prefixIcon:
                            const Icon(Icons.person_3, color: Colors.black),
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
                    // email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      onSaved: (value) => _emailUser = value!,
                      decoration: InputDecoration(
                        labelText: _user!.email,
                        prefixIcon:
                            const Icon(Icons.email, color: Colors.black),
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
                    // password
                    TextFormField(
                      controller: _noHpController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        PhoneNumberInputFormatter(),
                      ],
                      style: const TextStyle(color: Colors.black),
                      onSaved: (value) => _noHpUser = value!,
                      decoration: InputDecoration(
                        labelText: _user!.noHp,
                        prefixIcon:
                            const Icon(Icons.phone, color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppDefaults.padding),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // onUpdateProfile(_avatar);
                                  onUpdateProfile();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Update Profile',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
