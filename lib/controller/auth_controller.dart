import 'package:get/get.dart';
import 'package:timesheet/data/model/response/token_resposive.dart';
import 'package:timesheet/data/repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo repo;

  AuthController({required this.repo});

  bool _loading = false;

  bool get loading => _loading;

  Future<int> login(String username, String password) async {
    _loading = true;
    Response response =
        await repo.login(username: username, password: password);
    if (response.statusCode == 200) {
      TokenResponsive tokeBody = TokenResponsive.fromJson(response.body);
      repo.saveUserToken(tokeBody.accessToken!);
    }
    _loading = false;
    return response.statusCode!;
  }
  Future<bool> logOut() async {
    _loading = true;
    return await repo.logOut();
  }
}
