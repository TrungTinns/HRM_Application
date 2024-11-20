

import 'package:hrm_application/core/utils/Platform/platform_options.dart';
import 'package:hrm_application/data/datasources/api/api.dart';

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

  factory DepartmentData.fromJson(Map<String, dynamic> json) {
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
    // Lấy cấu hình platform hiện tại
    final platform = PlatformOptions.currentPlatform;

    // Kiểm tra giá trị của host và port
    print(
        'Using API at: http://${PlatformOptions.host}:${PlatformOptions.port}/api/v1/employee/department');

    // Tạo URL đầy đủ với host và port từ platform
    final apiUrl =
        'http://${PlatformOptions.host}:${PlatformOptions.port}/api/v1/employee/department';
    List<DepartmentData> departments = await fetchAPI<DepartmentData>(
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
