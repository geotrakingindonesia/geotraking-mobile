// import 'package:flutter/material.dart';
// import 'package:geotraking/core/services/vessel/vessel_service.dart';
// import 'package:geotraking/views/chat/components/tab_detail.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({Key? key}) : super(key: key);

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final VesselService vesselService = VesselService();
//   List<Map<String, dynamic>>? _vesselList;

//   @override
//   void initState() {
//     super.initState();
//     _fetchVessel();
//   }

//   Future _fetchVessel() async {
//     try {
//       final vesselList = await vesselService.getDataKapal();
//       print(vesselList);
//       setState(() {
//         _vesselList = vesselList;
//       });
//     } catch (e) {
//       setState(() {
//         print('Error fetching kapal: $e');
//       });
//     }
//   }

//   void _showBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         return FractionallySizedBox(
//           heightFactor: 0.5,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Ajukan Kapal',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 16),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: dataVessel.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return CheckboxListTile(
//                         title: Text(dataVessel[index]),
//                         value: selecteddataVessel[dataVessel[index]] ?? false,
//                         onChanged: (bool? value) {
//                           setState(() {
//                             selecteddataVessel[dataVessel[index]] =
//                                 value ?? false;
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Kapal yang dipilih:',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   _getSelecteddataVessel(),
//                   style: TextStyle(fontSize: 16, color: Colors.blueAccent),
//                 ),
//                 SizedBox(height: 24),
//                 Center(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 50, vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text('Ajukan', style: TextStyle(fontSize: 16)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50.0),
//         child: ClipRRect(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20.0),
//             bottomRight: Radius.circular(20.0),
//           ),
//           child: AppBar(
//             title: RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: 'Geo',
//                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   TextSpan(
//                     text: 'Chat',
//                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                           color: Color.fromARGB(255, 13, 124, 102),
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//             automaticallyImplyLeading: false,
//             backgroundColor: Colors.white,
//             elevation: 0,
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 15),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 127, 183, 126),
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.add, color: Colors.white),
//                     onPressed: () {
//                       _showBottomSheet(context);
//                     },
//                     tooltip: 'Ajukan chat kapal',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 5),
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.all(6),
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 243, 182, 100),
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TabDetail(),
//                     ),
//                   );
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Demo Kapal-1',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'Monday, 30 Sep 2024 (11:29 AM)',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       '1',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(6),
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: InkWell(
//                 onTap: () {},
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Nama kapal',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'wktu msg terakhir',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       'jumlah chat',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/models/member.dart';
import 'package:geotraking/core/services/auth/authenticate_service.dart';
import 'package:geotraking/core/services/chat_service.dart';
import 'package:geotraking/views/chat/components/ai_chat.dart';
// import 'package:geotraking/core/services/vessel/vessel_service.dart';
// import 'package:geotraking/views/chat/components/request_vessel.dart';
import 'package:geotraking/views/chat/components/chat_detail.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final AuthService _authService = AuthService();
  MemberUser? _user;
  bool _isLoggedIn = false;

  final ChatService chatService = ChatService();

  List<Map<String, dynamic>>? _vesselList;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
    _fetchVessel();
  }

  _checkLoggedIn() async {
    final user = await _authService.getCurrentUser();

    if (user != null) {
      print(
          'Current User: ${user.id}, ${user.name}, ${user.email}, ${user.noHp}, ${user.isAdmin}, ${user.avatar}');
      setState(() {
        _user = user;
        if (_user!.isAdmin == 1) {
          _isLoggedIn = true;
        }
      });
    }
  }

  Future _fetchVessel() async {
    try {
      final vesselList = await chatService.index();
      print(vesselList);
      setState(() {
        _vesselList = vesselList;
      });
    } catch (e) {
      print('Error fetching kapal: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          child: AppBar(
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Geo',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextSpan(
                    text: 'Chat',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Color.fromARGB(255, 13, 124, 102),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 5),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(6),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 127, 183, 126),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ChatDetail(
                  //       vesselName: '',
                  //       // senderId: _user!.isAdmin,
                  //       senderId: _user!.id,
                  //       mobileId: '',
                  //     ),
                  //   ),
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daftarkan Kapal Anda',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Monday, 30 Sep 2024 (11:29 AM)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '1',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoggedIn)
              _vesselList != null
                  ? ListView.builder(
                      itemCount: _vesselList!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(6),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 243, 182, 100),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatDetail(
                                    vesselName:
                                        '${_vesselList![index]['nama_kapal']}',
                                    // senderId: _user!.isAdmin,
                                    senderId: _user!.id,
                                    mobileId: '${_vesselList![index]['id']}',
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_vesselList![index]['nama_kapal']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Monday, 30 Sep 2024 (11:29 AM)',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 3)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container();
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Getting Data',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: Colors.black),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 76.0),
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => AIChatPage()),
      //       );
      //     },
      //     backgroundColor: Colors.green,
      //     child: Icon(
      //       FontAwesomeIcons.message,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:dropdown_search/dropdown_search.dart';

// class ChatPage extends StatefulWidget {
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   List<String> selectedVessels = [];

//   final List<String> vessels = [
//     "Vessel A",
//     "Vessel B",
//     "Vessel C",
//     "Vessel D",
//     "Vessel E",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             DropdownSearch<String>(
//               items: (f, cs) => ["Item 1", 'Item 2', 'Item 3', 'Item 4'],
//               popupProps: PopupProps.menu(
//                   disabledItemFn: (item) => item == 'Item 3',
//                   fit: FlexFit.loose),
//             ),
//             SizedBox(height: 20),
//             DropdownSearch<String>.multiSelection(
//               mode: Mode.custom,
//               items: (f, cs) => [
//                 "Monday",
//                 'Tuesday',
//                 'Wednesday',
//                 'Thursday',
//                 'Friday',
//                 'Saturday',
//                 'Sunday'
//               ],
//               dropdownBuilder: (ctx, selectedItem) =>
//                   Icon(Icons.calendar_month_outlined, size: 54),
//             ),
//             DropdownSearch<String>.multiSelection(
//               items: (filter, s) => [
//                 "Mondaymonday",
//                 "Monday",
//                 'Tuesday',
//                 'Wednesday',
//                 'Thursday',
//                 'Friday',
//                 'Saturday',
//                 'Sunday'
//               ],
//               // compareFn: (i, s) => i.isEqual(s),
//               popupProps: PopupPropsMultiSelection.bottomSheet(
//                 bottomSheetProps:
//                     BottomSheetProps(backgroundColor: Colors.blueGrey[50]),
//                 showSearchBox: true,
//                 // itemBuilder: userModelPopupItem,
//                 // suggestedItemProps: SuggestedItemProps(
//                 //   showSuggestedItems: true,
//                 //   suggestedItems: (us) {
//                 //     return us.where((e) => e.name.contains("Mrs")).toList();
//                 //   },
//                 // ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Selected Vessels:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             ...selectedVessels.map((vessel) => Text(vessel)).toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
