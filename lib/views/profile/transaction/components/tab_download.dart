import 'package:flutter/material.dart';
import 'package:geotraking/core/models/transaction_airtime.dart';

class TabDownload extends StatelessWidget {
  final TransactionAirtime transaction;

  const TabDownload({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INVOICE AIRTIME',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildInvoiceHeader(),
              SizedBox(height: 20),
              _buildInvoiceDetails(),
              SizedBox(height: 20),
              _buildPaymentDetails(),
              SizedBox(height: 20),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Invoice No: ${transaction.mobileId ?? '0537/GEOSAT/INV/VII/2024'}'),
        Text('Invoice Date: ${transaction.paymentDate ?? '21 August 2024'}'),
        Text('Due Date: ${transaction.paymentDate ?? '21 August 2024'}'),
      ],
    );
  }

  Widget _buildInvoiceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bill to: ${transaction.namaKapal ?? 'KM. MITRA KARYA'}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text('ID: ${transaction.id ?? '40408687'}'),
        Text('No. SN: ${transaction.type ?? '20719'}'),
        Text('PERIODE: ${transaction.type ?? '19 September 2024 s/d 18 September 2025'}'),
        SizedBox(height: 10),
        Divider(thickness: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('DESCRIPTION', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('QTY', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('UNIT PRICE', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('AMOUNT', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Divider(thickness: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text('1 (One) Year Airtime for Transmit Hourly Bluetraker VMS')),
            Text('1'),
            Text('6,000,000'),
            Text('6,000,000'),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sub Total: Rp 6,000,000'),
        Text('VAT 11%: Rp 660,000'),
        Text('Total: Rp 6,660,000', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Amount Chargeable in Words: Enam juta enam ratus enam puluh ribu rupiah'),
        SizedBox(height: 10),
        Text('Please transfer to our account:'),
        Text('Bank BCA Acc No. 6840.6888.77'),
        Text('an. PT. Geomatika Satelit Indonesia'),
        Text('Cab. Kem Tower'),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Jakarta, 21 August 2024'),
        SizedBox(height: 20),
        Text('Best Regards,'),
        Text('PT. GEOMATIKA SATELIT INDONESIA'),
        SizedBox(height: 40),
        Text('Finance'),
        Text('Ayu Tsuriayya'),
      ],
    );
  }
}
