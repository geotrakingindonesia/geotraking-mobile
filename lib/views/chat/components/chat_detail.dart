// // ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unused_element, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_field, no_leading_underscores_for_local_identifiers, use_super_parameters

// import 'package:chat_bubbles/chat_bubbles.dart';
// import 'package:flutter/material.dart';
// import 'package:geotraking/core/components/app_back_button.dart';
// import 'package:geotraking/core/services/chat_service.dart';

// class ChatDetail extends StatefulWidget {
//   final String vesselName;
//   final String mobileId;
//   final int senderId;
//   const ChatDetail({
//     Key? key,
//     required this.vesselName,
//     required this.mobileId,
//     required this.senderId,
//   }) : super(key: key);

//   @override
//   State<ChatDetail> createState() => _ChatDetailState();
// }

// class _ChatDetailState extends State<ChatDetail> {
//   final ChatService _chatService = ChatService();
//   final List<Map<String, dynamic>> _messages = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 2, 21, 38),
//       appBar: AppBar(
//         leading: const AppBackButton(),
//         title: Text('Chat ${widget.vesselName}'),
//         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//               color: Colors.black,
//             ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Text(
//                           'ini ${widget.senderId}',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         BubbleSpecialThree(
//                           text: 'Please try and give some feedback on it!',
//                           color: Color(0xFF1B97F3),
//                           tail: true,
//                           textStyle:
//                               TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                         BubbleSpecialThree(
//                           text: 'Please try and give some feedback on it!',
//                           color: Color(0xFFE8E8EE),
//                           tail: true,
//                           isSender: false,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           MessageBar(
//             onSend: (_) => print(_),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/services/chat_service.dart';

class ChatDetail extends StatefulWidget {
  final String vesselName;
  final String mobileId;
  final int senderId;

  const ChatDetail({
    Key? key,
    required this.vesselName,
    required this.mobileId,
    required this.senderId,
  }) : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  final ChatService _chatService = ChatService();
  final List<Map<String, dynamic>> _messages = [];

  String stringToHex(String input) {
    return input.codeUnits
        .map((unit) => unit.toRadixString(16).padLeft(2, '0'))
        .join();
  }

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final List<Map<String, dynamic>> fetchedMessages =
          await _chatService.show();

      setState(() {
        _messages.clear();
        for (var msg in fetchedMessages) {
          _messages.add({
            'isSender': msg['sender_id'] == widget.senderId,
            'text': msg['teks'],
          });
        }
      });
    } catch (e) {
      print("Error loading messages: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat pesan')),
      );
    }
  }

  Future<void> _sendMessage(String message) async {
    try {
      // Buat data yang akan dikirim ke fungsi store
      String hexData = stringToHex(message);

      // Panggil fungsi store
      bool isSuccess = await _chatService.store(
        hexData: hexData,
        senderId: widget.senderId,
        mobileId: widget.mobileId,
      );

      print('Hex data to be sent: $hexData');

      if (isSuccess) {
        // Jika berhasil, tambahkan pesan ke dalam daftar pesan dan perbarui UI
        setState(() {
          _messages.add({
            'isSender': true,
            'text': message,
          });
        });
      } else {
        // Tampilkan pesan error jika store gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengirim pesan')),
        );
      }
    } catch (e) {
      print("Error sending message: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat mengirim pesan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 21, 38),
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text('Chat ${widget.vesselName}'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: _messages.map((msg) {
                        return BubbleSpecialThree(
                          text: msg['text'],
                          color: msg['isSender']
                              ? const Color(0xFF1B97F3)
                              : const Color(0xFFE8E8EE),
                          tail: true,
                          isSender: msg['isSender'],
                          textStyle: TextStyle(
                            color:
                                msg['isSender'] ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          MessageBar(
            onSend: (message) {
              if (message.trim().isNotEmpty) {
                _sendMessage(message.trim());
              }
            },
          ),
        ],
      ),
    );
  }
}
