// // ignore_for_file: library_private_types_in_public_api
// import 'package:flutter/material.dart';
// import 'package:geotraking/core/components/app_back_button.dart';

// class VmsDatabasePage extends StatefulWidget {
//   const VmsDatabasePage({super.key});

//   @override
//   _VmsDatabasePageState createState() => _VmsDatabasePageState();
// }

// class _VmsDatabasePageState extends State<VmsDatabasePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Back'),
//         titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//               color: Colors.black,
//             ),
//         leading: const AppBackButton(),
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         physics: AlwaysScrollableScrollPhysics(),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       // controller: _searchController,
//                       style: TextStyle(color: Colors.black),
//                       decoration: InputDecoration(
//                         labelText: 'Cari Id/Eureport/MessageID/ConfirmCode',
//                         labelStyle: TextStyle(color: Colors.black),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(40)),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(40)),
//                           borderSide: BorderSide(color: Colors.black),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(40)),
//                           borderSide:
//                               BorderSide(color: Colors.black, width: 2.0),
//                         ),
//                       ),
//                       onChanged: (query) {
//                         setState(() {
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geotraking/core/components/app_back_button.dart';
import 'package:geotraking/core/services/vms_monitoring_service.dart';

class VmsDatabasePage extends StatefulWidget {
  const VmsDatabasePage({super.key});

  @override
  _VmsDatabasePageState createState() => _VmsDatabasePageState();
}

class _VmsDatabasePageState extends State<VmsDatabasePage> {
  final TextEditingController _searchController = TextEditingController();
  final VmsMonitoringService _vmsService = VmsMonitoringService();
  Map<String, dynamic>? _searchResult;
  bool _isLoading = false;

  Future<void> _searchDatabase(String query) async {
    setState(() {
      _isLoading = true;
      _searchResult = null; // Reset previous results
    });

    final result = await _vmsService.index(query);

    setState(() {
      _searchResult = result;
      print('-------');
      print(result);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Database Search'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
            ),
        leading: const AppBackButton(),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Cari Id/MessageID/ConfirmCode',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    _searchDatabase(query);
                  }
                },
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_searchResult != null)
                _buildResultWidget()
              else
                const Text(
                  'Masukkan nilai pencarian.',
                  style: TextStyle(color: Colors.black54),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultWidget() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Code: ${_searchResult?['code'] ?? '-'}'),
            Text('Send Date: ${_searchResult?['sendDate'] ?? '-'}'),
            Text('Mobile ID: ${_searchResult?['mobileId'] ?? '-'}'),
            Text('Eureport: ${_searchResult?['eureport'] ?? '-'}'),
            Text('Message ID: ${_searchResult?['messageId'] ?? '-'}'),
            Text('Confirm Code: ${_searchResult?['confirmCode'] ?? '-'}'),
          ],
        ),
      ),
    );
  }
}
