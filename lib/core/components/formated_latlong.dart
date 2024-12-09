class FormatedLatlong {
  String formatLatitude(double? lat) {
    if (lat == null) return '';
    try {
      int degrees = lat.toInt();
      double minutes = (lat - degrees) * 60;
      int minutesInt = minutes.toInt();
      double seconds = (minutes - minutesInt) * 60;
      return '${degrees.abs()} ${degrees < 0 ? 'S' : 'N'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
    } catch (e) {
      return '';
    }
  }

  String formatLongitude(double? lon) {
    if (lon == null) return '';
    try {
      int degrees = lon.toInt();
      double minutes = (lon - degrees) * 60;
      int minutesInt = minutes.toInt();
      double seconds = (minutes - minutesInt) * 60;
      return '${degrees.abs()} ${degrees < 0 ? 'W' : 'E'} ${minutesInt}\' ${seconds.toStringAsFixed(3)}"';
    } catch (e) {
      return '';
    }
  }
}
