import 'dart:async';
import 'package:get/get.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class TimeSheetRepo extends GetxService {
  final ApiClient apiClient;

  TimeSheetRepo({required this.apiClient});

  Future<Response> getAll() {
    return apiClient.getData(AppConstants.timesheet);
  }
}
