// // // // import 'package:flutter/material.dart';

// // // // // AIzaSyC71gwpGxqmgPd7AhnqRrXwaox35SP9iTc

// // // // class AIChatPage extends StatefulWidget {
// // // //   @override
// // // //   _AIChatPageState createState() => _AIChatPageState();
// // // // }

// // // // class _AIChatPageState extends State<AIChatPage> {
// // // //   final TextEditingController _controller = TextEditingController();
// // // //   final List<Map<String, String>> _messages = [];

// // // //   // Simulate AI response based on user input
// // // //   String _generateAIResponse(String input) {
// // // //     if (input.toLowerCase().contains("hello")) {
// // // //       return "Hello! How can I help you today?";
// // // //     } else if (input.toLowerCase().contains("how are you")) {
// // // //       return "I'm here to assist you! What do you need help with?";
// // // //     } else {
// // // //       return "I'm sorry, I didn't understand that. Could you rephrase?";
// // // //     }
// // // //   }

// // // //   void _sendMessage() {
// // // //     final userMessage = _controller.text;
// // // //     if (userMessage.isNotEmpty) {
// // // //       setState(() {
// // // //         _messages.add({"sender": "user", "message": userMessage});
// // // //         _controller.clear();
// // // //       });

// // // //       // Add AI response after a delay
// // // //       Future.delayed(Duration(milliseconds: 500), () {
// // // //         final aiMessage = _generateAIResponse(userMessage);
// // // //         setState(() {
// // // //           _messages.add({"sender": "ai", "message": aiMessage});
// // // //         });
// // // //       });
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text("AI Chat"),
// // // //       ),
// // // //       body: Column(
// // // //         children: [
// // // //           Expanded(
// // // //             child: ListView.builder(
// // // //               padding: EdgeInsets.all(10),
// // // //               itemCount: _messages.length,
// // // //               itemBuilder: (context, index) {
// // // //                 final message = _messages[index];
// // // //                 final isUserMessage = message["sender"] == "user";
// // // //                 return Align(
// // // //                   alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
// // // //                   child: Container(
// // // //                     margin: EdgeInsets.symmetric(vertical: 5),
// // // //                     padding: EdgeInsets.all(10),
// // // //                     decoration: BoxDecoration(
// // // //                       color: isUserMessage ? Colors.blueAccent : Colors.grey[300],
// // // //                       borderRadius: BorderRadius.circular(10),
// // // //                     ),
// // // //                     child: Text(
// // // //                       message["message"]!,
// // // //                       style: TextStyle(color: isUserMessage ? Colors.white : Colors.black87),
// // // //                     ),
// // // //                   ),
// // // //                 );
// // // //               },
// // // //             ),
// // // //           ),
// // // //           Padding(
// // // //             padding: const EdgeInsets.all(10.0),
// // // //             child: Row(
// // // //               children: [
// // // //                 Expanded(
// // // //                   child: TextField(
// // // //                     controller: _controller,
// // // //                     decoration: InputDecoration(
// // // //                       hintText: "Type your message...",
// // // //                       border: OutlineInputBorder(
// // // //                         borderRadius: BorderRadius.circular(20),
// // // //                       ),
// // // //                       contentPadding: EdgeInsets.symmetric(horizontal: 15),
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //                 IconButton(
// // // //                   icon: Icon(Icons.send, color: Colors.blueAccent),
// // // //                   onPressed: _sendMessage,
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;

// // // class AIChatPage extends StatefulWidget {
// // //   @override
// // //   _AIChatPageState createState() => _AIChatPageState();
// // // }

// // // class _AIChatPageState extends State<AIChatPage> {
// // //   final TextEditingController _controller = TextEditingController();
// // //   final List<Map<String, String>> _messages = [];

// // //   final String _apiKey = 'AIzaSyC71gwpGxqmgPd7AhnqRrXwaox35SP9iTc';  // Replace with your API key
// // //   final String _apiUrl = 'https://aistudio.google.com/apikey';  // Replace with the correct API endpoint if different

// // //   Future<void> _getAIResponse(String userMessage) async {
// // //     try {
// // //       final response = await http.post(
// // //         Uri.parse(_apiUrl),
// // //         headers: {
// // //           'Content-Type': 'application/json',
// // //           'Authorization': 'Bearer $_apiKey',
// // //         },
// // //         body: jsonEncode({
// // //           'input': userMessage,
// // //         }),
// // //       );

// // //       if (response.statusCode == 200) {
// // //         final data = jsonDecode(response.body);
// // //         final aiMessage = data['output'] ?? "Sorry, I didn't understand that.";

// // //         setState(() {
// // //           _messages.add({"sender": "ai", "message": aiMessage});
// // //         });
// // //       } else {
// // //         throw Exception("Failed to get AI response");
// // //       }
// // //     } catch (e) {
// // //       setState(() {
// // //         _messages.add({"sender": "ai", "message": "Error: Unable to connect to AI service."});
// // //       });
// // //     }
// // //   }

// // //   void _sendMessage() {
// // //     final userMessage = _controller.text;
// // //     if (userMessage.isNotEmpty) {
// // //       setState(() {
// // //         _messages.add({"sender": "user", "message": userMessage});
// // //         _controller.clear();
// // //       });

// // //       // Call the API for AI response
// // //       _getAIResponse(userMessage);
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text("test AI chat"),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           Expanded(
// // //             child: ListView.builder(
// // //               padding: EdgeInsets.all(10),
// // //               itemCount: _messages.length,
// // //               itemBuilder: (context, index) {
// // //                 final message = _messages[index];
// // //                 final isUserMessage = message["sender"] == "user";
// // //                 return Align(
// // //                   alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
// // //                   child: Container(
// // //                     margin: EdgeInsets.symmetric(vertical: 5),
// // //                     padding: EdgeInsets.all(10),
// // //                     decoration: BoxDecoration(
// // //                       color: isUserMessage ? Colors.blueAccent : Colors.grey[300],
// // //                       borderRadius: BorderRadius.circular(10),
// // //                     ),
// // //                     child: Text(
// // //                       message["message"]!,
// // //                       style: TextStyle(color: isUserMessage ? Colors.white : Colors.black87),
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(10.0),
// // //             child: Row(
// // //               children: [
// // //                 Expanded(
// // //                   child: TextField(
// // //                     controller: _controller,
// // //                     decoration: InputDecoration(
// // //                       hintText: "Type your message...",
// // //                       border: OutlineInputBorder(
// // //                         borderRadius: BorderRadius.circular(20),
// // //                       ),
// // //                       contentPadding: EdgeInsets.symmetric(horizontal: 15),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 IconButton(
// // //                   icon: Icon(Icons.send, color: Colors.blueAccent),
// // //                   onPressed: _sendMessage,
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // class AIChatPage extends StatefulWidget {
// //   @override
// //   _AIChatPageState createState() => _AIChatPageState();
// // }

// // class _AIChatPageState extends State<AIChatPage> {
// //   final TextEditingController _controller = TextEditingController();
// //   final List<Map<String, String>> _messages = [];

// //   // Replace this with your actual Gemini API key
// //   final String _apiKey = 'AIzaSyC71gwpGxqmgPd7AhnqRrXwaox35SP9iTc';

// //   Future<void> _sendMessage(String userMessage) async {
// //     if (_apiKey.isEmpty) {
// //       print('API Key is missing.');
// //       return;
// //     }

// //     final response = await http.post(
// //       Uri.parse('https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage'),
// //       headers: {
// //         'Authorization': 'Bearer $_apiKey',
// //         'Content-Type': 'application/json',
// //       },
// //       body: jsonEncode({
// //         'prompt': userMessage,
// //         'temperature': 0.7,
// //         'max_output_tokens': 1024,
// //       }),
// //     );

// //     if (response.statusCode == 200) {
// //       final data = jsonDecode(response.body);
// //       final aiMessage = data['candidates'][0]['message']['content'] ?? "Sorry, I couldn't process your request.";
// //       setState(() {
// //         _messages.add({"sender": "ai", "message": aiMessage});
// //       });
// //     } else {
// //       print('Error: ${response.statusCode}');
// //       setState(() {
// //         _messages.add({"sender": "ai", "message": "Error occurred. Try again!"});
// //       });
// //     }
// //   }

// //   void _sendMessageHandler() {
// //     final userMessage = _controller.text.trim();
// //     if (userMessage.isNotEmpty) {
// //       setState(() {
// //         _messages.add({"sender": "user", "message": userMessage});
// //         _controller.clear();
// //       });
// //       _sendMessage(userMessage);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("AI Chatbot"),
// //       ),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: _messages.length,
// //               itemBuilder: (context, index) {
// //                 final message = _messages[index];
// //                 final isUserMessage = message['sender'] == 'user';
// //                 return Align(
// //                   alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
// //                   child: Container(
// //                     margin: EdgeInsets.symmetric(vertical: 5),
// //                     padding: EdgeInsets.all(10),
// //                     decoration: BoxDecoration(
// //                       color: isUserMessage ? Colors.blueAccent : Colors.grey[300],
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: Text(
// //                       message['message']!,
// //                       style: TextStyle(
// //                         color: isUserMessage ? Colors.white : Colors.black87,
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(10.0),
// //             child: Row(
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     controller: _controller,
// //                     decoration: InputDecoration(
// //                       hintText: 'Type a message...',
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(20),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.send, color: Colors.blueAccent),
// //                   onPressed: _sendMessageHandler,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AIChatPage extends StatefulWidget {
//   @override
//   _AIChatPageState createState() => _AIChatPageState();
// }

// class _AIChatPageState extends State<AIChatPage> {
//   final String _apiKey = 'AIzaSyC71gwpGxqmgPd7AhnqRrXwaox35SP9iTc';  // Replace with your actual API Key

//   // Function to send request to Gemini API
//   Future<void> _generateContent() async {
//     // Create the request payload (only text, no image)
//     final requestPayload = jsonEncode({
//       "contents": [
//         {
//           "parts": [
//             {"text": "Tell me about this instrument"}
//           ]
//         }
//       ]
//     });

//     // Send the POST request
//     final response = await http.post(
//       Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey'),
//       headers: {'Content-Type': 'application/json'},
//       body: requestPayload,
//     );

//     if (response.statusCode == 200) {
//       print('Success: ${response.body}');
//       // Handle successful response here (e.g., display content)
//     } else {
//       print('Error: ${response.statusCode}');
//       print('Response: ${response.body}');
//       // Handle error response here
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('AI Chat')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _generateContent,
//           child: Text('Send Request'),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// class AIChatPage extends StatefulWidget {
//   @override
//   _AIChatPageState createState() => _AIChatPageState();
// }

// class _AIChatPageState extends State<AIChatPage> {
//   TextEditingController _userInput = TextEditingController();
//   final apiKey = 'AIzaSyC71gwpGxqmgPd7AhnqRrXwaox35SP9iTc';

//   @override
//   void initState() {
//     super.initState();
//     talkWithGemini();
//   }

//   Future<void> talkWithGemini() async {
//     final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

//     final msg = 'Hello';

//     final content = Content.text(msg);

//     final response = await model.generateContent([content]);

//     print('response from ai: ${response.text}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('test'),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIChatPage extends StatefulWidget {
  @override
  _AIChatPageState createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  TextEditingController _userInput = TextEditingController();
  final apiKey = 'AIzaSyC71gwpGxqmgPd7AhnqRrXwaox35SP9iTc'; // Replace with your actual API key

  List<Map<String, String>> _messages = []; // List to store chat messages

  @override
  void initState() {
    super.initState();
  }

  // Function to send user input to Gemini and get the response
  Future<void> talkWithGemini(String message) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

    final content = Content.text(message);

    final response = await model.generateContent([content]);

    // After receiving the response, update the messages list
    setState(() {
      _messages.add({'sender': 'user', 'message': message});
      _messages.add({'sender': 'gemini', 'message': response.text!});
    });
  }

  // Function to handle message sending
  void _sendMessage() {
    if (_userInput.text.isNotEmpty) {
      talkWithGemini(_userInput.text);
      _userInput.clear(); // Clear input field after sending message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var message = _messages[index];
                bool isUserMessage = message['sender'] == 'user';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message['message']!,
                        style: TextStyle(
                          color: isUserMessage ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _userInput,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
