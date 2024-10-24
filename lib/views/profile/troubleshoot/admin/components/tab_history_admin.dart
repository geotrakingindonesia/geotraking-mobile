// ignore_for_file: unused_element, unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geotraking/core/models/trouble_all_member.dart';
import 'package:geotraking/core/services/trouble_member_service.dart';
import 'package:geotraking/views/profile/troubleshoot/admin/components/trouble_detail_page_admin.dart';
import 'package:geotraking/views/profile/troubleshoot/admin/components/trouble_preview_tile_admin.dart';
import 'package:intl/intl.dart';

class TabHistoryAdmin extends StatefulWidget {
  const TabHistoryAdmin({Key? key}) : super(key: key);

  @override
  State<TabHistoryAdmin> createState() => _TabHistoryAdminState();
}

class _TabHistoryAdminState extends State<TabHistoryAdmin> {
  final troubleMemberService = TroubleMemberService();
  String? _errorMessage;

  List<TroubleAllMember>? _troubleAllList;

  @override
  void initState() {
    super.initState();
    _fetchTroubleshootAllMemberHistoryList();
  }

  Future _fetchTroubleshootAllMemberHistoryList() async {
    try {
      final troubleList =
          // await troubleMemberService.fetchTroubleshootAllMemberHistoryList();
          await troubleMemberService.getHistoryTroubleDataAdmin();
      setState(() {
        _troubleAllList = troubleList;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
      // _onError(_errorMessage!);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (_troubleAllList == null) {
      return Center(
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
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
      itemCount: _troubleAllList!.length,
      itemBuilder: (context, index) {
        final troubleMember = _troubleAllList![index];
        // final formattedDate = troubleMember.createAt != 'loading..'
        //     ? DateFormat('d MMM, y')
        //         .format(DateTime.parse(troubleMember.createAt))
        //     : 'Loading';
        // final formattedTime = troubleMember.createAt != 'loading..'
        //     ? DateFormat('HH:mm a')
        //         .format(DateTime.parse(troubleMember.createAt))
        //     : 'Loading';
        final formattedDate = troubleMember.createAt != null
            ? DateFormat('d MMM, y').format(troubleMember.createAt!)
            : 'Loading';
        final formattedTime = troubleMember.createAt != null
            ? DateFormat('HH:mm a').format(troubleMember.createAt!)
            : 'Loading';

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TroublePreviewTileAdmin(
                idfull: troubleMember.idfull!,
                namaKapal: troubleMember.namaKapal,
                nameMember: troubleMember.nameMember,
                custamer: troubleMember.custamer,
                date: formattedDate,
                time: formattedTime,
                status: troubleMember.status,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TroubleDetailPageAdmin(trouble: troubleMember),
                    ),
                  );
                },
                onFinished: () {},
              ),
            );
          },
        );
      },
    );
  }
}
