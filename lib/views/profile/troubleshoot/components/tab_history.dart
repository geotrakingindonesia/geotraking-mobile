// ignore_for_file: unused_element, unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geotraking/core/models/trouble_member.dart';
import 'package:geotraking/core/services/trouble_member_service.dart';
import 'package:geotraking/views/profile/troubleshoot/components/trouble_detail_page.dart';
import 'package:geotraking/views/profile/troubleshoot/components/trouble_preview_tile.dart';
import 'package:intl/intl.dart';

class TabHistory extends StatefulWidget {
  const TabHistory({Key? key}) : super(key: key);

  @override
  State<TabHistory> createState() => _TabHistoryState();
}

class _TabHistoryState extends State<TabHistory> {
  TroubleMemberService troubleMemberService = TroubleMemberService();
  String? _errorMessage;

  List<TroubleMember>? _troubleList;

  @override
  void initState() {
    super.initState();
    _fetchTroubleshootHistoryList();
  }

  Future<void> _fetchTroubleshootHistoryList() async {
    try {
      final troubleList = await troubleMemberService.getHistoryTroubleData();
      // print('ini hasil history $troubleList');
      setState(() {
        _troubleList = troubleList;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_troubleList == null) {
      return Center(
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
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
      );
    }
    return ListView.builder(
      itemCount: _troubleList!.length,
      itemBuilder: (context, index) {
        final troubleMember = _troubleList![index];
        final formattedDate = troubleMember.createAt != null
            ? DateFormat('d MMM, y').format(troubleMember.createAt!)
            : 'Loading';
        final formattedTime = troubleMember.createAt != null
            ? DateFormat('HH:mm a').format(troubleMember.createAt!)
            : 'Loading';

        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: TroublePreviewTile(
            idfull: troubleMember.idfull!,
            namaKapal: troubleMember.namaKapal,
            kategori: troubleMember.kategori,
            type: troubleMember.type,
            custamer: troubleMember.custamer,
            date: formattedDate,
            time: formattedTime,
            status: troubleMember.status!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TroubleDetailPage(trouble: troubleMember),
                ),
              );
            },
            onCancel: () {},
          ),
        );
      },
    );
  }
}