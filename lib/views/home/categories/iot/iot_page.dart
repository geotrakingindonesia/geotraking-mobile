// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/components/app_back_button.dart';
// import 'package:geotraking/core/components/banner_rekening.dart';
import 'package:geotraking/core/components/custom_tab_label.dart';
import 'package:geotraking/views/home/categories/iot/components/tab_aiscube.dart';
import 'package:geotraking/views/home/categories/iot/components/tab_fuel.dart';
import 'package:geotraking/views/home/categories/iot/components/tab_rpm.dart';
import 'package:url_launcher/url_launcher.dart';

class IotPage extends StatefulWidget {
  const IotPage({super.key});

  @override
  _IotPageState createState() => _IotPageState();
}

class _IotPageState extends State<IotPage> {
  void _openWhatsApp() async {
    final whatsappUrl =
        "https://wa.me/yourPhoneNumber"; 
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
  // String _selectedRpm = 'Option 0';
  // String _selectedInstallation = 'Option 0';
  // String _selectedFuel = 'Option 0';
  // String _selectedVesselType = 'Vessel 1';
  // String _selectedInterval = '5 Minutes';
  // String _selectedConnection = 'VSAT';
  // TextEditingController _engineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('IoT'),
          leading: const AppBackButton(),
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black,
              ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 196, 218, 210),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Color.fromARGB(255, 106, 156, 137),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    CustomTabLabel(label: 'RPM'),
                    CustomTabLabel(label: 'Fuel Monitoring'),
                    CustomTabLabel(label: 'AIS Cube'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: const TabBarView(
            children: [
              TabRpm(),
              TabFuel(),
              TabAiscube(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openWhatsApp,
          backgroundColor: Colors.green,
          child: Icon(FontAwesomeIcons.whatsapp, color: Colors.white,),
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     title: Text('IoT'),
    //     leading: const AppBackButton(),
    //     backgroundColor: Colors.white,
    //     titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
    //           color: Colors.black,
    //         ),
    //   ),
    //   body: SingleChildScrollView(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         BannerRekening(),
    //         Center(
    //           child: Text(
    //             'Ongoing',
    //             style: TextStyle(fontSize: 14),
    //           ),
    //         ),
    //         Text(
    //           'Rpm',
    //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //         ),
    //         SizedBox(height: 20),
    //         Column(
    //           children: [
    //             ListTile(
    //               title: Text('Include Connection'),
    //               leading: Radio<String>(
    //                 value: 'Option 1',
    //                 groupValue: _selectedRpm,
    //                 onChanged: (value) {
    //                   setState(() {
    //                     _selectedRpm = value!;
    //                   });
    //                 },
    //               ),
    //             ),
    //             ListTile(
    //               title: Text('Exclude Connection'),
    //               leading: Radio<String>(
    //                 value: 'Option 2',
    //                 groupValue: _selectedRpm,
    //                 onChanged: (value) {
    //                   setState(() {
    //                     _selectedRpm = value!;
    //                   });
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //         SizedBox(height: 20),
    //         if (_selectedRpm == 'Option 1') ...[
    //           // Dropdown for Vessel Type
    //           Text('Jenis Kapal'),
    //           DropdownButton<String>(
    //             value: _selectedVesselType,
    //             items: <String>['Vessel 1', 'Vessel 2', 'Vessel 3']
    //                 .map((String value) {
    //               return DropdownMenuItem<String>(
    //                 value: value,
    //                 child: Text(value),
    //               );
    //             }).toList(),
    //             onChanged: (String? newValue) {
    //               setState(() {
    //                 _selectedVesselType = newValue!;
    //               });
    //             },
    //             isExpanded: true,
    //             hint: Text('Select Vessel Type'),
    //           ),
    //           SizedBox(height: 20),
    //           // TextField for Engine
    //           Text('Engine'),
    //           TextField(
    //             controller: _engineController,
    //             keyboardType: TextInputType.number,
    //             decoration: InputDecoration(
    //               labelText: 'Engine',
    //               border: OutlineInputBorder(),
    //             ),
    //           ),
    //           SizedBox(height: 20),
    //           Text('Limit Interval'),
    //           DropdownButton<String>(
    //             value: _selectedInterval,
    //             items: <String>[
    //               '5 Minutes',
    //               '15 Minutes',
    //               '30 Minutes',
    //               '1 Hours'
    //             ].map((String value) {
    //               return DropdownMenuItem<String>(
    //                 value: value,
    //                 child: Text(value),
    //               );
    //             }).toList(),
    //             onChanged: (String? newValue) {
    //               setState(() {
    //                 _selectedInterval = newValue!;
    //               });
    //             },
    //             isExpanded: true,
    //             hint: Text('Select Limit Interval'),
    //           ),
    //           SizedBox(height: 20),
    //           Text('Installation'),
    //           Column(
    //             children: [
    //               ListTile(
    //                 title: Text('JKT'),
    //                 leading: Radio<String>(
    //                   value: 'Option 1',
    //                   groupValue: _selectedInstallation,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       _selectedInstallation = value!;
    //                     });
    //                   },
    //                 ),
    //               ),
    //               ListTile(
    //                 title: Text('Luar JKT'),
    //                 leading: Radio<String>(
    //                   value: 'Option 2',
    //                   groupValue: _selectedInstallation,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       _selectedInstallation = value!;
    //                     });
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 20),
    //           Text('Open API'),
    //           Column(
    //             children: [
    //               ListTile(
    //                 title: Text('Yes'),
    //                 leading: Radio<String>(
    //                   value: 'Option 1',
    //                   groupValue: _selectedInstallation,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       _selectedInstallation = value!;
    //                     });
    //                   },
    //                 ),
    //               ),
    //               ListTile(
    //                 title: Text('No'),
    //                 leading: Radio<String>(
    //                   value: 'Option 2',
    //                   groupValue: _selectedInstallation,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       _selectedInstallation = value!;
    //                     });
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Text('Connection'),
    //           DropdownButton<String>(
    //             value: _selectedConnection,
    //             items: <String>['VSAT', 'Broadband Marine', 'Starlink']
    //                 .map((String value) {
    //               return DropdownMenuItem<String>(
    //                 value: value,
    //                 child: Text(value),
    //               );
    //             }).toList(),
    //             onChanged: (String? newValue) {
    //               setState(() {
    //                 _selectedConnection = newValue!;
    //               });
    //             },
    //             isExpanded: true,
    //             hint: Text('Select Limit Interval'),
    //           ),
    //           SizedBox(height: 20),
    //         ],
    //         Text(
    //           'Fuel Monitoring',
    //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //         ),
    //         SizedBox(height: 20),
    //         Column(
    //           children: [
    //             ListTile(
    //               title: Text('AI FTM'),
    //               leading: Radio<String>(
    //                 value: 'Option 1',
    //                 groupValue: _selectedFuel,
    //                 onChanged: (value) {
    //                   setState(() {
    //                     _selectedFuel = value!;
    //                   });
    //                 },
    //               ),
    //             ),
    //             ListTile(
    //               title: Text('Manual FTM'),
    //               leading: Radio<String>(
    //                 value: 'Option 2',
    //                 groupValue: _selectedFuel,
    //                 onChanged: (value) {
    //                   setState(() {
    //                     _selectedFuel = value!;
    //                   });
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
