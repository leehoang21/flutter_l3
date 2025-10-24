import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  static Future<bool> hasConnection() async {
    final connection = await Connectivity().checkConnectivity();
    return connection != ConnectivityResult.none;
  }

  static Future<void> listenConnection(
      Function(ConnectivityResult) connected) async {
    Connectivity().onConnectivityChanged.listen((connection) {
      if (connection != ConnectivityResult.none) {
        connected(connection);
      }
    });
  }
}
