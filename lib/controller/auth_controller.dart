import 'package:get/get.dart';
import 'package:timesheet/data/api/api_checker.dart';
import 'package:timesheet/data/model/body/user.dart';
import 'package:timesheet/data/model/response/token_resposive.dart';
import 'package:timesheet/data/repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo repo;

  AuthController({required this.repo});

  bool _loading = false;
  User _user = User();

  bool get loading => _loading;
  User get user => _user;

  Future<(int, User)> login(String username, String password) async {
    Response response =
        await repo.login(username: username, password: password);
    if (response.statusCode == 200) {
      TokenResponsive tokeBody = TokenResponsive.fromJson(response.body);
      repo.saveUserToken(tokeBody.accessToken!);
      await getCurrentUser();
    } else {
      ApiChecker.checkApi(response);
    }

    return (response.statusCode!, _user);
  }

  updateUser(User user) {
    _user = user;
    update();
  }

  Future<int> register(User user) async {
    Response response = await repo.register(user: user);
    if (response.statusCode == 200) {
      _user = User.fromJson(response.body);
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    return response.statusCode!;
  }

  Future<int> logOut() async {
    Response response = await repo.logOut();
    if (response.statusCode == 200) {
      repo.clearUserToken();
      clearData();
    } else {
      ApiChecker.checkApi(response);
    }
    return response.statusCode!;
  }

  Future<User?> getCurrentUser() async {
    Response response = await repo.getCurrentUser();
    if (response.statusCode == 200) {
      _user = User.fromJson(response.body);
      update();
      return _user;
    } else {
      ApiChecker.checkApi(response);
      return null;
    }
  }

  void clearData() {
    _loading = false;
    _user = User();
  }
}
