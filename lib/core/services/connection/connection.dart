import 'package:mysql1/mysql1.dart';

class Connection {
  // host database office&geotraking
  static ConnectionSettings getSettings() {
    return ConnectionSettings(
      host: '103.154.86.90',
      port: 3306,
      db: 'mygeosat',
      user: 'GEOADM',
      password: 'GEOvAp@y82024',
    );
  }
  // host database apn geotraking
  static ConnectionSettings getSettingsAPN() {
    return ConnectionSettings(
      host: '103.154.86.92',
      port: 3306,
      db: 'mygeosat',
      user: 'geosat',
      password: 'N3wG30s4t2018',
    );
  }
}