import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:timesheet/data/model/body/post_model.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';
import '../model/param/search_param.dart';

class PostRepo extends GetxService {
  final ApiClient apiClient;

  PostRepo({required this.apiClient});

  Future<Response> search({required SearchParam params, bool isSelf = false}) {
    String url = '${AppConstants.posts}/get-news';
    if (isSelf) {
      url += '-by-user';
    }
    return apiClient.postData(url, json.encode(params.toJson()), null);
  }

  Future<Response> save({required PostModel data, int? id}) {
    String url = AppConstants.posts;
    if (id != null && id > 0) {
      url = "$url/update/$id";
    } else {
      url = "$url/create";
    }
    return apiClient.postData(url, json.encode(data.toJson()), null);
  }

  Future<Response> comment({
    required CommentModel data,
    required PostModel post,
  }) {
    String url = '${AppConstants.posts}/comments/${post.id}';
    return apiClient.postData(
        url,
        json.encode(data
            .copyWith(
              post: post,
            )
            .toJson()),
        null);
  }

  Future<Response> like({
    required CommentModel data,
    required PostModel post,
  }) {
    String url = '${AppConstants.posts}/likes/${post.id}';
    return apiClient.postData(
        url,
        json.encode(data
            .copyWith(
              post: post,
            )
            .toJson()),
        null);
  }
}
