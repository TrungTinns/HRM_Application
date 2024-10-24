import 'package:hrm_application/API/api.dart';
import 'package:hrm_application/widgets/platform_options.dart';

class DepartmentData {
  final String id;
  final String department;
  final String managerId;
  final String superior;

  DepartmentData({
    required this.id,
    required this.department,
    required this.managerId,
    required this.superior,
  });

  factory DepartmentData.fromJson(Map<String, dynamic> json){
    return DepartmentData(
      id: json['id'],
      department: json['name'],
      managerId: json['managerId'],
      superior: json['parentDepartmentId'],
    );
  }
}

Future<List<DepartmentData>> fetchDepartments() async {
  try {
    final platformOptions = PlatformOptions.currentPlatform;
    final apiUrl =
        'http://${PlatformOptions.host}:${PlatformOptions.port}/api/v1/employee/department';
    List<DepartmentData> departments= await fetchAPI<DepartmentData>(
      apiUrl: apiUrl,
      fromJson: (json) {
        return DepartmentData(
          id: json['id'] ?? " ",
          department: json['name'] ?? " ",
          managerId: json['managerId'] ?? " ",
          superior: json['parentDepartmentId'] ?? " ",
        );
      },
    );
    print('Fetched ${departments.length} departments');
    return departments;
  } catch (e) {
    print('Error fetching departments: $e');
    return [];
  }
}
