import 'package:get/get.dart';
import 'package:timesheet/data/api/api_checker.dart';
import 'package:timesheet/data/model/body/post_model.dart';
import 'package:timesheet/data/repository/post_repo.dart';
import 'package:timesheet/utils/utils.dart';

import '../data/model/param/search_param.dart';

class PostController extends GetxController implements GetxService {
  final PostRepo repo;

  PostController({required this.repo});

  final _sLast = false.obs;

  SearchParam _params = SearchParam(pageIndex: 1, size: 10);

  final List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  @override
  Future<void> onInit() async {
    _params = SearchParam(pageIndex: 1, size: 10);
    await search();
    super.onInit();
  }

  Future<bool> loadMore() async {
    if (_sLast.value) {
      return false;
    }
    _params = _params.copyWith(pageIndex: _params.pageIndex! + 1);
    await search();
    return _sLast.value;
  }

  Future<void> search({bool isSelf = false}) async {
    Response response = await repo.search(params: _params, isSelf: isSelf);
    if (response.statusCode == 200) {
      _posts.clear();
      _sLast.value = response.body['last'] as bool;
      final datas = response.body['content'] as List<dynamic>;
      for (var post in datas) {
        _posts.add(PostModel.fromJson(post));
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<int> save({required String content, required int? id}) async {
    Response response = await repo.save(
        data: PostModel(content: content, id: id, date: DateTime.now()));
    if (response.statusCode == 200) {
      if (isNullEmpty(id)) {
        _posts.add(PostModel.fromJson(response.body));
      } else {
        final index = _posts.indexWhere((post) => post.id == id);
        if (index != -1) {
          _posts[index] = PostModel.fromJson(response.body);
        }
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }

    return response.statusCode!;
  }

  Future<void> like(PostModel post) async {
    final CommentModel data = CommentModel(
      type: 0,
      post: post,
      user: post.user,
    );
    Response response = await repo.like(data: data, post: post);
    if (response.statusCode == 200) {
      final index = _posts.indexWhere((element) => element.id == post.id);
      if (index != -1) {
        _posts[index] = _posts[index].copyWith(likes: [
          ..._posts[index].likes ?? [],
          CommentModel.fromJson(response.body)
        ]);
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
