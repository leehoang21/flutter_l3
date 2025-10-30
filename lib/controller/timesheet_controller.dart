import 'package:get/get.dart';
import 'package:timesheet/data/api/api_checker.dart';
import 'package:timesheet/data/repository/timesheet_repo.dart';

import '../data/model/body/time_sheet_model.dart';

class TimesheetController extends GetxController implements GetxService {
  final TimeSheetRepo repo;

  TimesheetController({required this.repo});
  final List<TimesheetModel> _timesheets = [];

  List<TimesheetModel> get timesheets => _timesheets;

  @override
  onInit() {
    super.onInit();
    getAll();
  }

  Future<void> getAll() async {
    Response response = await repo.getAll();
    if (response.statusCode == 200) {
      _timesheets.clear();
      for (var tracking in response.body) {
        _timesheets.add(TimesheetModel.fromJson(tracking));
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }
  }
}
