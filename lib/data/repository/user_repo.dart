import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';
import '../model/body/user.dart';
import '../model/param/search_param.dart';

class UserRepo extends GetxService {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> search({required SearchParam params}) {
    String url = '${AppConstants.users}/searchByPage';

    return apiClient.postData(url, json.encode(params.toJson()), null);
  }

  Future<Response> update({required User data, required int id}) {
    String url = '${AppConstants.users}/update/$id';

    return apiClient.postData(url, json.encode(data.toJson()), null);
  }

  Future<Response> updateMySeft({required User user}) {
    return apiClient.postData('${AppConstants.users}/update-myself',
        json.encode(user.toJson()), null);
  }

  Future<Response> lock({required int id}) {
    return apiClient.getData('${AppConstants.users}/lock/$id');
  }
}
