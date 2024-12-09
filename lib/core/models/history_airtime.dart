class HistoryAirtime {
  int? id;
  DateTime? airtimestart;
  DateTime? airtimeend;

  HistoryAirtime({
    this.id,
    this.airtimestart,
    this.airtimeend,
  });

  factory HistoryAirtime.fromJson(Map<String, dynamic> json) {
    return HistoryAirtime(
      id: int.tryParse(json['id'] ?? ''),
      airtimestart: json['airtime_start'],
      airtimeend: json['airtime_end'],
    );
  }

  @override
  String toString() {
    return 'HistoryAirtime {airtimestart: $airtimestart, airtimeend: $airtimeend}';
  }
}
