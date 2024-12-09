// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unused_element, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_field, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/core/constants/app_defaults.dart';
import 'package:geotraking/core/models/trouble_member.dart';
import 'package:geotraking/core/models/trouble_member_detail.dart';
import 'package:geotraking/core/services/trouble_member_service.dart';
import 'package:geotraking/core/utils/validators.dart';
import 'package:intl/intl.dart';

class TroubleDetailPage extends StatefulWidget {
  const TroubleDetailPage({Key? key, required this.trouble}) : super(key: key);

  final TroubleMember trouble;

  @override
  State<TroubleDetailPage> createState() => _TroubleDetailPageState();
}

class _TroubleDetailPageState extends State<TroubleDetailPage> {
  final _key = GlobalKey<FormState>();
  final troubleMemberService = TroubleMemberService();
  final _responController = TextEditingController();

  String _respon = '';
  String _keluhan = '';
  String? _errorMessage;
  Timer? _timer;
  List<TroubleMemberDetail>? _commentList;

  @override
  void initState() {
    super.initState();
    _getTroubleComments();
  }

  Future _getTroubleComments() async {
    try {
      final commentList =
          await troubleMemberService.getCommentsTroubleData(widget.trouble.id!);
      print('data $commentList');
      setState(() {
        _commentList = commentList;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      _timer?.cancel();
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  _onSuccess() {
    _showSnackbar('Message has been sent successfully!');
  }

  void _onError(String errorMessage) {
    _showSnackbar(errorMessage);
  }

  void onKirimRespon() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      setState(() {
        _errorMessage = null;
      });
      try {
        await troubleMemberService.storeCommectTrouble(
            widget.trouble.id!, _respon);
        _responController.clear();
        _getTroubleComments();
        setState(() {});
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
        _onError(_errorMessage!);
      }
    }
  }

  void _reloadData() {
    setState(() {});
  }

  Future<void> _showUpdateForm() async {
    final TextEditingController _keluhanController =
        TextEditingController(text: widget.trouble.keluhan);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Trouble'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _keluhanController,
                  onChanged: (value) => _keluhan = value,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Keluhan',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Update'),
              onPressed: () async {
                // await troubleMemberService.updateTroubleshoot(
                //     widget.trouble.id, widget.trouble.idfull, _keluhan);
                await troubleMemberService.updateTroubleData(
                    widget.trouble.id!, _keluhan);
                setState(() {
                  widget.trouble.keluhan = _keluhan;
                });

                _reloadData();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Trouble Details'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(AppDefaults.margin),
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 98, 182, 183),
                      borderRadius: AppDefaults.borderRadius,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.trouble.idfull!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.black),
                              ),
                              if (widget.trouble.status != 2)
                                IconButton(
                                  icon: Icon(
                                    Icons.mode_edit_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  onPressed: _showUpdateForm,
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.trouble.keluhan!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black54),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            DateFormat('d MMM y (HH:mm a)')
                                .format(widget.trouble.createAt!),
                            style: const TextStyle(
                                color: Colors.black54,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  _commentList == null
                      ? Center(
                          child: FutureBuilder(
                            future: Future.delayed(const Duration(seconds: 5)),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text('no comments yet.');
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _commentList?.length ?? 0,
                          itemBuilder: (context, index) {
                            TroubleMemberDetail comment = _commentList![index];
                            return Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                left: comment.adminId != null ||
                                        comment.userGeoId != null ||
                                        comment.isAdminMember != 0 &&
                                            comment.isAdminMember != null
                                    ? 110
                                    : 15,
                                right: comment.adminId != null ||
                                        comment.userGeoId != null ||
                                        comment.isAdminMember != 0 &&
                                            comment.isAdminMember != null
                                    ? 15
                                    : 110,
                              ),
                              padding:
                                  const EdgeInsets.all(AppDefaults.padding),
                              decoration: BoxDecoration(
                                color: comment.adminId != null ||
                                        comment.userGeoId != null ||
                                        comment.isAdminMember != 0 &&
                                            comment.isAdminMember != null
                                    ? Color.fromARGB(255, 151, 222, 206)
                                    : Color.fromARGB(255, 203, 237, 213),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: const Radius.circular(20),
                                  bottomRight: const Radius.circular(20),
                                  topLeft: comment.adminId != null ||
                                          comment.userGeoId != null ||
                                          comment.isAdminMember != 0 &&
                                              comment.isAdminMember != null
                                      ? const Radius.circular(20)
                                      : const Radius.circular(0),
                                  topRight: comment.memberId == null ||
                                          comment.isAdminMember != 0 &&
                                              comment.isAdminMember != null
                                      ? const Radius.circular(0)
                                      : const Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  if (comment.adminId != null ||
                                      comment.userGeoId != null)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        comment.adminId != null
                                            ? Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '${comment.nameAdmin}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color:
                                                              Colors.black54),
                                                ),
                                              )
                                            : Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '${comment.nameUser}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color:
                                                              Colors.black54),
                                                ),
                                              ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${comment.respon}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              DateFormat('d MMM y (HH:mm a)')
                                                  .format(DateTime.parse(
                                                      '${comment.createAt}')),
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  else
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${comment.nameMember}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${comment.responMember}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black54),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              DateFormat('d MMM y (HH:mm a)')
                                                  .format(DateTime.parse(
                                                      '${comment.createAtMember}')),
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          if (widget.trouble.status != 2)
            Container(
              color: Colors.white.withOpacity(0.5),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: _key,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _responController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                validator: (value) =>
                                    Validators.required(value),
                                onSaved: (value) => _respon = value!,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Type a message',
                                  prefixIcon: const Icon(Icons.email,
                                      color: Colors.black),
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                  filled: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (widget.trouble.status != 2)
                        FloatingActionButton(
                          onPressed: onKirimRespon,
                          backgroundColor: Colors.blue,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
