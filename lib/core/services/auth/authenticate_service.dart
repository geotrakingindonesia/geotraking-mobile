// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:email_otp/email_otp.dart';
import 'package:geotraking/core/models/member.dart';
import 'package:geotraking/core/services/connection/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AuthService {
  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor!;
    }
    return "unknown_device";
  }

  Future<bool> sendOtp(String email) async {
    EmailOTP.config(
      appEmail: 'geotrakingindonesia@gmail.com', 
      appName: 'PT. Geomatika Satelit Indonesia',
      otpLength: 4,
      otpType: OTPType.numeric,
    );

    bool result = await EmailOTP.sendOTP(email: email);
    return result;
  }

  Future<bool> verifyOtp(String email, String otp) async {
    return await EmailOTP.verifyOTP(otp: otp);
  }

  Future<bool> validateLogin(String email, String password) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);

    final deviceId = await getDeviceId();

    var result =
        await conn.query('SELECT * FROM ai_member WHERE email = ?', [email]);

    print('Query result: $result');

    if (result.isNotEmpty) {
      var user = result.first;
      var hashedPassword = user['password'];
      String? avatar = user['avatar'];
      int isLoggedIn = user['is_loggedin'];
      String? storedDeviceId = user['device_id'];

      print('User found: $user');
      print('Hashed password: $hashedPassword');
      print('Stored device ID: $storedDeviceId');

      if (BCrypt.checkpw(password, hashedPassword)) {
        print('Password is correct');

        // if (!await validateOtp(email, otp)) {
        //   throw Exception('Invalid OTP');
        // }

        // Cek apakah akun sudah login di perangkat lain
        if (storedDeviceId != null && storedDeviceId != deviceId) {
          await logoutFromOtherDevice(storedDeviceId); 
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('id', user['id']);
        await prefs.setString('name', user['name']);
        await prefs.setString('no_hp', user['no_hp']);
        await prefs.setString('email', user['email']);
        await prefs.setString('password', hashedPassword);
        await prefs.setString('avatar', avatar ?? '');
        await prefs.setInt('is_admin', user['is_admin']);

        print('User data saved to shared preferences');

        await conn.query(
            'UPDATE ai_member SET is_loggedin = 1, device_id = ? WHERE email = ?',
            [deviceId, email]);

        return true;
      } else {
        throw Exception('Password is \nincorrect');
      }
    } else {
      throw Exception('User not \nfound');
    }
  }

  Future<MemberUser?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final memberId = prefs.getInt('id');

    if (memberId != null) {
      return MemberUser(
        id: memberId,
        name: prefs.getString('name') ?? '',
        email: prefs.getString('email') ?? '',
        noHp: prefs.getString('no_hp') ?? '',
        isAdmin: prefs.getInt('is_admin') ?? 0,
        avatar: prefs.getString('avatar'),
      );
    }

    return null;
  }

  Future<void> saveLoginHistory(int memberId, String device, String model,
      String brand, String host) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    final create_at = DateTime.now().toUtc().add(Duration(hours: 7));

    await conn.query('''
    INSERT INTO personal_history_access 
    (member_id, device, model, brand, host, create_at) 
    VALUES (?, ?, ?, ?, ?, ?)
  ''', [memberId, device, model, brand, host, create_at]);
  }

  Future<void> updateLogoutHistory(int memberId) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    final delete_at = DateTime.now().toUtc().add(Duration(hours: 7));
    await conn.query(
        'UPDATE personal_history_access SET delete_at = ? WHERE member_id = ? AND delete_at IS NULL',
        [delete_at, memberId]);
  }

  Future<void> logoutFromOtherDevice(String deviceId) async {
    // Logout perangkat lain yang terhubung dengan akun yang sama
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);

    // Update status login perangkat lain
    await conn.query(
        'UPDATE ai_member SET is_loggedin = 0 WHERE device_id = ?', [deviceId]);

    print('Logged out from other device');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('name');
    await prefs.remove('no_hp');
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('avatar');
    await prefs.remove('is_admin');
  }

  Future<bool> register(
      String name, String email, String noHp, String password) async {
    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);
    var result =
        await conn.query('SELECT * FROM ai_member WHERE email = ?', [email]);
    if (result.isNotEmpty) {
      throw Exception('Email already exists');
    }

    var hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    await conn.query(
        'INSERT INTO ai_member (name, email, no_hp, password) VALUES (?, ?, ?, ?)',
        [name, email, noHp, hashedPassword]);

    // await validateLogin(email, password, otp);

    print('User registered and logged in successfully');

    return true;
  }

  Future<bool> changePassword(
      String newPassword, String confirmPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final memberId = prefs.getInt('id');

    if (memberId == null) {
      throw Exception('User not logged in');
    }

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);

    if (newPassword != confirmPassword) {
      throw Exception('New password and confirm password do not match');
    }

    var hashedNewPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

    await conn.query('UPDATE ai_member SET password =? WHERE id =?',
        [hashedNewPassword, memberId]);

    await prefs.setString('password', hashedNewPassword);

    print('Password changed successfully');

    return true;
  }

  Future<bool> updateProfile(
      String name, String email, String noHp, File? avatar) async {
    final prefs = await SharedPreferences.getInstance();
    final memberId = prefs.getInt('id');

    if (memberId == null) {
      throw Exception('User not logged in');
    }

    var settings = Connection.getSettings();
    var conn = await MySqlConnection.connect(settings);

    await conn.query(
        'UPDATE ai_member SET name = ?, email = ?, no_hp = ? WHERE id = ?',
        [name, email, noHp, memberId]);

    if (avatar != null) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/avatar_${memberId}.jpg');
      await avatar.copy(file.path);

      await conn.query('UPDATE ai_member SET avatar = ? WHERE id = ?',
          [file.path, memberId]);

      await prefs.setString('avatar', file.path);
    } else {
      await conn.query(
          'UPDATE ai_member SET avatar = ? WHERE id = ?', [null, memberId]);

      await prefs.remove('avatar');
    }

    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('no_hp', noHp);

    print('Profile updated successfully');

    return true;
  }
}
