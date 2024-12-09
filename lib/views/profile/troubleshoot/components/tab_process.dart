// ignore_for_file: unused_field, unused_element, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geotraking/core/models/trouble_member.dart';
import 'package:geotraking/core/services/trouble_member_service.dart';
import 'package:geotraking/views/profile/troubleshoot/components/trouble_detail_page.dart';
import 'package:geotraking/views/profile/troubleshoot/components/trouble_preview_tile.dart';
import 'package:intl/intl.dart';

class TabProcess extends StatefulWidget {
  const TabProcess({Key? key}) : super(key: key);

  @override
  State<TabProcess> createState() => _TabProcessState();
}

class _TabProcessState extends State<TabProcess> {
  final TroubleMemberService troubleMemberService = TroubleMemberService();
  String? _errorMessage;
  List<TroubleMember>? _troubleListMember;
  Map<String, dynamic>? _searchResult;

  @override
  void initState() {
    super.initState();
    _fetchTroubleshootList();
  }

  _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _fetchTroubleshootList() async {
    try {
      final troubleList = await troubleMemberService.getProcessTroubleData();
      print('ini process $troubleList');
      setState(() {
        _troubleListMember = troubleList;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  _onSuccessCancel() {
    _showSnackbar('Successful cancel trouble');
  }

  void _reloadData() {
    setState(() {});
  }

  void _onCancel(int index) async {
    final troubleMember = _troubleListMember![index];
    await troubleMemberService.deleteTroubleData(troubleMember.id!);
    _onSuccessCancel();
    _fetchTroubleshootList();
    setState(() {
      _troubleListMember!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _troubleListMember == null
          ? Center(
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
            )
          : ListView.builder(
              itemCount: _troubleListMember!.length,
              itemBuilder: (context, index) {
                final troubleMember = _troubleListMember![index];
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
                      child: TroublePreviewTile(
                        idfull: troubleMember.idfull!,
                        namaKapal: troubleMember.namaKapal,
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
                        onCancel: () {
                          _onCancel(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
