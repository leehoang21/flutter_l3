import 'package:get/get.dart';
import 'package:timesheet/data/api/api_checker.dart';
import 'package:timesheet/data/model/body/tracking_model.dart';
import 'package:timesheet/data/repository/tracking_repo.dart';

class TrackingController extends GetxController implements GetxService {
  final TrackingRepo repo;

  TrackingController({required this.repo});
  final List<TrackingModel> _trackings = [];

  List<TrackingModel> get trackings => _trackings;

  @override
  onInit() {
    super.onInit();
    getAll();
  }

  Future<void> getAll() async {
    Response response = await repo.getAll();
    if (response.statusCode == 200) {
      _trackings.clear();
      for (var tracking in response.body) {
        _trackings.add(TrackingModel.fromJson(tracking));
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<int> save({required TrackingModel data}) async {
    Response response = await repo.save(data: data, id: data.id);
    if (response.statusCode == 200) {
      if (data.id != null) {
        // Update existing tracking
        int index = _trackings.indexWhere((element) => element.id == data.id);
        if (index != -1) {
          _trackings[index] = TrackingModel.fromJson(response.body);
          update();
        }
      } else {
        _trackings.add(TrackingModel.fromJson(response.body));
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }

    return response.statusCode!;
  }

  Future<int> delete(int id) async {
    Response response = await repo.delete(id: id);
    if (response.statusCode == 200) {
      _trackings.removeWhere((element) => element.id == id);
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    return response.statusCode!;
  }
}
