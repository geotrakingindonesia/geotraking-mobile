import 'package:flutter/material.dart';
import 'package:geotraking/core/models/transaction_airtime.dart';
import 'package:geotraking/core/services/transaction_airtime_service.dart';
import 'package:geotraking/views/profile/transaction/components/tab_detail.dart';
import 'package:intl/intl.dart';

class TabProcess extends StatefulWidget {
  const TabProcess({Key? key}) : super(key: key);

  @override
  _TabProcessState createState() => _TabProcessState();
}

class _TabProcessState extends State<TabProcess> {
  Future<List<TransactionAirtime>>? _futureTransactions;

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  void _fetchTransactions() {
    _futureTransactions =
        TransactionAirtimeService().getProcessCategoryTransactionAirtime();
  }

  Future<void> _refreshTransactions() async {
    setState(() {
      _fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshTransactions,
      child: FutureBuilder<List<TransactionAirtime>>(
        future: _futureTransactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No transactions found.'));
          }

          final transactions = snapshot.data!;

          return ListView.separated(
            itemCount: transactions.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final transaction = transactions[index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TabDetail(transaction: transaction),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            transaction.namaKapal ?? 'N/A',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rp. ${transaction.price}',
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Pengajuan Airtime Berhasil',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(height: 6),
                      Text(
                        '${DateFormat('dd-MMM-yyyy').format(transaction.paymentDate ?? DateTime.now())}',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
