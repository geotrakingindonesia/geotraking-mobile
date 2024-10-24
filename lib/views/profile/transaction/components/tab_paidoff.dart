import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class TabPaidOff extends StatelessWidget {
  const TabPaidOff({Key? key}) : super(key: key);

  Future<void> _createAndSavePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Halo', style: pw.TextStyle(fontSize: 40)),
        ),
      ),
    );

    try {
      final outputFile = await _getPublicDownloadsFile();
      await outputFile.writeAsBytes(await pdf.save());
      print('PDF saved to ${outputFile.path}');
      // Open the PDF file
      await OpenFile.open(outputFile.path);
    } catch (e) {
      print('Error saving PDF: $e');
    }
  }

  Future<File> _getPublicDownloadsFile() async {
    final directory = await getExternalStorageDirectory();
    final downloadsDirectory = Directory('${directory!.path}/Download');
    if (!await downloadsDirectory.exists()) {
      await downloadsDirectory.create(recursive: true);
    }
    return File('${downloadsDirectory.path}/test_invoice_geotracking.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Halo', style: Theme.of(context).textTheme.headlineLarge),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (await Permission.storage.request().isGranted) {
                await _createAndSavePdf();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('PDF created and opened!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Permission denied')),
                );
              }
            },
            child: Text('Download PDF'),
          ),
        ],
      ),
    );
  }
}
