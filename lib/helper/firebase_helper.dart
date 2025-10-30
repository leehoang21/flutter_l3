import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:timesheet/utils/utils.dart';

import '../../firebase_options.dart';

class FirebaseHelper extends GetxService {
  late FirebaseApp app;
  late final FirebaseMessaging firebaseMessaging;

  Future init() async {
    app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.requestPermission();
    logger(await firebaseMessaging.getToken());
  }
}
