import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/models/transaction_airtime.dart';
import 'package:open_file/open_file.dart';
// import 'package:geotraking/views/profile/transaction/components/tab_download.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class TabDetail extends StatelessWidget {
  final TransactionAirtime transaction;

  const TabDetail({Key? key, required this.transaction}) : super(key: key);

  Future<void> generateAndSavePDF(TransactionAirtime transaction) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('INVOICE AIRTIME',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Invoice No: ${transaction.mobileId ?? '0537/GEOSAT/INV/VII/2024'}'),
              pw.Text(
                  'Invoice Date: ${transaction.paymentDate ?? '21 August 2024'}'),
              pw.Text(
                  'Due Date: ${transaction.paymentDate ?? '21 August 2024'}'),
              pw.SizedBox(height: 20),
              pw.Text('Bill to: ${transaction.namaKapal ?? 'KM. MITRA KARYA'}',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold)),
              pw.Text('ID: ${transaction.id ?? '40408687'}'),
              pw.Text('No. SN: ${transaction.idfull ?? '20719'}'),
              pw.Text(
                  'PERIODE: ${transaction.paymentDate ?? '19 September 2024 s/d 18 September 2025'}'),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('DESCRIPTION',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('QTY',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('UNIT PRICE',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('AMOUNT',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                      child: pw.Text(
                          '1 (One) Year Airtime for Transmit Hourly Bluetraker VMS')),
                  pw.Text('1'),
                  pw.Text('6,000,000'),
                  pw.Text('6,000,000'),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Text('Sub Total: Rp 6,000,000'),
              pw.Text('VAT 11%: Rp 660,000'),
              pw.Text('Total: Rp 6,660,000',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text(
                  'Amount Chargeable in Words: Enam juta enam ratus enam puluh ribu rupiah'),
              pw.SizedBox(height: 10),
              pw.Text('Please transfer to our account:'),
              pw.Text('Bank BCA Acc No. 6840.6888.77'),
              pw.Text('an. PT. Geomatika Satelit Indonesia'),
              pw.Text('Cab. Kem Tower'),
              pw.SizedBox(height: 20),
              pw.Text('Jakarta, 21 August 2024'),
              pw.SizedBox(height: 20),
              pw.Text('Best Regards,'),
              pw.Text('PT. GEOMATIKA SATELIT INDONESIA'),
              pw.SizedBox(height: 40),
              pw.Text('Finance'),
              pw.Text('Ayu Tsuriayya'),
            ],
          );
        },
      ),
    );

    try {
      final directory = await getExternalStorageDirectory();
      final path = '${directory!.path}/invoice_airtime.pdf';
      final file = File(path);
      await file.writeAsBytes(await pdf.save());

      // Display success message
      print('PDF saved to: $path');
      // open file pdf
      OpenFile.open(path);
    } catch (e) {
      print('Error saving PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Detail Pembayaran',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'No. Idfull: ${transaction.idfull ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.ship,
                              color: Colors.green[800], size: 40),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${transaction.namaKapal ?? 'N/A'}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                '${transaction.kategori ?? 'N/A'} • ${transaction.type ?? 'N/A'}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _buildDetailRow('Price', 'Rp. ${transaction.price}'),
                      Divider(thickness: 1),
                      _buildStatusTimeline(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await generateAndSavePDF(transaction);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Download Detail Pembayaran',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTimeline() {
    final List<Map<String, String>> steps = [
      {'status': 'Pembayaran Sedang Diverifikasi', 'date': '29 Aug 2024 09:32'},
      {'status': 'Verifikasi Konfirmasi Airtime', 'date': '30 Aug 2024 15:38'},
      {'status': 'Pembayaran Berhasil', 'date': '31 Aug 2024 08:00'},
    ];

    return Column(
      children: steps.map((step) {
        return ListTile(
          leading: Icon(Icons.check_circle, color: Colors.green),
          title: Text(
            step['status']!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            step['date']!,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        );
      }).toList(),
    );
  }
}
