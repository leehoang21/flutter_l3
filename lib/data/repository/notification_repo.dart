import 'dart:async';
import 'package:get/get.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class NotificationRepo extends GetxService {
  final ApiClient apiClient;

  NotificationRepo({required this.apiClient});

  Future<Response> getAll() {
    return apiClient.getData(AppConstants.notifications);
  }
}
