
class AssetsVoucher {
  String? assetId;
  String? assetItemId;
  String? assetManagementCode;
  String? assetName;
  String? assetCode;
  int? assetDateOfReception;
  String? assetUseDepartmentId;
  String? assetUseDepartmentName;
  String? assetUseDepartmentCode;
  String? assetManagementDepartmentId;
  String? assetManagementDepartmentCode;
  String? assetManagementDepartmentName;
  String? note;

  AssetsVoucher(
      this.assetId,
      this.assetItemId,
      this.assetManagementCode,
      this.assetName,
      this.assetCode,
      this.assetDateOfReception,
      this.assetUseDepartmentId,
      this.assetUseDepartmentName,
      this.assetUseDepartmentCode,
      this.assetManagementDepartmentId,
      this.assetManagementDepartmentCode,
      this.assetManagementDepartmentName,
      this.note);

  AssetsVoucher.fromJson(Map<String, dynamic> json) {
    assetId = json['assetId'];
    assetItemId = json['assetItemId'];
    assetManagementCode = json['assetManagementCode'];
    assetName = json['assetName'];
    assetCode = json['assetCode'];
    assetDateOfReception = json['assetDateOfReception'];
    assetUseDepartmentId = json['assetUseDepartmentId'];
    assetUseDepartmentName = json['assetUseDepartmentName'];
    assetUseDepartmentCode = json['assetUseDepartmentCode'];
    assetManagementDepartmentId = json['assetManagementDepartmentId'];
    assetManagementDepartmentCode = json['assetManagementDepartmentCode'];
    assetManagementDepartmentName = json['assetManagementDepartmentName'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    return {
      'assetId': assetId,
      'assetItemId': assetItemId,
      'assetManagementCode': assetManagementCode,
      'assetName': assetName,
      'assetCode': assetCode,
      'assetDateOfReception': assetDateOfReception,
      'assetUseDepartmentId': assetUseDepartmentId,
      'assetUseDepartmentName': assetUseDepartmentName,
      'assetUseDepartmentCode': assetUseDepartmentCode,
      'assetManagementDepartmentId': assetManagementDepartmentId,
      'assetManagementDepartmentCode': assetManagementDepartmentCode,
      'assetManagementDepartmentName': assetManagementDepartmentName,
      'note': note,
    };
  }
}
