import 'package:flutter/material.dart';
import 'package:hrm_application/core/utils/theme/colors.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/department/Detail/department_detail.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/department/Manage/department_manage.dart';
import 'package:hrm_application/presentation/views/services/employeeServices/Employee/Data/employees_data.dart';


class DepartmentCard extends StatelessWidget {
  final String id;
  final String department;
  final String managerId;
  final String superior;

  DepartmentCard({
    required this.id,
    required this.department,
    required this.managerId,
    required this.superior,
  });

  Future<int> countEmployeesInDepartment(String department) async {
    List<EmployeeData> employees = await fetchEmployees();
    int count = employees.where((employee) => employee.department == department).length;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    department,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
                        DepartmentDetail(
                          id: id,
                          department: department,
                          managerId: managerId,
                          superior: superior,
                        )
                      ));
                    },
                    icon: const Icon(Icons.more_vert)
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => EmployeeofDepartment(
                      initialDepartment: department,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: textColor,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: FutureBuilder<int>(
                future: countEmployeesInDepartment(department),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text(
                      '${snapshot.data} Employees',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
