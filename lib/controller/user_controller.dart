import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/data/api/api_checker.dart';
import 'package:timesheet/data/repository/user_repo.dart';

import '../data/model/body/user.dart';
import '../data/model/param/search_param.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo repo;

  UserController({required this.repo});
  final List<User> _users = [];
  final isLast = false.obs;

  List<User> get users => _users;
  SearchParam _params = SearchParam(pageIndex: 1, size: 10);

  Future<List<User>> loadMore(int index) {
    _params = _params.copyWith(pageIndex: index);
    return _search(params: _params);
  }

  Future<List<User>> search(String keyword) {
    _params = _params.copyWith(keyWord: keyword);
    return _search(params: _params);
  }

  Future<List<User>> _search({required SearchParam params}) async {
    Response response = await repo.search(params: params);
    if (response.statusCode == 200) {
      _users.clear();
      isLast.value = response.body['last'] as bool;
      final datas = response.body['content'] as List<dynamic>;
      for (var post in datas) {
        _users.add(User.fromJson(post));
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    return _users;
  }

  Future<int> updateUser(User user, int id) async {
    Response response = await repo.update(data: user, id: id);
    if (response.statusCode == 200) {
      final user = User.fromJson(response.body);
      Get.find<AuthController>().updateUser(user);
      final index = _users.indexWhere((element) => element.id == id);
      if (index != -1) {
        _users[index] = user;
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    return response.statusCode!;
  }

  Future<int> updateMySeft(User user) async {
    Response response = await repo.updateMySeft(user: user);
    if (response.statusCode == 200) {
      final user = User.fromJson(response.body);
      Get.find<AuthController>().updateUser(user);
    } else {
      ApiChecker.checkApi(response);
    }
    return response.statusCode!;
  }

  Future<int> lock(int id) async {
    Response response = await repo.lock(id: id);
    if (response.statusCode == 200) {
      final index = _users.indexWhere((element) => element.id == id);
      if (index != -1) {
        _users[index].active = false;
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    return response.statusCode!;
  }
}
