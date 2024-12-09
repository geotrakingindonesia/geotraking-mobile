// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/models/notification.dart';
import 'package:geotraking/core/services/notification_service.dart';

class CreateNotificationPage extends StatefulWidget {
  @override
  _CreateNotificationPageState createState() => _CreateNotificationPageState();
}

class _CreateNotificationPageState extends State<CreateNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final NotificationService notificationService = NotificationService();
  String? _judul;
  String? _teks;

  Future<void> _sendNotification() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      NotificationModel notification = NotificationModel(
        judul: _judul!,
        teksNotification: _teks!,
      );

      try {
        await notificationService.saveNotification(notification);
        await notificationService.sendNotification(notification);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Notifikasi berhasil dikirim!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal mengirim notifikasi")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text('Buat Notifikasi'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Form(
      //     key: _formKey,
      //     child: Column(
      //       children: [
      //         TextFormField(
      //           decoration: InputDecoration(labelText: "Judul"),
      //           validator: (value) {
      //             if (value == null || value.isEmpty) {
      //               return "Judul tidak boleh kosong";
      //             }
      //             return null;
      //           },
      //           onSaved: (value) {
      //             _judul = value;
      //           },
      //         ),
      //         TextFormField(
      //           decoration: InputDecoration(labelText: "Teks Notifikasi"),
      //           validator: (value) {
      //             if (value == null || value.isEmpty) {
      //               return "Teks tidak boleh kosong";
      //             }
      //             return null;
      //           },
      //           onSaved: (value) {
      //             _teks = value;
      //           },
      //         ),
      //         SizedBox(height: 20),
      //         ElevatedButton(
      //           onPressed: _sendNotification,
      //           child: Text("Kirim Notifikasi"),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 5.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Judul",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Judul tidak boleh kosong";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _judul = value;
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 5.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Teks Notifikasi",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Teks tidak boleh kosong";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _teks = value;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: _sendNotification,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Kirim Notif',
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
