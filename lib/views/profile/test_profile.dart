import 'package:flutter/material.dart';

class TestProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Akun'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              // height: 0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/background_user.png'), // Path to the background image
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                        'assets/images/user.png'), // Replace with your image
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AZZAM RAFI ZAFRAN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '+6281384197696',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),

            // Referral Card
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Container(
            //     padding: EdgeInsets.all(16),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(8),
            //       boxShadow: [
            //         BoxShadow(
            //             color: Colors.grey.shade200,
            //             blurRadius: 5,
            //             spreadRadius: 1),
            //       ],
            //     ),
            //     child: Row(
            //       children: [
            //         Icon(Icons.group, size: 40, color: Colors.green),
            //         SizedBox(width: 16),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               'Share the Slp',
            //               style: TextStyle(
            //                   fontSize: 16, fontWeight: FontWeight.bold),
            //             ),
            //             SizedBox(height: 4),
            //             Text(
            //               'Bagikan kode referral, dapatkan hadiah',
            //               style: TextStyle(color: Colors.grey, fontSize: 14),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // Menu Options
            _buildMenuOption(context, 'Alamat Tersimpan'),
            _buildMenuOption(context, 'Pembayaran'),
            _buildMenuOption(context, 'Pusat Bantuan'),
            _buildMenuOption(context, 'Pengaturan'),
            _buildMenuOption(context, 'Panduan Layanan'),
            _buildMenuOption(context, 'Kebijakan Privasi'),
            _buildMenuOption(context, 'Media Sosial'),

            // Social Media Icons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialMediaIcon(
                      Icons.photo_camera, Colors.purple), // Instagram
                  _buildSocialMediaIcon(
                      Icons.facebook, Colors.blue), // Facebook
                  _buildSocialMediaIcon(
                      Icons.video_library, Colors.red), // YouTube
                  _buildSocialMediaIcon(Icons.chat, Colors.black), // Twitter/X
                ],
              ),
            ),

            // Help Section
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Icon(Icons.headset_mic, color: Colors.green, size: 30),
                  SizedBox(width: 16),
                  Text(
                    'Butuh Bantuan?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for building menu options
  Widget _buildMenuOption(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Navigate to respective screen
      },
    );
  }

  // Helper method for building social media icons
  Widget _buildSocialMediaIcon(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        icon,
        color: color,
        size: 30,
      ),
    );
  }
}
