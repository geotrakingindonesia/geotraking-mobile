// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unused_element, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_field, no_leading_underscores_for_local_identifiers, use_super_parameters

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';

class TabDetail extends StatefulWidget {
  final String vesselName;
  final int senderId;
  const TabDetail({
    Key? key,
    required this.vesselName,
    required this.senderId,
  }) : super(key: key);

  @override
  State<TabDetail> createState() => _TabDetailState();
}

class _TabDetailState extends State<TabDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 21, 38),
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
                      children: [
                        Text('ini ${widget.senderId}', style: TextStyle(color: Colors.white),),
                        BubbleSpecialThree(
                          text: 'Please try and give some feedback on it!',
                          color: Color(0xFF1B97F3),
                          tail: true,
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        BubbleSpecialThree(
                          text: 'Please try and give some feedback on it!',
                          color: Color(0xFFE8E8EE),
                          tail: true,
                          isSender: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          MessageBar(
            onSend: (_) => print(_),
          ),
        ],
      ),
    );
  }
}
