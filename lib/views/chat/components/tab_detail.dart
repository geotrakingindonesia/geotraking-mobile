// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unused_element, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_field, no_leading_underscores_for_local_identifiers, use_super_parameters

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/constants/app_colors.dart';
import 'package:geotraking/core/constants/app_defaults.dart';

class TabDetail extends StatefulWidget {
  final String vesselName;
  const TabDetail({
    Key? key,
    required this.vesselName,
  }) : super(key: key);

  @override
  State<TabDetail> createState() => _TabDetailState();
}

class _TabDetailState extends State<TabDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text('${widget.vesselName}'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        backgroundColor: Colors.white,
        elevation: 0,
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
                                "${widget.vesselName}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Fitur ini di sediakan untuk kapal yang menggunakan Iridium Edge.',
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
                            // DateFormat('d MMM y (HH:mm a)')
                            //     .format(widget.trouble.createAt!),
                            'Monday, 30 Sep 2024 (11:29 AM)',
                            style: const TextStyle(
                                color: Colors.black54,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Form(
                  // key: _key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        // cursorColor: Colors.red,
                        // controller: _responController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        // validator: (value) => Validators.required(value),
                        // onSaved: (value) => _respon = value!,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Type a message',
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // if (widget.trouble.status != 2)
                FloatingActionButton(
                  onPressed: () {},
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
    );
  }
}
