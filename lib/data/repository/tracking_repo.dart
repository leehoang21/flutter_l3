import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:timesheet/data/model/body/tracking_model.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class TrackingRepo extends GetxService {
  final ApiClient apiClient;

  TrackingRepo({required this.apiClient});

  Future<Response> getAll() {
    return apiClient.getData(AppConstants.tracking);
  }

  Future<Response> save({required TrackingModel data, int? id}) {
    String url = AppConstants.tracking;
    if (id != null && id > 0) {
      url = "$url/$id";
    }
    return apiClient.postData(url, json.encode(data.toJson()), null);
  }

  Future<Response> delete({required int id}) {
    return apiClient.deleteData("${AppConstants.tracking}/$id");
  }
}
