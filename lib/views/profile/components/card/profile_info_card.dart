import 'package:flutter/material.dart';
import 'package:geotraking/core/services/vessel_service.dart';

class ProfileInfoCard extends StatefulWidget {
  @override
  _ProfileInfoCardState createState() => _ProfileInfoCardState();
}

class _ProfileInfoCardState extends State<ProfileInfoCard> {
  int jumlahKapal = 0;
  int airtimeActive = 0;
  final VesselService _vesselService = VesselService();

  @override
  void initState() {
    super.initState();
    fetchCountData();
  }

  Future<void> fetchCountData() async {
    int countVessel = await _vesselService.countDataKapal();
    int countAirtime = await _vesselService.countActiveAirtime();
    setState(() {
      jumlahKapal = countVessel;
      airtimeActive = countAirtime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  '$jumlahKapal',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Jumlah Kapal',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            Container(
              width: 1,
              height: 40,
              color: Colors.black,
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),
            Column(
              children: [
                Text(
                  '$airtimeActive',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Airtime Active',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
