import 'package:get/get.dart';
import 'package:timesheet/data/api/api_checker.dart';
import 'package:timesheet/data/model/body/notification_model.dart';
import 'package:timesheet/data/repository/notification_repo.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo repo;

  NotificationController({required this.repo});
  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  @override
  onInit() {
    super.onInit();
    getAll();
  }

  Future<void> getAll() async {
    Response response = await repo.getAll();
    if (response.statusCode == 200) {
      _notifications.clear();
      for (var notification in response.body) {
        _notifications.add(NotificationModel.fromJson(notification));
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
