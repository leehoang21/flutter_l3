import 'package:get/get.dart';
import 'package:timesheet/data/api/api_checker.dart';
import 'package:timesheet/data/model/body/post_model.dart';
import 'package:timesheet/data/repository/post_repo.dart';

import '../data/model/param/search_param.dart';

class PostController extends GetxController implements GetxService {
  final PostRepo repo;

  PostController({required this.repo});

  final isLast = false.obs;

  SearchParam _params = SearchParam(pageIndex: 1, size: 10);

  Future<List<PostModel>> loadMore(int index) {
    _params = _params.copyWith(pageIndex: index);
    return search(params: _params);
  }

  Future<List<PostModel>> search(
      {required SearchParam params, bool isSelf = false}) async {
    final List<PostModel> posts = [];
    Response response = await repo.search(params: params, isSelf: isSelf);
    if (response.statusCode == 200) {
      posts.clear();
      isLast.value = response.body['last'] as bool;
      final datas = response.body['content'] as List<dynamic>;
      for (var post in datas) {
        posts.add(PostModel.fromJson(post));
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    return posts;
  }

  Future<int> save({required String content, required int? id}) async {
    Response response = await repo.save(
        data: PostModel(content: content, id: id, date: DateTime.now()));
    if (response.statusCode == 200) {
      update();
    } else {
      ApiChecker.checkApi(response);
    }

    return response.statusCode!;
  }

  void commment(CommentModel comment, PostModel post) {}

  Future<int> like(PostModel post) async {
    final CommentModel data = CommentModel(
      type: 0,
      post: post,
      user: post.user,
    );
    Response response = await repo.like(data: data, post: post);
    if (response.statusCode == 200) {
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    return response.statusCode!;
  }
}
