import 'package:get/get.dart';
import 'package:timesheet/data/api/api_checker.dart';
import 'package:timesheet/data/model/body/post_model.dart';
import 'package:timesheet/data/repository/post_repo.dart';

class CommentController extends GetxController implements GetxService {
  final PostRepo repo;

  CommentController({required this.repo});
  final List<CommentModel> _comments = [];

  List<CommentModel> get comments => _comments;

  initState(List<CommentModel> comments) {
    _comments.clear();
    _comments.addAll(comments);
    update();
  }

  Future<CommentModel> commment(String content, PostModel post) async {
    final CommentModel data = CommentModel(
      content: content,
      post: post,
      user: post.user,
    );
    Response response = await repo.comment(data: data, post: post);
    if (response.statusCode == 200) {
      _comments.add(CommentModel.fromJson(response.body));

      update();
    } else {
      ApiChecker.checkApi(response);
    }
    return CommentModel.fromJson(response.body);
  }
}
